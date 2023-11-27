import 'dart:io';

import 'package:adv_camera/adv_camera.dart';
import 'package:liveness_cam/liveness_cam.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/registration_controller.dart';

class CameraApp extends StatefulWidget {
  final String id;

  const CameraApp({Key? key, required this.id}) : super(key: key);

  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  //add new line
  final _livenessCam = LivenessCam();

  File? result;

  List<String> pictureSizes = <String>[];
  String? imagePath;
  var _controller = Get.put(RegistrationController());

  @override
  void initState() {
    super.initState();
    _controller = Get.put(RegistrationController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take a Selfie'),
      ),
      body: Center(
        child: Column(
          children: [
            result != null ? Image.file(result!) : Container(),
            const SizedBox(
              height: 20,
            ),
            Builder(builder: (context) {
              return ElevatedButton(
                  onPressed: () {
                    _livenessCam.start(context).then((value) {
                      if (value != null) {
                        setState(() {
                          result = value;
                          _controller.uploadImage(value);
                        });
                      }
                    });
                  },
                  child: const Text(
                    "Start",
                    style: TextStyle(fontSize: 19),
                  ));
            })
          ],
        ),
      ),

    );
  }

  AdvCameraController? cameraController;

  _onCameraCreated(AdvCameraController controller) {
    this.cameraController = controller;

    this.cameraController!.getPictureSizes().then((pictureSizes) {
      setState(() {
        this.pictureSizes = pictureSizes ?? <String>[];
      });
    });
    print('Camera Created');
  }

  Widget buildFlashSettings(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text("Flash Setting"),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            child: Row(
              children: [
                TextButton(
                  child: Text("Auto"),
                  onPressed: () {
                    cameraController!.setFlashType(FlashType.auto);
                  },
                ),
                TextButton(
                  child: Text("On"),
                  onPressed: () {
                    cameraController!.setFlashType(FlashType.on);
                  },
                ),
                TextButton(
                  child: Text("Off"),
                  onPressed: () {
                    cameraController!.setFlashType(FlashType.off);
                  },
                ),
                TextButton(
                  child: Text("Torch"),
                  onPressed: () {
                    cameraController!.setFlashType(FlashType.torch);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildRatioSettings(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text("Ratio Setting"),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            child: Row(
              children: [
                TextButton(
                  child: Text(Platform.isAndroid ? "1:1" : "Low"),
                  onPressed: () {
                    cameraController!.setPreviewRatio(CameraPreviewRatio.r1);
                    cameraController!.setSessionPreset(CameraSessionPreset.low);
                  },
                ),
                TextButton(
                  child: Text(Platform.isAndroid ? "4:3" : "Medium"),
                  onPressed: () {
                    cameraController!.setPreviewRatio(CameraPreviewRatio.r4_3);
                    cameraController!
                        .setSessionPreset(CameraSessionPreset.medium);
                  },
                ),
                TextButton(
                  child: Text(Platform.isAndroid ? "11:9" : "High"),
                  onPressed: () {
                    cameraController!.setPreviewRatio(CameraPreviewRatio.r11_9);
                    cameraController!
                        .setSessionPreset(CameraSessionPreset.high);
                  },
                ),
                TextButton(
                  child: Text(Platform.isAndroid ? "16:9" : "Best"),
                  onPressed: () {
                    cameraController!.setPreviewRatio(CameraPreviewRatio.r16_9);
                    cameraController!
                        .setSessionPreset(CameraSessionPreset.photo);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildImageOutputSettings(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text("Image Output Setting"),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: this.pictureSizes.map((pictureSize) {
              return TextButton(
                child: Text(pictureSize),
                onPressed: () {
                  cameraController!.setPictureSize(
                      int.tryParse(pictureSize.substring(
                              0, pictureSize.indexOf(":"))) ??
                          0,
                      int.tryParse(pictureSize.substring(
                              pictureSize.indexOf(":") + 1,
                              pictureSize.length)) ??
                          0);
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
