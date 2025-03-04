import 'dart:developer';
import 'dart:io';

import 'package:html/dom.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:upgrader/upgrader.dart';

class CheckVersionConfig {
  Future<String?> getStoreVersion(String myAppBundleId) async {
    String? storeVersion;
    if (Platform.isAndroid) {
      PlayStoreSearchAPI playStoreSearchAPI = PlayStoreSearchAPI();
      Document? result2 =
          await playStoreSearchAPI.lookupById(myAppBundleId, country: 'IN');
      if (result2 != null) storeVersion = playStoreSearchAPI.version(result2);
      // log('PlayStore version: $storeVersion}');
      // } else if (Platform.isIOS) {

      // log('AppStore version: $storeVersion}');
    } else if (Platform.isIOS) {
      ITunesSearchAPI iTunesSearchAPI = ITunesSearchAPI();
      Map<dynamic, dynamic>? result =
          await iTunesSearchAPI.lookupByBundleId(myAppBundleId, country: 'IN');
      storeVersion = iTunesSearchAPI.version(result!);
    } else {
      storeVersion = null;
    }
    return storeVersion;
  }

  Future<String?> getPackageDetails() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String versionNum = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    log('packageName::${packageName}');
    return versionNum;
  }
}
