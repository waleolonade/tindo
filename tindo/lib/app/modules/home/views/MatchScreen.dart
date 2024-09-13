import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rayzi/app/data/Colors.dart';

import 'MatchingWithUser.dart';

class MatchScreen extends StatefulWidget {
  const MatchScreen({Key? key}) : super(key: key);

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (!mounted)
          return;
        else
          Get.off(const MatchingWithUser());
      },
    );
    // TODO: implement initState
    super.initState();
  }

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
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined,
                color: Color(0xffF5F6F6), size: 26),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Searching for new Friends...",
                style: TextStyle(
                  fontFamily: 'amidum',
                  color: ThemeColor.white,
                  fontSize: 20,
                ),
              ),
            ),
            const Spacer(),
            Stack(
              alignment: Alignment.center,
              children: [
                Lottie.asset(
                  "lottie/match_earth_anim.json",
                  width: 360,
                  height: 360,
                  repeat: true,
                ),
                Container(
                  height: 85,
                  width: 85,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: const Color(0xffD9206B), width: 3),
                      image: const DecorationImage(
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=688&q=80"),
                          fit: BoxFit.cover)),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Spacer(),
            Text(
              "Go meet people around the world",
              style: TextStyle(
                fontFamily: 'alight',
                color: ThemeColor.white,
                fontSize: 17,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
