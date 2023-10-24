// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:untitled/homescreen.dart';
// import 'package:untitled/messagescreen.dart';
//
// class ChatScreen extends StatefulWidget {
//   const ChatScreen({Key? key});
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 100,
//         elevation: 1,
//         backgroundColor: Colors.white,
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.logout,
//               color: Colors.black,
//             ),
//             onPressed: () {
//               signOut();
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Messages',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               TextField(
//                 textAlign: TextAlign.start,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.blue),
//                     borderRadius: BorderRadius.all(Radius.circular(30)),
//                   ),
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 9, horizontal: 15),
//                   prefixIcon: Icon(Icons.search),
//                   hintText: (" Search Messages"),
//                 ),
//               ),
//               SizedBox(
//                 height: 18.0,
//               ),
//               Message(
//                 recipientId: 'User1UserID',
//                 recipientName: 'Ayesha',
//               ),
//               // Message(
//               //   recipientId: 'User2UserID',
//               //   recipientName: 'User 2',
//               // ),
//               // Message(
//               //   recipientId: 'User3UserID',
//               //   recipientName: 'User 3',
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void signOut() async {
//     try {
//       await FirebaseAuth.instance.signOut();
//       await GoogleSignIn().signOut();
//
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomeScreen()),
//       );
//     } catch (e) {
//       print("Error during sign out: $e");
//     }
//   }
// }
//
// class Message extends StatelessWidget {
//   final String recipientId;
//   final String recipientName;
//
//   Message({
//     required this.recipientId,
//     required this.recipientName,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Material(
//           elevation: 1,
//           borderRadius: BorderRadius.circular(10.0),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             padding: const EdgeInsets.all(5.0),
//             child: Material(
//               child: ListTile(
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => MessageScreen(
//                         recipientId: recipientId,
//                         recipientName: recipientName,
//                         secondAccountId: 'nailaaslamaslam93@gmail.com',
//                       ),
//                     ),
//                   );
//                 },
//                 leading: Container(
//                   child: Image.asset(
//                     'assets/images/profile12.png',
//                     width: 50,
//                   ),
//                 ),
//                 title: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       recipientName,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     Text(
//                       "11:00",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold, color: Colors.black),
//                     ),
//                   ],
//                 ),
//                 subtitle: Text(
//                   'Hey, i am your whattsapp user',
//                   style: TextStyle(color: Colors.black, fontSize: 13),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled/homescreen.dart';

import 'messagescreen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Map<String, String>> recipients = [
    {'recipientId': 'User1UserID', 'recipientName': 'Ayesha'},
    {'recipientId': 'User2UserID', 'recipientName': 'User 2'},
    {'recipientId': 'User3UserID', 'recipientName': 'User 3'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 1,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () {
              signOut();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Messages',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 9, horizontal: 15),
                  prefixIcon: Icon(Icons.search),
                  hintText: (" Search Messages"),
                ),
              ),
              SizedBox(
                height: 18.0,
              ),
              // Use ListView.builder to create Message widgets for each recipient
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: recipients.length,
                itemBuilder: (context, index) {
                  final recipientId = recipients[index]['recipientId'];
                  final recipientName = recipients[index]['recipientName'];
                  return Message(
                    recipientId: 'User1UserID',
                    recipientName: 'Ayesha',
                    // Message(
                    //   recipientId: 'User2UserID',
                    //   recipientName: 'User 2',
                    // ),
                    // Message(
                    //   recipientId: 'User3UserID',
                    //   recipientName: 'User 3',
                    // ),
//             ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      print("Error during sign out: $e");
    }
  }
}

class Message extends StatelessWidget {
  final String recipientId;
  final String recipientName;

  Message({
    required this.recipientId,
    required this.recipientName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.all(5.0),
            child: Material(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MessageScreen(
                        recipientId: recipientId,
                        recipientName: recipientName,
                        recipientEmail: '',
                      ),
                    ),
                  );
                },
                leading: Container(
                  child: Image.asset(
                    'assets/images/profile12.png',
                    width: 50,
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      recipientName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "11:00",
                      style: TextStyle(
                          // fontWeight: FontWeight bold, color: Colors.black
                          ),
                    ),
                  ],
                ),
                subtitle: Text(
                  'Hey, I am your WhatsApp user',
                  style: TextStyle(color: Colors.black, fontSize: 13),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
