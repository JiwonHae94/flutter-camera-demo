
import 'package:flutter/cupertino.dart';
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
      _isPermissionGranted = requestResult.any((element) => element = false);
    });
  }


  @override
  void initState() {
    super.initState();
    requestPermission(permissions: [Permission.camera]);
  }

  @override
  Widget build(BuildContext context) {

    developer.log("permission granted : $_isPermissionGranted");

    if(_isPermissionGranted){

    }else{

    }
    return Container();
  }
}
