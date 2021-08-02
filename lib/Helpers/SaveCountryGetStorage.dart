


import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';



class SaveCountry extends GetxController {
  final countryData = GetStorage();


  Map get getFirstCountryData => countryData.read('firstcountryData') ?? {};
  Map get getSecondCountryData => countryData.read('secondcountryData') ?? {};
  Map get getThirdCountryData => countryData.read('thirdcountryData') ?? {};
  Map get getFourthCountryData => countryData.read('fourthcountryData') ?? {};
  Map get gethistoryCountryData1 => countryData.read('historycountryData1') ?? {};
  Map get gethistoryCountryData2 => countryData.read('historycountryData2') ?? {};


  addHistoryCountryData1(Map val) async {
    await countryData.write('historycountryData1', val);
  }

  addHistoryCountryData2(Map val) async {
    await countryData.write('historycountryData2', val);
  }

  addFirstCountryData(Map val) async {
    await countryData.write('firstcountryData', val);
  }

  addSecondCountryData(Map val) async {
    await countryData.write('secondcountryData', val);
  }

  addThirdCountryData(Map val) async {
    await countryData.write('thirdcountryData', val);
  }

  addFourthCountryData(Map val) async {
    await countryData.write('fourthcountryData', val);
  }



// removeUserToken() async{
//   await userData.remove('userToken');
//   await userData.remove('userToken2');
// }

}




