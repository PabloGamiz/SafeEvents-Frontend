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
    String algo = prefs.getString('email');
    print("algo -->");
    print(algo);
    myName = algo;
    database.getChatRooms(myName).then((value) {
      setState(() {
        chatRoomsStream = value;
      });
    });
  }

  Widget chatRoomList() {
    return StreamBuilder(
        stream: chatRoomsStream,
        builder: (context, snapshot) {
          print("dentro del build");
          print(myName);
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    print("dentro del builder");
                    print(snapshot.data.docs[index]
                        .data()["chatroomid"]
                        .toString());
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
    print(myName);
    getUser();
    print("email obtenido de sharedpreferences ->");
    print(myName);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        GestureDetector(
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
                  height: 45,
                  width: 45,
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
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
