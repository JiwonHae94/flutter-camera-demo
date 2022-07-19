import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import "dart:developer" as developer;

class CameraPreviewView extends StatelessWidget {
  const CameraPreviewView({required this.cameraController});

  final CameraController cameraController;

  @override
  Widget build(BuildContext context) {
    developer.log("here");
    return Container();
  }
}
