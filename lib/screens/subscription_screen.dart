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

  List<IconData> icon = [
    Icons.home,
    Icons.accessibility,
    Icons.ac_unit_outlined,
    Icons.add,
    Icons.book,
    Icons.padding_rounded,
    Icons.safety_check,
    Icons.hail,
    Icons.access_alarm,
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
                        MyCircularAvatar(text: 'text'),
                        const SizedBox(
                          width: 10,
                        ),
                        MyCircularAvatar(text: 'Dream'),
                        const SizedBox(
                          width: 10,
                        ),
                        MyCircularAvatar(text: 'Space'),
                        const SizedBox(
                          width: 10,
                        ),
                        MyCircularAvatar(text: 'Spacer'),
                        const SizedBox(
                          width: 10,
                        ),
                        MyCircularAvatar(text: 'Vault'),
                        const SizedBox(
                          width: 10,
                        ),
                        MyCircularAvatar(text: 'Bloom'),
                        const SizedBox(
                          width: 10,
                        ),
                        MyCircularAvatar(text: 'Drain')
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
                    itemBuilder: (context, index) => GestureDetector(
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
                          color:
                              current == index ? Colors.black : Colors.black12,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                            child: Text(
                          items[index],
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                current == index ? Colors.white : Colors.black,
                          ),
                        )),
                      ),
                    ),
                  ),
                ),
                // Visibility(
                //     visible: true,
                //     child: Container(
                //       width: 5,
                //       height: 5,
                //       decoration: BoxDecoration(
                //           shape: BoxShape.circle, color: Colors.blue),
                //     ))
              ),
              Container(
                width: deviceSize.width,
                decoration: BoxDecoration(
                  // color: Colors.red,
                ),
                child: Column(
                  children: [
                    Icon(icon[current], size: 200,)
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

// HomeVideos(
// text:
// 'First flutter application course - Flutter for beginners - Flutter tutorial',
// color: Colors.redAccent,
// image:
// const AssetImage('assets/images/Thomas Stone.png')),
// const SizedBox(
// height: 10,
// ),
// HomeVideos(
// text:
// 'First flutter application course - Flutter for beginners - Flutter tutorial',
// color: Colors.blueGrey,
// image:
// const AssetImage('assets/images/Thomas Stone.png')),
// const SizedBox(
// height: 10,
// ),
// HomeVideos(
// text:
// 'First flutter application course - Flutter for beginners - Flutter tutorial',
// color: Colors.brown,
// image:
// const AssetImage('assets/images/Thomas Stone.png')),