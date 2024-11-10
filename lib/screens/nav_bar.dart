import 'package:flutter/material.dart';
import 'package:youtube_app/screens/first_screen.dart';
import 'package:youtube_app/screens/shorts_screen.dart';
import 'package:youtube_app/screens/subscription_screen.dart';
import 'package:youtube_app/screens/upload_screen.dart';
import 'package:youtube_app/screens/you_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _page = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _page);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void pageChanger(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapper(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: pageChanger,
          children: const [
            FirstScreen(),
            ShortsScreen(),
            SizedBox(),
            SubscriptionScreen(),
            YouScreen(),
          ],
        ),
        bottomNavigationBar:  BottomTab(
            index: _page,
            onTap: navigationTapper,
          ),
        );
  }
}

class BottomTab extends StatefulWidget {
  const BottomTab({super.key, required this.index, required this.onTap});
  final int index;
  final ValueChanged<int> onTap;


  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return BottomAppBar(
      surfaceTintColor: Colors.white,

      // notchMargin: 13.0,
      shape: const CircularNotchedRectangle(),
      color: (widget.index == 2 || widget.index == 1)
          ? Colors.black
          : Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildTabItem(
              widget.index == 0
                  ? const Icon(Icons.home)
                  : const Icon(Icons.home_outlined),
              0,
              'Home'),
          buildTabItem(
              widget.index == 1
                  ? const Icon(
                      Icons.play_circle,
                      color: Colors.white,
                    )
                  : const Icon(Icons.play_circle_outline),
              1,
              'Short'),
          CircleAvatar(
            backgroundColor: Colors.black,
            radius: 21,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const UploadScreen()));
                  },
                  child: const Icon(
                    Icons.add,
                    size: 30,
                  )),
            ),
          ),
          buildTabItem(
              widget.index == 3
                  ? const Icon(Icons.subscriptions)
                  : const Icon(Icons.subscriptions_outlined),
              3,
              'Subs'),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    widget.onTap(4);
                  },
                  child: (widget.index != 4
                      ? const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/Allie Goldman.png'),
                          radius: 12,
                        )
                      : const CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 12,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/Allie Goldman.png'),
                            radius: 9,
                          ),
                        ))),
              const SizedBox(height: 3),
              const Text(
                'You',
                style: TextStyle(fontSize: 8),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildTabItem(Icon icon, int index, String title) {
    final isSelected = index == widget.index;
    return InkWell(
      onTap: () => widget.onTap(index),
      // focusColor: Colors.transparent,
      // highlightColor: Colors.grey,
      splashColor: Colors.grey, borderRadius: BorderRadius.circular(10) ,
      child: Container(
        padding: const EdgeInsets.only(top: 3),
        height: 40,
        width: 40,
        child: Column(
          children: [
            IconTheme(
                data: IconThemeData(
                    size: isSelected ? 26 : 24,
                    color: isSelected
                        ? Colors.black
                        : (widget.index == 1 || widget.index == 2)
                            ? Colors.white
                            : Colors.black),
                child: icon),
            Text(title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 8,
                  color: Colors.black,
                  // isSelected ? Colors.black : Colors.blue),
                ))
          ],
        ),
      ),
    );
  }
}
