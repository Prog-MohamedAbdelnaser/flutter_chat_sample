import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/painting.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextEditingController = TextEditingController();
  User _firebaseUser;
  String messageText;

  void getCurrentUser() {
    _firebaseUser = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    getCurrentUser();

    //getMessages();

    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                logOut();
                //Implement logout functionality
              }),
        ],
        title: Text('${_firebaseUser.email.toString()}'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextEditingController,
                      onChanged: (value) {
                        messageText = value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      // created: firebase.database.ServerValue.TIMESTAMP
                      final time = Timestamp.now();
                      print("onDataTime ${time.millisecondsSinceEpoch}");

                      _firestore
                          .collection('messages')
                          .add({
                            'text': messageText,
                            'senderId': _firebaseUser.email,
                            'created_at': time
                          })
                          .asStream()
                          .listen((event) {
                            print("onData");
                          }, onError: (onError) {
                            print("onError");
                          }, onDone: () {
                            messageTextEditingController.clear();
                            print("onDone");
                          });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void logOut() {
    var signOut = _auth.signOut();
    signOut.whenComplete(() {
      Navigator.pop(context);
    });
    signOut.catchError((e) {
      print(e);
    });
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User _firebaseUser = _auth.currentUser;

    return StreamBuilder<QuerySnapshot>(
      stream:
          _firestore.collection('messages').orderBy('created_at').snapshots(),
      builder: (context, snapshot) {
        List<MessageBubble> messagesWidgets = [];

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
            ),
          );
        }

        final messages = snapshot.data.documents.reversed;
        for (var message in messages) {
          messagesWidgets.add(MessageBubble(
            message: message.get(
              'text',
            ),
            sender: message.get('senderId'),
            isMe: _firebaseUser.email == message.get('senderId').toString(),
          ));
        }

        return Expanded(
          child: ListView(
            reverse: true,
            children: messagesWidgets,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String sender;
  final String message;
  final bool isMe;

  const MessageBubble({this.sender, this.message, this.isMe});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(color: Colors.black38),
          ),
          SizedBox(
            height: 2,
          ),
          Material(
            elevation: 5,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))
                : BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                message != null ? message : "Removed",
                style: TextStyle(color: isMe ? Colors.white : Colors.black45),
              ),
            ),
          )
        ],
      ),
    );
  }
}
