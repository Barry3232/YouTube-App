import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';

class YouScreen extends StatefulWidget {
  const YouScreen({super.key});

  @override
  State<YouScreen> createState() {
    return YouScreenState();
  }
}

class YouScreenState extends State<YouScreen> {
  String? _profilePicUrl;
  String? _userFullName;
  bool _uploading = false;

  // load currently saved profile picture of users
  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return; // user not signed in

    try {
      final ref = FirebaseDatabase.instance.ref('users/${user.uid}');
      ref.onValue.listen((event) {
        if (!mounted) return;

        final snapshot = event.snapshot.value;
        if (snapshot == null) return;

        final data = Map<String, dynamic>.from(snapshot as Map<dynamic, dynamic>);

        setState(() {
          _profilePicUrl = data['profilePic'] ?? '';
          final first = data['firstName'] ?? '';
          final last = data['lastName'] ?? '';
          _userFullName = "$first $last";
        });
      });

    } catch (e) {
      // optional: log error, but don't crash UI
      debugPrint('Error loading user data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData(); // loads both name and picture
  }

  // pick an image from the gallery, upload to storage , then update RTDB

  Future<void> _pickAndUploadImage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    try {
      // pick image
      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      if (picked == null) return; //user cancelled

      setState(() {
        _uploading = true;
      });

      //convert to file
      final file = File(picked.path);

      // Build a storage reference: profile_pics/<uid>.jpg
      final ref = FirebaseStorage.instance
          .ref()
          .child("profilePics")
          .child("${user.uid}.jpg");
      await ref.putFile(file);

       //get URL
      final url = await ref.getDownloadURL();

      // Save URL into Realtime Database under users/<uid>/profilePic
      await FirebaseDatabase.instance
          .ref('users/${user.uid}')
          .update({'profilePic': url});

      // Update local state and notify user
      if (mounted) {
        setState(() {
          _profilePicUrl = url;
          _uploading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Profile photo updated'),
        ));
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _uploading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Upload error')));
      }
      debugPrint('pickAndUploadImage error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = _profilePicUrl != null
        ? NetworkImage(_profilePicUrl!)
        : const AssetImage('assets/images/images1.jpg') as ImageProvider;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            const SizedBox(width: 160),
            InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {},
              child: const Icon(Icons.cast),
            ),
            const Spacer(),
            InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {},
              child: const Icon(Icons.notifications_none_outlined),
            ),
            const Spacer(),
            InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {},
              child: const Icon(Icons.search_outlined),
            ),
            const Spacer(),
            InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {},
              child: const Icon(Icons.settings_outlined),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: _pickAndUploadImage,
                  // borderRadius: BorderRadius.circular(widget.radius),
                  child: CircleAvatar(
                    // radius: widget.radius,

                    // shows either network or default asset
                    backgroundImage: imageProvider,
                    backgroundColor: Colors.grey,
                    minRadius: 35,
                    child: Column(
                      children: [
                        // Tiny progress ring over the avatar while uploading
                        if (_uploading)
                          const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Text(
                  _userFullName ?? 'loading...',
                  style: const TextStyle(
                      fontSize: 21, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    height: 28,
                    // width: 133,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Icon(
                            Icons.switch_account_outlined,
                            size: 13,
                            color: Colors.black,
                          ),
                          Text(
                            'Switch Account',
                            style: TextStyle(fontSize: 10, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 28,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Icon(
                            Icons.g_mobiledata_sharp,
                            size: 13,
                            color: Colors.black,
                          ),
                          Text(
                            'Google Account',
                            style: TextStyle(fontSize: 10, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 28,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Icon(
                            Icons.private_connectivity_outlined,
                            size: 13,
                            color: Colors.black,
                          ),
                          Text(
                            'Turn on Incognito',
                            style: TextStyle(fontSize: 10, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Icon(Icons.file_download_outlined),
                SizedBox(width: 15),
                Column(
                  children: [
                    Text('Downloads', style: TextStyle(fontSize: 15)),
                    Text('17 Videos'),
                  ],
                ),
                Spacer(),
                Icon(Icons.check_circle),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  'History',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                ElevatedButton(onPressed: () {}, child: const Text('View all')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
