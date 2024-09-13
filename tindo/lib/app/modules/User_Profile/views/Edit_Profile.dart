import 'dart:developer';
import 'dart:io';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rayzi/app/data/Colors.dart';

import '../../../data/APP_variables/AppVariable.dart';
import '../../../data/AppImages.dart';
import '../controllers/EditPofileController.dart';

class EditeProfile extends StatefulWidget {
  const EditeProfile({Key? key}) : super(key: key);

  @override
  State<EditeProfile> createState() => _EditeProfileState();
}

class _EditeProfileState extends State<EditeProfile> {
  EditProfileController editProfileController = Get.put(EditProfileController());
  TextEditingController userNameController = TextEditingController(text: userName);

  // TextEditingController emailController = TextEditingController();

  TextEditingController aboutController = TextEditingController(text: userBio);
  List<String> sdate = [];
  List<String> dateArry = [];
  String gender = userGender;

  /// Date Piker
  String birth = userDOB;
  int selectedGender = 0;
  String year = "2022";
  String month = "01";
  String date = "01";
  final f = DateFormat('dd-MM-yyyy');
  DateTime dateTime = DateTime(2016, 10, 26);

  void _openDatePicker(BuildContext context) {
    BottomPicker.date(
      height: 300,
      closeIconColor: ThemeColor.pink,
      backgroundColor: ThemeColor.white,
      buttonText: "     Confirm    ",
      iconColor: ThemeColor.pink,
      displaySubmitButton: true,
      buttonSingleColor: Colors.pink,
      buttonTextStyle: TextStyle(
        fontSize: 16,
        color: ThemeColor.white,
        fontFamily: "alight",
      ),
      displayButtonIcon: false,
      dateOrder: DatePickerDateOrder.dmy,
      pickerTextStyle: TextStyle(
        fontFamily: "alight",
        color: ThemeColor.blackback,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
      dismissable: true,
      bottomPickerTheme: BottomPickerTheme.plumPlate,
      title: '',
      onSubmit: (p0) {
        setState(() {
          log("=========$p0");
          dateArry = p0.toString().split("-");
          year = dateArry[0];
          month = dateArry[1];
          date = dateArry[2];
          sdate = date.toString().split(" ");
          date = sdate[0];
          birth = '$date/$month/$year';
        });
      },
    ).show(context);
  }

  /// Image Piker
  File? proImage;

  Future cameraImage() async {
    try {
      final imagepike = await ImagePicker().pickImage(source: ImageSource.camera);
      if (imagepike == null) return;

      final imageTeam = File(imagepike.path);
      setState(() {
        proImage = imageTeam;
        userUpdateImage = proImage;
        Get.back();
      });
    } on PlatformException catch (e) {
      log("$e");
    }
  }

  Future pickImage() async {
    try {
      final imagepike = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imagepike == null) return;

      final imageTeam = File(imagepike.path);
      setState(() {
        proImage = imageTeam;
        userUpdateImage = proImage;
        Get.back();
      });
    } on PlatformException catch (e) {
      log("fail$e");
    }
  }

