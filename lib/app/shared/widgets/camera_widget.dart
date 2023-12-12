import 'package:cuidame/app/utils/utils_logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_camera/simple_camera.dart';

class CameraWidget extends StatefulWidget {
  const CameraWidget({
    super.key,
    this.onChange,
  });

  final Function(XFile? file)? onChange;

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
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
      UtilsLogger().e(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
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
                if (widget.onChange != null) {
                  widget.onChange!(file);
                }
                Get.back();
              },
              onPressedGallery: () async {
                final picker = ImagePicker();
                final photo = await picker.pickImage(source: ImageSource.gallery);
                if (photo != null) {
                  if (widget.onChange != null) {
                    widget.onChange!(photo);
                  }
                  Get.back();
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
                      if (widget.onChange != null) {
                        widget.onChange!(null);
                      }
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
