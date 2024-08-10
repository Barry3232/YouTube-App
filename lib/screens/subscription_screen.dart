import 'package:flutter/material.dart';
import 'package:youtube_app/widgets/my_circular_avatar.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() {
    return SubscriptionScreenState();
  }
}

class SubscriptionScreenState extends State<SubscriptionScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 8, vsync: this);

    final deviceSize = MediaQuery
        .of(context)
        .size;
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
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  TabBar(
                    unselectedLabelColor: Colors.black,
                      labelColor: Colors.white,
                      indicatorColor: Colors.transparent,
                      // overlayColor: MaterialStateProperty<Colors.black?>?,
                      isScrollable: true,
                      controller: tabController, tabs: [
                    Tab(
                      child: Container(
                        alignment: Alignment.center,
                        width: 40,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8)
                          // border: ,
                        ),
                        child: const Text('All'),
                      ),

                    ),
                    Tab(
                      child: Container(
                        alignment: Alignment.center,
                        width: 60,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8)
                          // border: ,
                        ),
                        child: const Text('Today'),
                      ),
                    ),
                    Tab(
                      child: Container(
                        alignment: Alignment.center,
                        width: 60,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8)
                          // border: ,
                        ),
                        child: const Text('Videos'),
                      ),
                    ),
                    Tab(
                      child: Container(
                        alignment: Alignment.center,
                        width: 60,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8)
                          // border: ,
                        ),
                        child: const Text('Shorts'),
                      ),
                    ),
                    Tab(
                      child: Container(
                        alignment: Alignment.center,
                        width: 45,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8)
                          // border: ,
                        ),
                        child: const Text('Live'),
                      ),
                    ),
                    Tab(
                      child: Container(
                        alignment: Alignment.center,
                        width: 55,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8)
                          // border: ,
                        ),
                        child: const Text('posts'),
                      ),
                    ),
                    Tab(
                      child: Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8)
                          // border: ,
                        ),
                        child: const Text('Continue watching'),
                      ),
                    ),
                    Tab(
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8)
                          // border: ,
                        ),
                        child: const Text('Unwatched'),
                      ),
                    ),
                    Tab(
                      child: InkWell(
                        onTap: (){},
                        child: const Text('Settings',
                        style: TextStyle(
                          color: Colors.purple
                        ),),
                      ),
                      // text: 'Settings',
                    )
                  ]),
                ])));
  }
}

// body: SingleChildScrollView(
//   child:
//   Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Row(
//         children: [
//           MyCircularAvatar(),
//         ],
//       ),
//
//       TabBarView(
//           controller: tabController,
//           children: [
//             SingleChildScrollView(
//               child: Column(
//                 children: [
//                   HomeVideos(
//                       text:
//                       'First flutter application course - Flutter for beginners - Flutter tutorial',
//                       color: Colors.redAccent,
//                       image: const AssetImage(
//                           'assets/images/Thomas Stone.png')),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   HomeVideos(
//                       text:
//                       'First flutter application course - Flutter for beginners - Flutter tutorial',
//                       color: Colors.blueGrey,
//                       image: const AssetImage(
//                           'assets/images/Thomas Stone.png')),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   HomeVideos(
//                       text:
//                       'First flutter application course - Flutter for beginners - Flutter tutorial',
//                       color: Colors.brown,
//                       image: const AssetImage(
//                           'assets/images/Thomas Stone.png'))
//                 ],
//               ),
//             ),
//
//             Text('Here'),
//             Text('There'),
//             Text('Them'),
//             Text('Clam'),
//             Text('View'),
//             Text('View'),
//             Text('View'),
//             Text('View'),
//             Text('View'),
//           ],
//         ),
//
//
//     ],
//   ),
// ),
