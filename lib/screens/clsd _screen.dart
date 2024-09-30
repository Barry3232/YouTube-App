import 'package:flutter/material.dart';
import 'package:youtube_app/screens/first_screen.dart';

class CLSDScreen extends StatefulWidget {
  const CLSDScreen({super.key});

  @override
  State<CLSDScreen> createState() => _CLSDScreenState();
}

class _CLSDScreenState extends State<CLSDScreen> {
  @override
  Widget build(BuildContext context) {
    return BottomSheet(onClosing: ()=> const FirstScreen(), builder: (context)=> Container(
      height: 400,
      color: Colors.red,
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                    onTap:(){
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.arrow_drop_down, size: 50,))
              ],
            )
          ],
        ),
      ),
    ));
  }
  void showBottomSheet() {
    showModalBottomSheet(
        enableDrag: true,
        isScrollControlled: true,
        context: context, builder: (context)=>Container());
  }
}


