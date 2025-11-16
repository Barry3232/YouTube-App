import 'package:flutter/material.dart';

import '../widgets/my_circular_avatar.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() {
    return SubscriptionScreenState();
  }
}

class SubscriptionScreenState extends State<SubscriptionScreen> {
  List<String> items = [
    "All",
    "Today",
    "Videos",
    "Shorts",
    "Live",
    "Posts",
    "Continue watching",
    "Unwanted",
    "Settings",
  ];

  List<Widget> widgets = [
    Container(color: Colors.red, height: 40, width: 40),
    Container(color: Colors.green, height: 400, width: 40),
    Container(color: Colors.yellow, height: 40, width: 40),
    Container(color: Colors.yellow, height: 40, width: 40),
    Container(color: Colors.yellow, height: 40, width: 40),
    Container(color: Colors.yellow, height: 40, width: 40),
    Container(color: Colors.yellow, height: 40, width: 40),
    Container(color: Colors.yellow, height: 40, width: 40),
    Container(color: Colors.yellow, height: 40, width: 40),
  ];

  int current = 0;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
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
                'assets/images/vecteezy_youtube-logo-png-youtube-logo.png',
              ),
            ),
            const Text(
              'YouTube',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 100),
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
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: deviceSize.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      MyCircularAvatar(
                        text: 'text',
                        image:
                            const AssetImage('assets/images/Allie Goldman.png'),
                      ),
                      const SizedBox(width: 10),
                      MyCircularAvatar(
                        text: 'Dream',
                        image: const AssetImage(
                            'assets/images/default_avatar.png'),
                      ),
                      const SizedBox(width: 10),
                      MyCircularAvatar(
                        text: 'Space',
                        image:
                            const AssetImage('assets/images/Jens Röhrdanz.png'),
                      ),
                      const SizedBox(width: 10),
                      MyCircularAvatar(
                        text: 'Spacer',
                        image: const AssetImage('assets/images/images1.jpg'),
                      ),
                      const SizedBox(width: 10),
                      MyCircularAvatar(
                        text: 'Vault',
                        image:
                            const AssetImage('assets/images/Jens Röhrdanz.png'),
                      ),
                      const SizedBox(width: 10),
                      MyCircularAvatar(
                        text: 'Bloom',
                        image:
                            const AssetImage('assets/images/Omari Norris.png'),
                      ),
                      const SizedBox(width: 10),
                      MyCircularAvatar(
                        text: 'Drain',
                        image:
                            const AssetImage('assets/images/Polina Kranz.png'),
                      ),
                      const SizedBox(width: 10),
                      MyCircularAvatar(
                        text: 'Drain',
                        image:
                            const AssetImage('assets/images/Thomas Stone.png'),
                      ),
                      const SizedBox(width: 10),
                      MyCircularAvatar(
                        text: 'Drain',
                        image: const AssetImage('assets/images/images1.jpg'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 55,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            current = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          margin: const EdgeInsets.all(3),
                          constraints: const BoxConstraints(
                            maxWidth: double.infinity,
                          ),
                          decoration: BoxDecoration(
                            color: (index == 8)
                                ? Colors.transparent
                                : current == index
                                    ? Colors.black
                                    : Colors.black12,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              items[index],
                              style: TextStyle(
                                fontSize: 16,
                                color: (current == index && index == 8)
                                    ? Colors.blue
                                    : current == index
                                        ? Colors.white
                                        : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: deviceSize.width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [widgets[current]]),
            ),
          ],
        ),
      ),
    );
  }
}
