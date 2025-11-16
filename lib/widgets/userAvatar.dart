import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key,
  required this.userId,
  this.radius = 25});

  final String userId;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref('users/$userId/profilePic');

    return StreamBuilder<DatabaseEvent>(
      stream: ref.onValue,
      builder: (context, snapshot) {
        String? url;
        if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
          url = snapshot.data!.snapshot.value.toString();
        }

        final ImageProvider img = url != null
            ? NetworkImage(url)
            : const AssetImage('assets/images/default_avatar.png')
        as ImageProvider;

        return CircleAvatar(
          radius: radius,
          backgroundImage: img,
        );
      },
    );
  }
}
