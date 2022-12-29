import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';

class ExternalDirScreen extends StatefulWidget {
  const ExternalDirScreen({Key? key}) : super(key: key);

  @override
  State<ExternalDirScreen> createState() => _ExternalDirScreenState();
}

class _ExternalDirScreenState extends State<ExternalDirScreen> {
  List<String> _exPath = [];

  @override
  void initState() {
    super.initState();

    getPath();
  }

// Get storage directory paths
  // Like internal and external (SD card) storage path
  Future<void> getPath() async {
    List<String> paths;
    // getExternalStorageDirectories() will return list containing internal storage directory path
    // And external storage (SD card) directory path (if exists)
    paths = await ExternalPath.getExternalStorageDirectories();

    setState(() {
      _exPath = paths; // [/storage/emulated/0, /storage/B3AE-4D28]
    });
  }

  // To get public storage directory path like Downloads, Picture, Movie etc.
  // Use below code

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: ListView.builder(
          itemCount: _exPath.length,
          itemBuilder: (context, index) {
            return Center(child: Text("${_exPath[index]}"));
          }),
    );
  }
}
