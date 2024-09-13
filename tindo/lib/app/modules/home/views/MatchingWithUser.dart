import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/home/controllers/home_controller.dart';

import 'MatchScreen.dart';

class MatchingWithUser extends StatefulWidget {
  const MatchingWithUser({Key? key}) : super(key: key);

  @override
  State<MatchingWithUser> createState() => _MatchingWithUserState();
}

class _MatchingWithUserState extends State<MatchingWithUser> {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xff111217),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xff111217),
          leading: IconButton(
            onPressed: () {
              setState(() {
                Get.back();
              });
              // Get.offAll(() => const OneToOneScreen());
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined,
                color: Color(0xffF5F6F6), size: 26),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Matched with Sofia adams",
                style: TextStyle(
                  fontFamily: 'amidum',
                  color: ThemeColor.white,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            const Spacer(),
            Container(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 80),
                        child: CircleAvatar(
                          radius: 52,
                          backgroundColor: Color(0xffD9206B),
                          child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(
                                "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=688&q=80",
                              ),
                              radius: 50),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 80),
                        child: CircleAvatar(
                          radius: 52,
                          backgroundColor: Color(0xffD9206B),
                          child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(
                                "https://images.unsplash.com/photo-1542206395-9feb3edaa68d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80",
                              ),
                              radius: 50),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            const SizedBox(
              height: 100,
            ),
            GestureDetector(
              onTap: () {
                //Get.off(RandomMatching(matchImage: '',));
              },
              child: Container(
                alignment: Alignment.center,
                height: 45,
                width: 190,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xffDB177C),
                      Color(0xff8A1BE3),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Text(
                  "Call Now",
                  style: TextStyle(
                    fontFamily: 'abold',
                    color: ThemeColor.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                Get.off(
                  () => const MatchScreen(),
                );
              },
              child: const Text(
                "Match again",
                style: TextStyle(
                  fontFamily: 'amidum',
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Go meet people around the world",
              style: TextStyle(
                  fontFamily: 'alight',
                  color: ThemeColor.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
