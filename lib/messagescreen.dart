import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  final String recipientId;
  final String recipientName;
  final String recipientEmail;
  MessageScreen({
    required this.recipientId,
    required this.recipientName,
    required this.recipientEmail,
  });
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _messageController = TextEditingController();
  User? currentUser;
  String? conversationId;
  @override
  void initState() {
    super.initState();
    _initializeCurrentUser();
    _initializeConversation();
  }

  void _initializeCurrentUser() {
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      print('User is not authenticated in the firebase.');
    }
  }

  void _initializeConversation() {
    if (currentUser != null && widget.recipientId.isNotEmpty) {
      final uid1 = currentUser!.uid;
      final uid2 = widget.recipientId;
      if (uid1.compareTo(uid2) < 0) {
        conversationId = '$uid1 _$uid2';
      } else {
        conversationId = '$uid2 _$uid1';
      }
    } else {
      print(
          'User is not authenticated or recipientId is empty or null so authenticate first');
    }
  }

  void _sendMessage() async {
    if (currentUser == null || conversationId == null) {
      print('User not authenticated or conversationId is null.');
      return;
    }
    final messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      try {
        await FirebaseFirestore.instance
            .collection('conversations')
            .doc(conversationId)
            .collection('messages')
            .add({
          'senderId': currentUser!.uid,
          'senderEmail': currentUser!.email ?? '',
          'senderName': currentUser!.displayName ?? '',
          'text': messageText,
          'timestamp': FieldValue.serverTimestamp(),
        });
        await FirebaseFirestore.instance
            .collection('conversations')
            .doc(conversationId)
            .update({'lastMessage': messageText});
        _messageController.clear();
      } catch (e) {
        print('Error sending message: $e');
      }
    } else {
      print('Message is empty.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipientName),
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('conversations')
                .doc(conversationId)
                .collection('messages')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              final messages = snapshot.data?.docs;
              return Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: messages?.length ?? 0,
                  itemBuilder: (context, index) {
                    final messageData =
                        messages![index].data() as Map<String, dynamic>;
                    final messageText = messageData['text'] as String;
                    final senderId = messageData['senderId'] as String;
                    return MessageBubble(
                      message: messageText,
                      senderId: senderId,
                      currentUserUid: currentUser!.uid,
                    );
                  },
                ),
              );
            },
          ),
          Divider(thickness: 2),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(color: Colors.black),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: "Type a message.......",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blueAccent),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final String senderId;
  final String currentUserUid;
  MessageBubble({
    required this.message,
    required this.senderId,
    required this.currentUserUid,
  });
  bool get isSender => senderId == currentUserUid;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSender ? Colors.blue : Colors.greenAccent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isSender ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
