// import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:socket_io_client/socket_io_client.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// late Socket socket;
// List online = [];

// handleConnect(String chatId) async {
//   var prefs = await SharedPreferences.getInstance();
//   var token = prefs.getString("token");
//   print(token);

//   socket = IO.io(
//       'http://18.233.168.44:5000/',
//       OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
//           .setExtraHeaders({'Authorization': "$token"}) // optional
//           .build());
//   socket.connect();
//   socket.onConnect((data) {
//     print("connected");
//   });
//   socket.onDisconnect((data) => print("disconnected"));
//   socket.on(
//     "ERROR",
//     (data) {
//       var errorMessage = jsonDecode(data);
//       print("Error" + errorMessage['message']);
//       print(data);
//     },
//   );
//   // socket check typing status
//   // if (messageController.text)
//   socket.on("START_TYPING", (data) {
//     print(data);
//     if ((chatId).toString() == data['chatid']) {

//     }
//   });
//   socket.on("STOP_TYPING", (data) {
//     if (chatId == data['chatid']) {
//     }
//   });

//   socket.on("ONLINE", (data) {
//     handleOnline(data);
//     print(online);
//     // print(data);
//   });
//   socket.on("OFFLINE", (data) {
//     // print("offline");
//     handleOffline(data);
//     print(data);
//   });
//   socket.on("MESSAGE_SENT", (data) {
//     print("message sent successfully");

//     handleGetMessages();
//   });

//   socket.on("MESSAGES", (data) {
//     handleGetMessages();
//     print("handling messages event");
//   });
//   socket.on("MESSAGE", (data) {
//     print("got a message" + data);
//     handleGetMessages();

//       handleScroll();

//   });
// }

// handleOnline(data) {
//   var userOnline = jsonDecode(data);
//   online.add(userOnline['id']);
// }

// handleOffline(data) {
//     var userOnline = jsonDecode(data);
//     online.remove(userOnline['id']);
// }


//   handleGetMessages() async {
//     getChat = getMessageList();
//     getChat.then((value) {
//         handleScroll();
//         messageList = value;
//         myMessage = messageList[widget.chatIndex].messages!.toList();
//         // myMessage.add(messages);
//       });
//   }