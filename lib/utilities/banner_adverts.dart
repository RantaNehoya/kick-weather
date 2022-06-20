import 'dart:io';

class BannerAdverts {

  static String get bannerAdUnitId {
    if (Platform.isAndroid){
      return 'ca-app-pub-2891827121642585~7286133853';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}