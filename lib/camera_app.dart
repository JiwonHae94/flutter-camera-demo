import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_camera_demo/presentation/camera_preview_view.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:developer' as developer;

class CameraApp extends StatefulWidget {
  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  var _isPermissionGranted = false;

  final logger = Logger(
      printer: PrettyPrinter()
  );


  late CameraController _cameraController;

  Future<void> requestPermission({required List<Permission> permissions}) async {
    final request = await permissions.request();
    final requestResult = request.values.map((e) => e.isGranted);

    _isPermissionGranted = !requestResult.any((element) => element = false);

    if (_isPermissionGranted) {
      getCameraController();
    }
  }

  Future<CameraController?> getCameraController() async {
    final cameras = await availableCameras();
    _cameras = cameras;

    final cameraController = CameraController(_cameras[0], ResolutionPreset.max);
    cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _cameraController = cameraController;
      });
    }).catchError((Object e){
      if(e is CameraException){
        switch (e.code) {
          case 'CameraAccessDenied':
            logger.e('User denied camera access.');
            break;
          default:
            logger.e('Handle other errors.');
            break;
        }
      }
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
    if(_cameraController.value.isInitialized){
      logger.d("camera initialized");
      return CameraPreviewView(cameraController: _cameraController);
    }else{
      return Container();
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }
}
