import 'dart:io';

class BannerAdverts {

  static String get bannerAdUnitId {
    if (Platform.isAndroid){
      return 'ca-app-pub-3940256099942544/6300978111'; //TODO
    } else {
      throw UnsupportedError('Unsupported plaftorm');
    }
  }
}