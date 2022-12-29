// ignore_for_file: avoid_print, duplicate_ignore

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatSocket extends StatefulWidget {
  const ChatSocket({Key? key}) : super(key: key);

  @override
  State<ChatSocket> createState() => _ChatSocketState();
}

// STEP1:  Stream setup
class StreamSocket {
  final _socketResponse = StreamController<String>();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

StreamSocket streamSocket = StreamSocket();

class _ChatSocketState extends State<ChatSocket> {
  late Socket socket;
  List dataList = [];

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    handleConnect();
    super.initState();
  }

  handleSendMessage() {
    var messageMap = {
      "clientMesgId": "1",
      "mesgType": "text",
      "message": "This is just a text",
      "fileUrl": "",
      "fileName": "",
      "receiverId": "2",
      "propertyId": "4",
      "sentAt": "now",
    };
    socket.emit(
      'MESSAGE',
      messageMap,
    );
    // socket.onAny((DELIVERED, data) => print(data));

    // socket.onAny((message_sent, data) => print(data));
    // socket.on('MESSAGE', (data) => print(data));

    // socket.on('MESSAGE', (data) => print(data));

    // print("message sent");
    // streamSocket.addResponse;
  }

  // ignore: duplicate_ignore
  handleConnect() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    socket = io(
        'http://80.241.208.165:5000/',
        OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({'Authorization': '$token'}) // optional
            .build());
    socket.connect();
    // ignore: avoid_print
    socket.onConnecting((data) => print("Connecting"));
    socket.onConnectError((data) => print(data));
    socket.onConnect((data) {
      print("connected");
    });
    socket.on('MESSAGE_SENT', (data) {
      streamSocket.addResponse;
      dataList = data;
      print(dataList);
      // print('data added');
    });
    // print(streamSocket.getResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Socket IO"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Center(
          //   child: ElevatedButton(
          //     onPressed: () async {
          //       // handleSendMessage();
          //       socket!.emit(
          //         'message',
          //         {
          //           "mesgType": "text",
          //           "message": "This is just a text",
          //           "receiverId": "1",
          //         },
          //       );
          //     },
          //     child: Text("Send Message"),
          //   ),
          // ),
          StreamBuilder(
              stream: streamSocket.getResponse,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text("Something went wrong"));
                }
                if (snapshot.data == null) {
                  print(snapshot.data);
                  return Center(
                      child: Column(
                    children: [
                      const Text("No Message Yet"),
                      ElevatedButton(
                        onPressed: () async {
                          handleSendMessage();
                        },
                        child: const Text("Send Message"),
                      ),
                    ],
                  ));
                }
                if (snapshot.hasData) {
                  // print("snapshot" + snapshot.data.toString());
                  return const Text("snapshot.data");
                }
                return const Center(child: CircularProgressIndicator());
              })
        ],
      ),
    );
  }
}
