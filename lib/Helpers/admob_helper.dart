

import 'dart:io';

class AdMobHelper{

    String getAdMobAppID(){
      if(Platform.isIOS){
        return 'ca-app-pub-5731049741653158~3843403590';
      }else if(Platform.isAndroid){
        return 'ca-app-pub-5731049741653158~8807121517';
      }
      return null;
    }


    // ca-app-pub-3940256099942544/6300978111
    String getBannerAdId(){
      if(Platform.isIOS){
        // return 'ca-app-pub-5731049741653158/4345417738';
        return 'ca-app-pub-3940256099942544/6300978111';
      }else if(Platform.isAndroid){
        // return 'ca-app-pub-5731049741653158/3604564591';
        return 'ca-app-pub-3940256099942544/6300978111';
      }
      return null;
    }

}