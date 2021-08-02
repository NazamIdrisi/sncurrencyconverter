


import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';



class ColorData extends GetxController {
  final colorData = GetStorage();



  int get getRedData => colorData.read('red') ?? 0;
  int get getBlueData => colorData.read('blue') ?? 0;
  int get getGreenData => colorData.read('green') ?? 0;





  addRedColor(int val) {
    colorData.write('red', val);
  }
  addBlueColor(int val) {
    colorData.write('blue', val);
  }
  addGreenColor(int val) {
    colorData.write('green', val);
  }


  addBackgroundRedColor(int val) {
    colorData.write('red', val);
  }
  addBackgroundBlueColor(int val) {
    colorData.write('blue', val);
  }
  addBackgroundGreenColor(int val) {
    colorData.write('green', val);
  }

  // removeUserToken() async{
  //   await userData.remove('userToken');
  //   await userData.remove('userToken2');
  // }

}




