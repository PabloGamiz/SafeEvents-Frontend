import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/database.dart';
import 'chat_screen.dart';

class ChatGeneralScreen extends StatefulWidget {
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatGeneralScreen> {
  DatabaseMethods database = new DatabaseMethods();

  Stream chatRoomsStream;

  String myName;

  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    myName = prefs.getString('email');
  }

  Widget chatRoomList() {
    return StreamBuilder(
        stream: chatRoomsStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return ChatRoomTile(
                        snapshot.data.docs[index]
                            .data()["chatroomid"]
                            .toString()
                            .replaceAll("_", "")
                            .replaceAll(myName, ""),
                        snapshot.data.docs[index].data()["chatroomid"]);
                  })
              : Center(
                  child: Text(
                    "You currently have no opened chats",
                    style: TextStyle(color: Colors.white),
                  ),
                );
        });
  }

  void initState() {
    getUser();
    database.getChatRooms(myName).then((value) {
      chatRoomsStream = value;
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("pantalla del chat"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: chatRoomList(),
      ),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String userName;
  final String chatRoom;

  ChatRoomTile(this.userName, this.chatRoom);

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(
                      chatRoomId: chatRoom,
                    )));
      },
      child: Container(
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                child: Text(
                  "${userName.substring(0, 1)}",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(userName),
          ],
        ),
      ),
    );
  }
}
