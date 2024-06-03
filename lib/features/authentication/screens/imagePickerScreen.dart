/*import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      _controller = CameraController(cameras[0], ResolutionPreset.medium);
      _initializeControllerFuture = _controller?.initialize();
      _initializeControllerFuture?.then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller!);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(width: 10),
          FloatingActionButton(
            backgroundColor: Color(0xFF2B963F),
            child: Icon(Icons.photo_library),
            onPressed: () async {
              final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                final savedImage = await _saveImageToGallery(image.path);
                if (savedImage != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DisplayPictureScreen(imagePath: savedImage),
                    ),
                  );
                }
              }
            },
          ),
          SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(bottom: 35),
            child: FloatingActionButton(
              backgroundColor: Color(0xFFAACA61),
              child: Icon(Icons.camera_alt),
              onPressed: () async {
                try {
                  await _initializeControllerFuture;
                  final XFile? picture = await _controller?.takePicture();
                  if (picture != null) {
                    final savedImage = await _saveImageToGallery(picture.path);
                    if (savedImage != null) {

                    }
                  }
                } catch (e) {
                  print(e);
                }
              },
            ),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            backgroundColor: Color(0xFF2B963F),
            child: Icon(Icons.cameraswitch_sharp),
            onPressed: () async {
              try {
                await _initializeControllerFuture;
                CameraDescription? currentCameraDescription = _controller?.description;
                final cameras = await availableCameras();
                int currentCameraIndex = cameras.indexWhere((camera) => camera == currentCameraDescription);
                int nextCameraIndex = (currentCameraIndex + 1) % cameras.length;
                CameraDescription nextCameraDescription = cameras[nextCameraIndex];
                await _controller?.dispose();
                _controller = CameraController(nextCameraDescription, ResolutionPreset.medium);
                _initializeControllerFuture = _controller?.initialize();
                setState(() {});
              } catch (e) {
                print(e);
              }
            },
          ),
        ],
      ),
    );
  }

  Future<String?> _saveImageToGallery(String imagePath) async {
    try {
      final result = await ImageGallerySaver.saveFile(imagePath);
      return result['filePath'];
    } catch (e) {
      print(e);
      return null;
    }
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resim'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Image.file(File(imagePath)),
    );
  }
}
*/


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'fishDetectScreen.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> with SingleTickerProviderStateMixin {
  File? image;
  final picker = ImagePicker();
  List<dynamic>? _outputs = [];
  bool isOpened = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
        _processImage();
      });
    } else {
      print("No image selected.");
    }
  }

  void _processImage() {
    // Simulate image processing and set outputs
    setState(() {
      _outputs = [
        {'index': 0, 'label': 'Akya Balığı'}
      ]; // Replace with actual image processing logic
      // After processing, navigate to the FishDetectScreen
      Get.to(FishDetectScreen());
    });
  }

  void _toggleMenu() {
    setState(() {
      isOpened = !isOpened;
      if (isOpened) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Balık Tespiti"),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: isOpened,
            child: Transform.translate(
              offset: Offset(_animation.value * -60, 0),
              child: FloatingActionButton(
                backgroundColor: Colors.grey[200],
                child: const Icon(Icons.photo_library, color: Colors.black),
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                mini: true,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Visibility(
            visible: isOpened,
            child: Transform.translate(
              offset: Offset(_animation.value * -120, 0),
              child: FloatingActionButton(
                backgroundColor: Colors.grey[200],
                child: const Icon(Icons.camera_alt, color: Colors.black),
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                mini: true,
              ),
            ),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.grey[300],
            child: const Icon(Icons.add, color: Colors.black),
            onPressed: _toggleMenu,
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height - kToolbarHeight,
            child: image == null
                ? const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Balık Tespiti İçin Resim Yükleyiniz",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                ),
              ),
            )
                : Image.file(image!),
          ),
          if (_outputs != null && _outputs!.isNotEmpty)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: InkWell(
                  onTap: () {
                    Get.to(FishDetectScreen());
                  },
                  child: Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        _outputs![0]["index"] != 9
                            ? _outputs![0]["label"].substring(2)
                            : "Balık Tanınamadı",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
