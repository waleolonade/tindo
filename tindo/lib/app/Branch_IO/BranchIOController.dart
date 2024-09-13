import 'dart:async';
import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';
import 'package:rayzi/app/modules/Show_Post/views/BranchIOProstScreen.dart';
import 'package:rayzi/app/modules/User_Profile/views/second_user_profile.dart';
import 'package:rayzi/app/modules/User_Profile/views/user_profile_view.dart';
import 'package:rayzi/app/modules/home/views/Live%20Streaming/LiveStreamingScreen.dart';
import 'package:share_plus/share_plus.dart';

class BranchIOController extends GetxController {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  BranchContentMetaData metadata = BranchContentMetaData();
  BranchUniversalObject? buo;
  BranchLinkProperties lp = BranchLinkProperties();
  BranchEvent? eventStandard;
  BranchEvent? eventCustom;

  StreamSubscription<Map>? streamSubscription;
  StreamController<String> controllerData = StreamController<String>();
  StreamController<String> controllerInitSession = StreamController<String>();
  RxString imageURL = ''.obs;
//To Setup Data For Generation Of Deep Link

  void listenDynamicLinks() async {
    streamSubscription = FlutterBranchSdk.initSession().listen((data) {
      log('listenDynamicLinks - DeepLink Data: $data');
      controllerData.sink.add((data.toString()));
      if (data.containsKey('+clicked_branch_link') &&
          data['+clicked_branch_link'] == true) {
        log('------------------------------------Link clicked----${data['shareType']}------------------------------------------');
        branchIOVisit.value = true;
        if (data['shareType'] == "1") {
          if (data['UserID'] == userID) {
            Get.to(()=>() => const UserProfileView());
          } else {
            Get.to(()=>()=>() => SecondUserProfileView(userID: data['UserID']));
          }
          log('Custom string: ${data['shareType']}');
          log('Custom number: ${data['UserID']}');
        } else if (data['shareType'] == "2") {
          branchIOVisit.value = true;
          log('Custom string: ${data['shareType']}');
          log('Custom number: ${data['userId']}');
          log('Custom number: ${data['postId']}');
          log('------------------------------------------------------------------------------------------------');
          Get.offAll(GetSinglePostScreen(
              secounduserID: "${data['userId']}", postID: "${data['postId']}"));
        } else if (data['shareType'] == "3") {
          branchIOVisit.value = true;
          Get.off(LiveStreamingScreen(
            token: data['token'],
            channelName: data['channelName'],
            liveUserId: data['liveuserid'],
            clientRole: ClientRole.Audience,
            liveStreamingId: data['liveStrimingid'],
            liveUserName: data['liveusername'],
            liveUserImage: data['liveuserimage'],
            mongoId: data['mongoId'],
            userCoin: '',
            followStatus: '',
          ));
        }
      }
    }, onError: (error) {
      log('InitSesseion error: ${error.toString()}');
    });
  }

  //// ====== ShareType ====== \\\\
  //// ====== 1=Profile,2=Post,3=LiveStriminiUser ====== \\\\
  void initDeepLinkDataProfile(
      {required int shareType, required String profileUserID}) {
    metadata = BranchContentMetaData()
      ..addCustomMetadata("shareType", shareType)
      ..addCustomMetadata('UserID', profileUserID);

    buo = BranchUniversalObject(
        canonicalIdentifier: 'flutter/branch',
        canonicalUrl: 'https://flutter.dev',
        title: 'Tindo',
        imageUrl: imageURL.value,
        contentDescription: 'Share Image',
        contentMetadata: metadata,
        keywords: ['Plugin', 'Branch', 'Flutter'],
        publiclyIndex: true,
        locallyIndex: true,
        expirationDateInMilliSec: DateTime.now()
            .add(const Duration(days: 365))
            .millisecondsSinceEpoch);

    lp = BranchLinkProperties(
        channel: 'facebook',
        feature: 'sharing',
        stage: 'new share',
        campaign: 'campaign',
        tags: ['one', 'two', 'three'])
      ..addControlParam('\$uri_redirect_mode', '1')
      ..addControlParam('\$ios_nativelink', true)
      ..addControlParam('\$match_duration', 7200)
      ..addControlParam('\$always_deeplink', true)
      ..addControlParam('\$android_redirect_timeout', 750)
      ..addControlParam('referring_user_id', 'user_id');

    eventStandard = BranchEvent.standardEvent(BranchStandardEvent.ADD_TO_CART)
      //--optional Event data
      ..transactionID = '12344555'
      ..currency = BranchCurrencyType.BRL
      ..revenue = 1.5
      ..shipping = 10.2
      ..tax = 12.3
      ..coupon = 'test_coupon'
      ..affiliation = 'test_affiliation'
      ..eventDescription = 'Event_description'
      ..searchQuery = 'item 123'
      ..adType = BranchEventAdType.BANNER
      ..addCustomData(
          'Custom_Event_Property_Key1', 'Custom_Event_Property_val1')
      ..addCustomData(
          'Custom_Event_Property_Key2', 'Custom_Event_Property_val2');

    eventCustom = BranchEvent.customEvent('Custom_event')
      ..addCustomData(
          'Custom_Event_Property_Key1', 'Custom_Event_Property_val1')
      ..addCustomData(
          'Custom_Event_Property_Key2', 'Custom_Event_Property_val2');
  }

