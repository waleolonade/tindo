import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/data/Colors.dart';

class OpenImage extends StatefulWidget {
  final String images;
  const OpenImage({Key? key, required this.images}) : super(key: key);

  @override
  State<OpenImage> createState() => _OpenImageState();
}

class _OpenImageState extends State<OpenImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leadingWidth: 45,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Row(
              children: [
                const SizedBox(
                  width: 18,
                ),
                ImageIcon(
                  const AssetImage(
                    "Images/new_dis/back.png",
                  ),
                  color: ThemeColor.white,
                  size: 26,
                ),
              ],
            )),
        backgroundColor: Colors.white.withOpacity(0.04),
        elevation: 0,
      ),
      body: Center(child: Image(image: NetworkImage(widget.images))),
    );
  }
}