  ///
  //var getStorage = GetStorage();
  late ScrollController _controller;
  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    // TODO: implement initState
    super.initState();
  }

  _scrollListener() {
    // if (aboutController) {
    //   setState(() {
    //     // message = "reach the bottom";
    //   });
    // }
    // if (_controller.offset <= _controller.position.minScrollExtent &&
    //     !_controller.position.outOfRange) {
    //   setState(() {
    //     // message = "reach the top";
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(Get.width, 55),
          child: Column(
            children: [
              const SizedBox(
                height: 28,
              ),
              Container(
                height: 50,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: ImageIcon(
                        const AssetImage(
                          "Images/new_dis/back.png",
                        ),
                        size: 25,
                        color: ThemeColor.blackback,
                      ),
                    ),
                    const SizedBox(
                      width: 26,
                    ),
                    Text(
                      "Edit Profile",
                      style: TextStyle(fontFamily: 'abold', fontSize: 22, color: ThemeColor.blackback),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Fluttertoast.showToast(
                            msg: "Please Wait",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: ThemeColor.white,
                            textColor: ThemeColor.blackback,
                            fontSize: 16.0);
                        editProfileController.updateUser(
                            userNameController.text.toString(), aboutController.text.toString(), gender, birth);
                      },
                      child: Icon(
                        Icons.done,
                        size: 30,
                        color: ThemeColor.grayIcon,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ),
              Divider(color: ThemeColor.graylight.withOpacity(0.3), height: 0.8, thickness: 0.6),
            ],
          ),
        ),
        body: SingleChildScrollView(
          controller: _controller,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 20),
                child: Stack(
                  children: [
                    (userUpdateImage == null)
                        ? Container(
                            height: 96,
                            width: 96,
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(shape: BoxShape.circle),
                            child: CachedNetworkImage(
                                imageUrl: "$userProfile",
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Image.asset(AppImages.profileImagePlaceHolder, fit: BoxFit.cover)),
                          )
                        : CircleAvatar(
                            radius: 48,
                            backgroundColor: Colors.grey.withOpacity(0.8),
                            child: CircleAvatar(
                              radius: 46,
                              backgroundColor: Colors.grey.withOpacity(0.8),
                              foregroundImage: FileImage(userUpdateImage!),
                            ),
                          ),
                    Positioned(
                      top: 66,
                      left: 66,
                      child: GestureDetector(
                        onTap: () {
                          Get.bottomSheet(picture());
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.black,
                          ),
                          child: Icon(Icons.edit, color: ThemeColor.white, size: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'abold',
                        color: ThemeColor.blackback,
                      ),
                    ),
                    TextFormField(
                      cursorColor: ThemeColor.pink,
                      controller: userNameController,
                      style: TextStyle(
                        fontFamily: "amidum",
                        color: ThemeColor.blackback,
                        fontSize: 20,
                      ),
                      maxLength: 30,
                      decoration: InputDecoration(
                        hintText: userName,
                        hintStyle: TextStyle(
                          fontFamily: "amidum",
                          color: ThemeColor.grayIcon,
                          fontSize: 20,
                        ),
                        border: UnderlineInputBorder(borderSide: BorderSide(color: ThemeColor.blackback)),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ThemeColor.blackback)),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 18,
                    // ),
                    // Text(
                    //   "E-mail",
                    //   style: TextStyle(
                    //     fontSize: 16,
                    //     fontFamily: 'abold',
                    //     color: ThemeColor.black_back,
                    //   ),
                    // ),
                    // TextFormField(
                    //   cursorColor: ThemeColor.pink,
                    //   controller: emailController,
                    //   style: Profile_Textfield,
                    //   decoration: InputDecoration(
                    //     hintText: "${getstorage.read('UserName')}.@email.com",
                    //     hintStyle: TextStyle(
                    //       fontFamily: "amidum",
                    //       color: ThemeColor.gray_icon,
                    //       fontSize: 20,
                    //     ),
                    //     border: UnderlineInputBorder(
                    //         borderSide:
                    //             BorderSide(color: ThemeColor.black_back)),
                    //     focusedBorder: UnderlineInputBorder(
                    //         borderSide:
                    //             BorderSide(color: ThemeColor.black_back)),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "About Me",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'abold',
                        color: ThemeColor.blackback,
                      ),
                    ),
                    TextFormField(
                      cursorColor: ThemeColor.pink,
                      controller: aboutController,
                      minLines: 1,
                      maxLines: 9,
                      maxLength: 200,
                      style: TextStyle(
                        fontFamily: "amidum",
                        color: ThemeColor.blackback,
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        hintText: userBio,
                        hintStyle: TextStyle(
                          fontFamily: "amidum",
                          color: ThemeColor.grayIcon,
                          fontSize: 20,
                        ),
                        border: UnderlineInputBorder(borderSide: BorderSide(color: ThemeColor.blackback)),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ThemeColor.blackback)),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Gender",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'abold',
                        color: ThemeColor.blackback,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () => Get.bottomSheet(gendersheet()),
                      child: Text(
                        gender,
                        style: (gender == "Set")
                            ? TextStyle(
                                fontFamily: "amidum",
                                color: ThemeColor.grayIcon,
                                fontSize: 20,
                              )
                            : TextStyle(
                                fontFamily: "amidum",
                                color: ThemeColor.blackback,
                                fontSize: 20,
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Text(
                      "Date of Birth",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'abold',
                        color: ThemeColor.blackback,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        _openDatePicker(context);
                      },
                      child: Text(
                        birth,
                        style: (birth == "Set your Birthday")
                            ? TextStyle(
                                fontFamily: "amidum",
                                color: ThemeColor.grayIcon,
                                fontSize: 20,
                              )
                            : TextStyle(
                                fontFamily: "amidum",
                                color: ThemeColor.blackback,
                                fontSize: 20,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container picture() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
          color: ThemeColor.white,
          borderRadius: const BorderRadius.only(topRight: Radius.circular(22), topLeft: Radius.circular(22))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 6,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 6,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: ThemeColor.pink,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Divider(
            height: 1,
            color: ThemeColor.grayinsta.withOpacity(0.16),
            thickness: 0.8,
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: InkWell(
              onTap: () => cameraImage(),
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: ThemeColor.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      height: 26,
                      width: 26,
                      child: ImageIcon(const AssetImage("Images/Message/camera.png"), color: ThemeColor.blackback),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Take a photo",
                      style: TextStyle(fontFamily: 'amidum', fontSize: 15, color: ThemeColor.blackback),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: InkWell(
              onTap: () => pickImage(),
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: ThemeColor.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      height: 26,
                      width: 26,
                      child: ImageIcon(
                        const AssetImage("Images/Message/gallery2.png"),
                        color: ThemeColor.blackback,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Choose from your file",
                      style: TextStyle(fontFamily: 'amidum', fontSize: 15, color: ThemeColor.blackback),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  StatefulBuilder gendersheet() {
    return StatefulBuilder(
      builder: (context, setState1) {
        return Container(
          height: 270,
          decoration: BoxDecoration(
            color: ThemeColor.white,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(14),
              topLeft: Radius.circular(14),
            ),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 6.5,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: ThemeColor.pink,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "GENDER",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "abold",
                  color: ThemeColor.blackback,
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 55,
                child: InkWell(
                  onTap: () {
                    setState1(() {
                      selectedGender = 1;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Female",
                        style: (selectedGender == 1)
                            ? TextStyle(
                                color: ThemeColor.blackback,
                                fontSize: 20,
                                fontFamily: 'abold',
                              )
                            : TextStyle(
                                color: ThemeColor.blackback,
                                fontSize: 20,
                                fontFamily: 'amidum',
                              ),
                      ),
                      const Spacer(),
                      (selectedGender == 1)
                          ? Image.asset(
                              "Images/Profile/correct.png",
                              height: 25,
                              width: 25,
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 55,
                child: InkWell(
                  onTap: () {
                    setState1(() {
                      selectedGender = 2;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Male",
                        style: (selectedGender == 2)
                            ? TextStyle(
                                color: ThemeColor.blackback,
                                fontSize: 20,
                                fontFamily: 'abold',
                              )
                            : TextStyle(
                                color: ThemeColor.blackback,
                                fontSize: 20,
                                fontFamily: 'amidum',
                              ),
                      ),
                      const Spacer(),
                      (selectedGender == 2)
                          ? Image.asset(
                              "Images/Profile/correct.png",
                              height: 25,
                              width: 25,
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (selectedGender == 1) {
                      gender = 'Female';
                    } else if (selectedGender == 2) {
                      gender = 'Male';
                    }
                  });
                  Get.back();
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: ThemeColor.pink,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  alignment: Alignment.center,
                  child: Text("Set", style: TextStyle(color: ThemeColor.white, fontFamily: 'abold', fontSize: 18)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        );
      },
    );
  }
}
