import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CameraPreviewView extends StatelessWidget {
  CameraPreviewView({required this.cameraController});

  final logger = Logger(
      printer: PrettyPrinter()
  );

  final CameraController cameraController;

  @override
  Widget build(BuildContext context) {
    logger.d("here");
    return MaterialApp(
      home: CameraPreview(this.cameraController),
    );
  }
}