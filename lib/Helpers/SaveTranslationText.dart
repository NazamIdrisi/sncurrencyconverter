

import 'package:get_storage/get_storage.dart';

class SaveTranslationText{

  final transhationData = GetStorage();

  Map get getTranslateData => transhationData.read('translate') ?? {
    "hi_text": "Hello",
    "ChangeColorScheme_Text": "Change Color Scheme",
    "Translate_Text": "Language",
    "History_Text": "History",
    "SelectColor_Text": "Select Color",
    "SelectCountry_Text": "Select Country",
    "Search_Text": "Search",
    "AlertTextFirstTimeConvert_Text": "Please Turn On Your Internet For First Time Converting Currency."
  };

  addTranslationData(Map val) async {
    await transhationData.write('translate', val);
  }

}