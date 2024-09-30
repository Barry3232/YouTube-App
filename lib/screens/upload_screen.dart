import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_app/model/post_model.dart';
import 'package:youtube_app/service/firebase_database_service.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() {
    return UploadScreenState();
  }
}

class UploadScreenState extends State<UploadScreen> {
  late VideoPlayerController _controller;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  File? videoFile;
  XFile? pickerFile;
  Uint8List? fileBinary;

  final _formKey = GlobalKey<FormState>();
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> pickVideo(ImageSource source) async {
    try {
      final newPickerVideo = await ImagePicker().pickVideo(source: source);

      if (newPickerVideo == null) return;
      final newBinary = await newPickerVideo.readAsBytes();

      setState(() {
        pickerFile = newPickerVideo;
        videoFile = File(newPickerVideo.path);
        fileBinary = newBinary;
      });
      _controller = VideoPlayerController.file(videoFile!)
        ..initialize().then((value) {
          setState(() {});
        });

      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
      return print(e);
    }
  }

  Future<String> saveVideo() async {
    if (videoFile == null) {
      throw Exception('no video file');
    }
    final storageRef = FirebaseStorage.instance.ref();

    final videoRef = storageRef.child('videos-${DateTime.now().millisecond.toString()}');

    await videoRef.putFile(videoFile!);

    return await videoRef.getDownloadURL();
  }

  Future<void> submit() async {
    final isValidate = _formKey.currentState?.validate();

    if (!isValidate!) {
      return;
    }
    _formKey.currentState?.save();

    setState(() {
      isSubmitting = true;
    });
    try {

      final videoUrl = await saveVideo();

      final auth = FirebaseAuth.instance;

      final newPost = PostModel(
          title: titleController.text.trim(),
          description: descriptionController.text.trim(),
          id: "new",
          postDate: DateTime.now(),
          userId: auth.currentUser?.uid ?? "new", videoURL: videoUrl);
      await FirebaseDBService().addPost(newPost);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post uploaded successfully')));
    } on SocketException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    } on FirebaseException catch (e) {
      if (e.code == 1000) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Error")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() {
        isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.close)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'This is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.black,
                          )),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.red),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'This is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.black,
                          )),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.red),
                          )),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Container(
              height: 300,
              width: 345,
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
                 child: videoFile == null
                  ? InkWell(
                      onTap: () => pickVideo(ImageSource.gallery),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Upload',
                            style: TextStyle(fontSize: 28),
                          ),
                          Icon(
                            Icons.add,
                            size: 40,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    )
                  : _controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child:
                          InkWell(
                              onTap: () {
                                setState(() {
                                  _controller.value.isPlaying
                                      ? _controller.pause()
                                      : _controller.play();
                                });
                              },
                              child: VideoPlayer(_controller)),
                        )
                      : Container(),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.resolveWith((states) => Colors.white),
                overlayColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.blueGrey),
                side: MaterialStateProperty.resolveWith(
                    (states) => const BorderSide(color: Colors.black)),
              ),
              onPressed: submit,
              child: isSubmitting
                  ? const CircularProgressIndicator()
                  : const Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}
