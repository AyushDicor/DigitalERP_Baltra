import 'package:digitalerp/utils/shared_pre.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TranslationService extends GetxService {
  final translations = <String, Map<String, String>>{}.obs;

  static List<String> languages = [];
  // initialize the translation service by loading the assets/locales folder
  // the assets/locales folder must contains file for each language that named
  // with the code of language concatenate with the country code
  // for example (en_US.json)
  Future<TranslationService> init() async {
    languages = [];
    await loadTranslation();
    return this;
  }

  Future<void> loadTranslation({locale}) async {
    locale = locale ?? (await getLocale()).languageCode;
    Map<String, String> _translations = {};
    Get.addTranslations({locale: _translations});
  }

  Future<Locale> getLocale() async{
    String _locale = await SharedPre.getStringValue(SharedPre.language);
    if (_locale.isEmpty) {
      _locale = Get.deviceLocale?.languageCode ?? 'en';
    }
    return fromStringToLocale(_locale);
  }

  // get list of supported local in the application
  List<Locale> supportedLocales() {
    return TranslationService.languages.map((_locale) {
      return fromStringToLocale(_locale);
    }).toList();
  }

  // Convert string code to local object
  Locale fromStringToLocale(String _locale) {
    if (_locale.contains('_')) {
      // en_US
      return Locale(_locale.split('_').elementAt(0), _locale.split('_').elementAt(1));
    } else {
      // en
      return Locale(_locale);
    }
  }
}
