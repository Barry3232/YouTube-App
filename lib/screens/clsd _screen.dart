import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ModelBottomSheet extends StatefulWidget {
  const ModelBottomSheet({super.key});

  @override
  State<ModelBottomSheet> createState() => _ModelBottomSheetState();
}

class _ModelBottomSheetState extends State<ModelBottomSheet> {

  // Future<void> likePost(
  //     BuildContext context,
  //     )async {
  //   try {
  //     await FirebaseFirestore.instance.collection('post')
  //   }
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          color: Colors.grey,
          child: Column(
            children: [
              Stack(
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            Icons.arrow_drop_down,
                            size: 50,
                          ))
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        ),

        const Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: [
              Icon(Icons.thumb_up_alt_outlined),
              Spacer(),
              Icon(Icons.thumb_down_outlined),
              Spacer(),
              Icon(Icons.messenger_outline_outlined)
            ],
          ),
        )
      ],
    );
  }
}
