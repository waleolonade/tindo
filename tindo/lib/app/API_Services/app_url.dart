import 'dart:developer';

class ApiUrl {
  static const userLocationURL = "http://ip-api.com/json";
}

class Constant {
  ///////////// API //////////

  static const BASE_URL = "";  // Enter your base URL like :: http://182.168.19.35:5000/
  static const SECRET_KEY = "";  // Enter your key like :: ssf45sd1fs5d1sdf1s56165s15sdf1s

  static const settingUrl = "setting";
  static const countryUrl = "flag";
  static const userLogin = "user/login";
  static const bannerUrl = "banner";
  static const coinsPlanUrl = "coinPlan/appPlan";
  static const liveUser = "liveUser";

  static const followListUrl = "/follow/showFriends";
  static const followRequestUrl = "/follow/request";
  static const userProfileUrl = "user/profile";
  static const createPostUrl = "post";
  static const getPostUrl = "/post";
  static const getSinglePostUrl = "post/postById";
  static const sendLike = "/like";
  static const getGiftUrl = 'gift';
  static const sendGiftUrl = "/userGift";
  static const postReport = "/report";
  static const blockRequest = "/block";
  static const blockUserList = "/block";
  static const createComment = "/comment";
  static const showComment = "/comment";
  static const editProfile = "/user";

  static const userThumbListUrl = "liveUser/liveHostList";
  static const createChatTopicUrl = "/chatTopic/createRoom";

  static const chatThumbListUrl = "chatTopic/chatList";
  static const oldChatUri = "/chat/getOldChat";

  static const makeCallUri = "history/makeCall";

  static const sendChatFileUrl = "chat/createChat";

  static const deletePost = "/post";

  // static const withdrawalUri = "redeem";
  static const getWithdrawalUri = "withdraw";
  static const withdrawRequest = "withdrawRequest";
  static const getWithdrawList = "/withdrawRequest";
  static const updateFCMUri = "/notification/updateFCM";
  static const liveEndHistoryUri = "/liveUser/afterLiveHistory";
  static const notificationUri = "/notification";

  static const deleteNotification = "/notification";
  static const successPurchaseUri = "coinPlan/createHistory";
  static const fakeGift = "/userFake/fakeUserCutCoin";
  static const deleteAccount = "/user/deleteUserAccount";

  static String getDomainFromURL(String url) {
    final uri = Uri.parse(url);
    String host = uri.host;
    if (host.startsWith("www.")) {
      return host.substring(4);
    }
    log("object::::::host uri:::$host");
    return host;
  }
}
