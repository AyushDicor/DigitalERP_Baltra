import 'package:digitalerp/response/login_response.dart';
import 'package:digitalerp/utils/shared_pre.dart';
import 'package:get/get.dart';

class UserDataController extends GetxController {

  Future<UserData?> get getUserData async {
    var obj = await SharedPre.getObjs(SharedPre.userData);
    if (obj != null && obj.isNotEmpty) {
      return UserData.fromJson(obj);
    }
    return null;
  }
  // Future<UserData?> get getUserData async {
  //   var obj = await SharedPre.getObjs(SharedPre.userData);
  //   if (obj.isNotEmpty) {
  //     return UserData.fromJson(obj);
  //   } else {
  //     return null;
  //   }
  // }

/*

  void updateUserData(ProfileData profileData) {
    UserData? userData = new UserData();

    userData.userId = profileData.id.toString();
    userData.name = profileData.name;
    userData.email = profileData.email;
    userData.token = currentUser.token;
    userData.isEmailVerified = '1';
    userData.isCategorySelected = currentUser.isCategorySelected.toString();
    userData.isTopicSelected = currentUser.isTopicSelected.toString();
    userData.firstName = profileData.firstName;
    userData.lastName = profileData.lastName;
    userData.deviceId = profileData.deviceId;
    userData.profileUrl = profileData.profileUrl;
    userData.locale = profileData.locale;

    userData.countryId = profileData.country != null ? profileData.country : '';
    userData.websiteLink =
    profileData.websiteLink != null ? profileData.websiteLink : '';
    userData.websiteVerified = profileData.websiteVerified;
    userData.viewCount = profileData.viewCount;
    userData.isPaymentDisplay = profileData.isPaymentDisplay;
    userData.tagLine = profileData.tagLine != null ? profileData.tagLine : '';
    userData.countryName =
    profileData.countryName != null ? profileData.countryName : '';
    userData.aboutMe = profileData.aboutMe != null ? profileData.aboutMe : '';
    userData.facebook =
    profileData.facebook != null ? profileData.facebook : '';
    userData.twitter = profileData.twitter != null ? profileData.twitter : '';
    userData.linkedin =
    profileData.linkedin != null ? profileData.linkedin : '';
    userData.instagram =
    profileData.instagram != null ? profileData.instagram : '';
    userData.pinterest =
    profileData.pinterest != null ? profileData.pinterest : '';
    userData.myGroup = profileData.myGroup != null ? profileData.myGroup : '';
    userData.displayPost = profileData.displayPost;
    userData.youHaveFavouriteNotify = profileData.youHaveFavouriteNotify;
    userData.youHaveFavouriteEmail = profileData.youHaveFavouriteEmail;
    userData.youHaveCommentNotify = profileData.youHaveCommentNotify;
    userData.youHaveCommentEmail = profileData.youHaveCommentEmail;
    userData.youHaveSelectedCategoriesEmail =
        profileData.youHaveSelectedCategoriesEmail;
    userData.youHaveSelectedCategoriesNotify =
        profileData.youHaveSelectedCategoriesNotify;
    userData.youHaveSelectedPostEmail = profileData.youHaveSelectedPostEmail;
    userData.imageThumb = profileData.imageThumb;
    userData.imageLarge = profileData.imageLarge;
    userData.points = '${profileData.points}';
    userData.tags = profileData.tags;

    currentUser = userData;

    PreferencesManagement.save(PMKeys.USERDATA, jsonEncode(userData));
  }
  */
}
