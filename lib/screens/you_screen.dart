import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class YouScreen extends StatefulWidget {
  const YouScreen({super.key});

  @override
  State<YouScreen> createState() {
    return YouScreenState();
  }
}

class YouScreenState extends State<YouScreen> {
  //
  // String? _profilePicUrl;
  // bool _uploading = false;
  //
  // // load currently saved profile picture of user
  // Future<void> _loadingExistingAvatar() async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user == null) return; // user not signed in
  //
  //   final doc = await FirebaseFirestore.instance.collection('users').doc(
  //       user.uid).get();
  //   setState(() {
  //     _profilePicUrl = doc.data()!['profilePic'] as String;
  //   });
  // }
  //
  // // pick an image from the gallary, upload to storage , store URL in firebaseStore
  // Future<void> _pickAndUploadImage() async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user == null) {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('please sign in first')));
  //     }
  //     return;
  //   }
  //   try {
  //     // pick video
  //     final picker = ImagePicker();
  //     final picked = await picker.pickImage(source: ImageSource.gallery,
  //       imageQuality: 85,
  //     );
  //     if (picked == null) return; //user cancelled
  //
  //     setState(() {
  //       _uploading = true;
  //     });
  //
  //     //convert to file
  //     final file = File(picked.path);
  //
  //     //upload to storage path
  //     final ref = FirebaseStorage.instance.ref().child(
  //         'profile_pics/${user.uid}.jpg');
  //
  //     //get URL
  //     final url = await ref.getDownloadURL();
  //
  //     //save to firestore
  //     await FirebaseFireStore.instance.collection('users').doc(user.uid).set(
  //         {'profilePic': url}, SetOptions(merge: true));
  //
  //     // update local UI
  //     if (mounted) {
  //       setState(() {
  //         _profilePicUrl = url;
  //         _uploading = false;
  //       });
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile photo updated'),));
  //     }
  //   } catch (e){
  //     if (mounted) {
  //       setState(() {
  //
  //         _uploading =false;
  //       });
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload error')));
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const Row(
              children: [
                CircleAvatar(minRadius: 35),
                SizedBox(width: 10),
                Text(
                  'Nganigo Barisuka',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
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
