import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_camera/simple_camera.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final simpleCamera = SimpleCamera();

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  void initCamera() async {
    try {
      simpleCamera.initializeCamera().then((value) {
        setState(() {});
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SimpleCameraPreview(
              simpleCamera: simpleCamera,
              onPressedTakePicture: (file) {
                Get.back<XFile>(result: file);
              },
              onPressedGallery: () async {
                final picker = ImagePicker();
                final photo = await picker.pickImage(source: ImageSource.gallery);
                if (photo != null) {
                  Get.back<XFile>(result: photo);
                }
              },
            ),
            Positioned(
              top: 16,
              left: 16,
              child: SizedBox(
                width: 50,
                height: 50,
                child: Material(
                  color: Colors.black.withOpacity(0.5),
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {
                      Get.back();
                    },
                    child: const Center(
                      child: Icon(
                        Icons.close,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