  void initDeepLinkDataLiveStriming({
    required int shareType,
    required String token,
    required String liveuserid,
    required String channelName,
    required String liveStrimingid,
    required String liveusername,
    required String liveuserimage,
    required String mongoId,
    required String diamond,
  }) {
    metadata = BranchContentMetaData()
      ..addCustomMetadata("shareType", shareType)
      ..addCustomMetadata("token", token)
      ..addCustomMetadata("liveuserid", liveuserid)
      ..addCustomMetadata("channelName", channelName)
      ..addCustomMetadata("liveStrimingid", liveStrimingid)
      ..addCustomMetadata("liveusername", liveusername)
      ..addCustomMetadata("liveuserimage", liveuserimage)
      ..addCustomMetadata("mongoId", mongoId)
      ..addCustomMetadata("diamond", diamond);
    buo = BranchUniversalObject(
        canonicalIdentifier: 'flutter/branch',
        canonicalUrl: 'https://flutter.dev',
        title: 'Tindo',
        imageUrl: imageURL.value,
        contentDescription: 'Share Image',
        contentMetadata: metadata,
        keywords: ['Plugin', 'Branch', 'Flutter'],
        publiclyIndex: true,
        locallyIndex: true,
        expirationDateInMilliSec: DateTime.now()
            .add(const Duration(days: 365))
            .millisecondsSinceEpoch);

    lp = BranchLinkProperties(
        channel: 'facebook',
        feature: 'sharing',
        stage: 'new share',
        campaign: 'campaign',
        tags: ['one', 'two', 'three'])
      ..addControlParam('\$uri_redirect_mode', '1')
      ..addControlParam('\$ios_nativelink', true)
      ..addControlParam('\$match_duration', 7200)
      ..addControlParam('\$always_deeplink', true)
      ..addControlParam('\$android_redirect_timeout', 750)
      ..addControlParam('referring_user_id', 'user_id');

    eventStandard = BranchEvent.standardEvent(BranchStandardEvent.ADD_TO_CART)
      //--optional Event data
      ..transactionID = '12344555'
      ..currency = BranchCurrencyType.BRL
      ..revenue = 1.5
      ..shipping = 10.2
      ..tax = 12.3
      ..coupon = 'test_coupon'
      ..affiliation = 'test_affiliation'
      ..eventDescription = 'Event_description'
      ..searchQuery = 'item 123'
      ..adType = BranchEventAdType.BANNER
      ..addCustomData(
          'Custom_Event_Property_Key1', 'Custom_Event_Property_val1')
      ..addCustomData(
          'Custom_Event_Property_Key2', 'Custom_Event_Property_val2');

    eventCustom = BranchEvent.customEvent('Custom_event')
      ..addCustomData(
          'Custom_Event_Property_Key1', 'Custom_Event_Property_val1')
      ..addCustomData(
          'Custom_Event_Property_Key2', 'Custom_Event_Property_val2');
  }

  void initDeepLinkDataPost(
      {required int shareType,
      required String userId,
      required String postId}) {
    metadata = BranchContentMetaData()
      ..addCustomMetadata("shareType", shareType)
      ..addCustomMetadata("userId", userId)
      ..addCustomMetadata("postId", postId);

    buo = BranchUniversalObject(
        canonicalIdentifier: 'flutter/branch',
        canonicalUrl: 'https://flutter.dev',
        title: 'Tindo',
        imageUrl: imageURL.value,
        contentDescription: 'Share Image',
        contentMetadata: metadata,
        keywords: ['Plugin', 'Branch', 'Flutter'],
        publiclyIndex: true,
        locallyIndex: true,
        expirationDateInMilliSec: DateTime.now()
            .add(const Duration(days: 365))
            .millisecondsSinceEpoch);

    lp = BranchLinkProperties(
        channel: 'facebook',
        feature: 'sharing',
        stage: 'new share',
        campaign: 'campaign',
        tags: ['one', 'two', 'three'])
      ..addControlParam('\$uri_redirect_mode', '1')
      ..addControlParam('\$ios_nativelink', true)
      ..addControlParam('\$match_duration', 7200)
      ..addControlParam('\$always_deeplink', true)
      ..addControlParam('\$android_redirect_timeout', 750)
      ..addControlParam('referring_user_id', 'user_id');

    eventStandard = BranchEvent.standardEvent(BranchStandardEvent.ADD_TO_CART)
      //--optional Event data
      ..transactionID = '12344555'
      ..currency = BranchCurrencyType.BRL
      ..revenue = 1.5
      ..shipping = 10.2
      ..tax = 12.3
      ..coupon = 'test_coupon'
      ..affiliation = 'test_affiliation'
      ..eventDescription = 'Event_description'
      ..searchQuery = 'item 123'
      ..adType = BranchEventAdType.BANNER
      ..addCustomData(
          'Custom_Event_Property_Key1', 'Custom_Event_Property_val1')
      ..addCustomData(
          'Custom_Event_Property_Key2', 'Custom_Event_Property_val2');

    eventCustom = BranchEvent.customEvent('Custom_event')
      ..addCustomData(
          'Custom_Event_Property_Key1', 'Custom_Event_Property_val1')
      ..addCustomData(
          'Custom_Event_Property_Key2', 'Custom_Event_Property_val2');
  }

  void generateLink() async {
    BranchResponse response =
        await FlutterBranchSdk.getShortUrl(buo: buo!, linkProperties: lp);
    if (response.success) {
      FlutterBranchSdk.handleDeepLink(response.result);
      Share.share(response.result);
    } else {
      showSnackBar(
          message: 'Error : ${response.errorCode} - ${response.errorMessage}');
    }
  }

  void showSnackBar({required String message, int duration = 1}) {
    scaffoldMessengerKey.currentState!.removeCurrentSnackBar();
    scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: duration),
      ),
    );
  }
}
