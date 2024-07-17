import 'package:connectivity/connectivity.dart';
import 'package:cupertino_modal_sheet/cupertino_modal_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';
import '../data/cache/view_state.dart';
import '../data/repository/repository.service.dart';
import '../data/services/local/cache.service.dart';
import '../data/services/local/locale.service.dart';
import '../data/services/local/storage.service.dart';
import '../data/services/local/user.service.dart';
import '../widget/action-widget.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.Loading;
  LocaleService localeService = locator<LocaleService>();
  UserService userService = locator<UserService>();
  AppCache appCache = locator<AppCache>();
  StorageService storageService = locator<StorageService>();
  Repository repository = locator<Repository>();

  ViewState get viewState => _viewState;

  final formKey = GlobalKey<FormState>();
  final GlobalKey repaintKey = GlobalKey();


  Future<bool> isConnectedToNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  String convertPhoneNumber(String number) {
    String replacement = "0";
    if (number.length < 3) {
      // If the input string is less than 3 characters, replace the entire string
      return replacement + number.substring(replacement.length);
    } else {
      // Replace the first 3 characters and concatenate the rest of the string
      return replacement + number.substring(3);
    }
  }

  showLogout()async{
    // popDialog(
    //   context: navigationService.navigatorKey.currentState!.context,
    //   onTap: userService.logout,
    //   title: "${LocaleData.logOut.convertString()} ${(userService.user.user?.firstName??"").toTitleCase()} ${(userService.user.user?.lastName??"").toTitleCase()}",
    //   subTitle: LocaleData.confirmLogOut.convertString()
    // );
  }

  getUser() async {
    startLoader();
    try{
      // var res = await repository.getUser();
    }catch(err){
      debugPrint(err.toString());
    }
    stopLoader();
    notifyListeners();
  }

  set viewState(ViewState newState) {
    _viewState = newState;
    _viewState == ViewState.Loading ? isLoading = true : isLoading = false;
    notifyListeners();
  }

  logOuts(BuildContext context) {
    popDialog(context: context, onTap: userService.logout, title: "Log out");
  }

  bool isLoading = false;

  void startLoader() {
    if (!isLoading) {
      isLoading = true;
      viewState = ViewState.Loading;
      notifyListeners();
    }
  }



  String getFileTypeFromUrl(String url) {
    List<String> parts = url.split('/');
    String fileName = parts.last;
    List<String> fileNameParts = fileName.split('.');

    if (fileNameParts.length > 1) {
      String extension = fileNameParts.last;
      switch (extension.toLowerCase()) {
        case 'jpg':
        case 'jpeg':
        case 'png':
        case 'svg':
        case 'heic':
        case 'webp':
          return 'image.${extension.toLowerCase()}';
        case 'mp4':
        case 'avi':
        case 'mov':
          return 'video.${extension.toLowerCase()}';
        case 'pdf':
          return 'PDF.${extension.toLowerCase()}';
        case 'docx':
        case 'doc':
          return 'Document.${extension.toLowerCase()}';
        default:
          return 'Unknown';
      }
    } else {
      return 'Unknown';
    }
  }

  Future popDialog({
    required BuildContext context,
    VoidCallback? onTap,
    VoidCallback? otherOnTap,
    String? title,
    String? subTitle,
    String? cancelButtonText,
    String? doItButtonText,
    Widget? prefixIcon1,
    Widget? child,
    Widget? prefixIcon2,
  }) async {
    return await showCupertinoModalSheet(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ActionBottomSheet(
        onTap: onTap,
        title: title,
        subTitle: subTitle,
        cancelButtonText: cancelButtonText,
        doItButtonText: doItButtonText,
        prefixIcon1: prefixIcon1,
        prefixIcon2: prefixIcon2,
        otherOnTap: otherOnTap,
        child: child,
      )
    );
  }

  void stopLoader() {
    if (isLoading) {
      isLoading = false;
      viewState = ViewState.Idle;
      notifyListeners();
    }
  }


}