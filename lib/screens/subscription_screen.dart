import 'package:flutter/material.dart';
import 'package:youtube_app/widgets/my_circular_avatar.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() {
    return SubscriptionScreenState();
  }
}

class SubscriptionScreenState extends State<SubscriptionScreen> {
  // final isSelected = widget;
  int function = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            const Image(
                height: 50,
                width: 40,
                image: AssetImage(
                    'assets/images/vecteezy_youtube-logo-png-youtube-logo.png')),
            const Text(
              'YouTube',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 100,
            ),
            InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {},
                child: const Icon(Icons.cast)),
            const Spacer(),
            InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {},
                child: const Icon(Icons.notifications_none_outlined)),
            const Spacer(),
            InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {},
                child: const Icon(Icons.search_outlined)),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Column(
                          children: [MyCircularAvatar(), Text('book')],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [MyCircularAvatar(), Text('book')],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [MyCircularAvatar(), Text('book')],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [MyCircularAvatar(), Text('book')],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [MyCircularAvatar(), Text('book')],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [MyCircularAvatar(), Text('book')],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [MyCircularAvatar(), Text('book')],
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          height: 35,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(7)),
                          child: const Text(
                            'All',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          height: 35,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(7)),
                          child: const Text(
                            'Today',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          height: 35,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(7)),
                          child: const Text(
                            'Videos',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          height: 35,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(7)),
                          child: const Text(
                            'Shorts',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          height: 35,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(7)),
                          child: const Text(
                            'Live',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          height: 35,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(7)),
                          child: const Text(
                            'Live',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ElevatedButton(style:ButtonStyle(
          //   backgroundColor:
          //   MaterialStateProperty.resolveWith(
          //           (states) => Colors.black),
          //   overlayColor:
          //   MaterialStateProperty.resolveWith(
          //           (states) => Colors.blueGrey),
          //   side: MaterialStateProperty.resolveWith(
          //           (states) => const BorderSide(
          //           color: Colors.black)),
          // ),
          // onPressed: (){}, child: Text('All')
          // )
        ],
      ),
    );
  }
}
