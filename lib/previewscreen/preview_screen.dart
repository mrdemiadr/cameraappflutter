import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:path/path.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key, required this.picture});

  final XFile picture;
  Future<ByteData> getBytesFromFile() async {
    Uint8List byte = File(picture.path).readAsBytesSync();
    return ByteData.view(byte.buffer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview Screen')),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.file(File(picture.path), fit: BoxFit.cover, width: 250),
          const SizedBox(height: 24),
          Text(picture.name),
          IconButton(
            onPressed: () {
              getBytesFromFile().then((bytes) => Share.file(
                  'Share via:',
                  basename(picture.path),
                  bytes.buffer.asUint8List(),
                  'image/png'));
            },
            icon: const Icon(Icons.share),
          ),
        ]),
      ),
    );
  }
}
