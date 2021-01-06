import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'EsdevenimentsRecomanats.dart';
import 'services/database.dart';
import 'Structure.dart';
import 'http_models/message_model.dart';
import 'http_models/user_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final DatabaseMethods database = DatabaseMethods();

class ChatScreen extends StatefulWidget {
  final String chatRoomId;

  ChatScreen({this.chatRoomId});

  @override
  _ChatScreenState createState() => _ChatScreenState(this.chatRoomId);
}

class _ChatScreenState extends State<ChatScreen> {
  final String chatRoomId;

  _ChatScreenState(this.chatRoomId);

  _sendMessageArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message..',
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              _sendMessage();
            },
          ),
        ],
      ),
    );
  }

  DatabaseMethods database = new DatabaseMethods();
  TextEditingController messageController = new TextEditingController();

  Stream chatMessageStream;
  String myName;

  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    myName = prefs.getString('email');
  }

  // ignore: non_constant_identifier_names
  Widget ChatMessageList() {
    return StreamBuilder(
        stream: chatMessageStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return MessageTile(
                        snapshot.data.docs[index].data()["message"],
                        snapshot.data.docs[index].data()["sendBy"] == myName);
                  })
              : Container();
        });
  }

  void initState() {
    getUser();
    database.getConversationMessages(widget.chatRoomId).then((value) {
      setState(() {
        chatMessageStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          chatRoomId.replaceAll("_", "").replaceAll(myName, ""),
          style: TextStyle(color: Colors.white),
        ),
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              });
        }),
      ),
      body: Container(
        child: Column(
          children: [
            /*Container(
              height: 60,
              color: Colors.blueAccent,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      goBack();
                    },
                    child: Icon(Icons.arrow_back, color: Colors.blue),
                  ),
                  Center(
                    child: Text(
                      chatRoomId.replaceAll("_", "").replaceAll(myName, ""),
                      style: TextStyle(color: Colors.white, fontSize: 19),
                    ),
                  ),
                ],
              ),
            ),*/
            Expanded(
              child: ChatMessageList(),
            ),
            Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.lightBlue[100],
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context).missatgechat,
                            hintStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          _sendMessage();
                        },
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(40)),
                          padding: EdgeInsets.all(12),
                          child: Center(
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  _sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendBy": myName,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      database.addConversationMessages(widget.chatRoomId, messageMap);
      messageController.text = "";
      database.getConversationMessages(widget.chatRoomId).then((value) {
        setState(() {
          chatMessageStream = value;
        });
      });
    }
  }

  _goBack() {
    //Depenent de si venim de events generals o de recomanats anar a un o altre
    bool veDeRecomanats = false;
    if (!veDeRecomanats) {
      runApp(MaterialApp(
        home: Structure(),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''),
          const Locale('es', ''),
          const Locale('ca', ''),
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode)
              return supportedLocale;
          }
          return supportedLocales.first;
        },
      ));
    } else {
      runApp(MaterialApp(
        home: EsdevenimentsRecomanats(),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''),
          const Locale('es', ''),
          const Locale('ca', ''),
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode)
              return supportedLocale;
          }
          return supportedLocales.first;
        },
      ));
    }
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;
  MessageTile(this.message, this.sendByMe);

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: sendByMe ? 24 : 24, right: sendByMe ? 24 : 24, bottom: 10),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: sendByMe ? Colors.blue : Colors.lightBlueAccent[100],
          borderRadius: sendByMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomLeft: Radius.circular(23),
                )
              : BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomRight: Radius.circular(23),
                ),
        ),
        child: Text(message,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 17,
            )),
      ),
    );
  }
}
