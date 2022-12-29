// import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:socket_io_client/socket_io_client.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// late Socket socket;

// class Socket {

//   handleConnect() async {
//     var prefs = await SharedPreferences.getInstance();
//     var token = prefs.getString("token");
//     print(token);

//     socket = IO.io(
//         'http://18.233.168.44:5000/',
//         OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
//             .setExtraHeaders({'Authorization': "$token"}) // optional
//             .build());
//     socket.connect();
//     socket.onConnect((data) {
//       print("connected");
//       handleGetMessages();
//       socket.on("ONLINE", (data) {
//         handleOnline(data);
//         print(online);
//         // print(data);
//       });
//     });
//     socket.onDisconnect((data) => print("disconnected"));
//     socket.on(
//       "ERROR",
//       (data) {
//         var errorMessage = jsonDecode(data);
//         print("Error" + errorMessage['message']);
//         print(data);
//       },
//     );
//     socket.on("ONLINE", (data) {
//       handleOnline(data);
//       print(online);
//       // print(data);
//     });
//     socket.on("OFFLINE", (data) {
//       // print("offline");
//       handleOffline(data);
//       print(data);
//     });
//     socket.on("MESSAGE_SENT", (data) {
//       print("message sent successfully");
//       // socket.emit("MESSAGES", {
//       //   "lastMesgDatetime": "2022",
//       // });
//       handleGetMessages();
//     });

//     socket.on("MESSAGES", (data) {
//       List uData = jsonDecode(data);
//       handleGetMessages();

//       print("handling messages event");
//     });
//     socket.on("MESSAGE", (data) {
//       print("got a message" + data);
//       handleGetMessages();
//     });
//   }

//   handleGetMessages() async {
//     getChat = getMessageList();
//     getChat.then((value) {
//       setState(() {
//         // value.where((element) => false)
//         messageList = filteredMessageByTime = value;
//       });
//     });
//   }

//   handleGetUserProfile() async {
//     userProfile = getUserProfile();
//     userProfile.then((value) {
//       setState(() {
//         id = value.id!;
//       });
//     });
//   }

//   handleOnline(data) {
//     var userOnline = jsonDecode(data);
//     bool check = online.contains(userOnline['id']);
//     if (check == false) {
//       setState(() {
//         online.add(userOnline['id']);
//       });
//     }
//   }

//   handleOffline(data) {
//     var userOnline = jsonDecode(data);
//     setState(() {
//       online.remove(userOnline['id']);
//     });
//   }
// }
