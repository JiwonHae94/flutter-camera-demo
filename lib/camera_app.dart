import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_camera_demo/presentation/camera_preview_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:developer' as developer;

class CameraApp extends StatefulWidget {
  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp>{
  var _isPermissionGranted = false;

  Future<void> requestPermission({required List<Permission> permissions}) async {
    final request = await permissions.request();
    final requestResult = request.values.map((e) => e.isGranted);


    setState((){
      _isPermissionGranted = !requestResult.any((element) => element = false);
      getCameras();
    });
  }


  Future<List<CameraDescription>?> getCameras() async{
    final cameras = await availableCameras();
    setState((){
      _cameras = cameras;
    });
  }

  @override
  void initState() {
    super.initState();
    requestPermission(permissions: [Permission.camera]);
  }

  List<CameraDescription> _cameras = <CameraDescription>[];


  @override
  Widget build(BuildContext context) {
    developer.log("permission granted : $_isPermissionGranted");

    if(_isPermissionGranted && _cameras.length > 0){
      return CameraPreviewView(cameraController: CameraController(_cameras[0], ResolutionPreset.max));
    }else{

    }
    return Container();
  }
}
