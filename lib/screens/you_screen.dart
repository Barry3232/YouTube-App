import 'package:flutter/material.dart';
import 'package:youtube_app/screens/first_screen.dart';
import 'package:youtube_app/screens/shorts_screen.dart';
import 'package:youtube_app/screens/subscription_screen.dart';
import 'package:youtube_app/screens/upload_screen.dart';

class YouScreen extends StatefulWidget {
  const YouScreen({super.key});

  @override
  State<YouScreen> createState() {
    return YouScreenState();
  }
}

class YouScreenState extends State<YouScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              const SizedBox(
                width: 160,
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
              const Spacer(),
              InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {},
                  child: const Icon(Icons.settings_outlined)),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Row(
                children: [
                  CircleAvatar(
                    minRadius: 35,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Nganigo Barisuka',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
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
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black),
                              )
                            ],
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
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
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black),
                              )
                            ],
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
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
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Icon(Icons.file_download_outlined),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    children: [
                      Text(
                        'Downloads',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text('17 Videos')
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.check_circle),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text(
                    'History',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () {}, child: const Text('View all'))
                ],
              )
            ],
          ),
        ));
  }
}
