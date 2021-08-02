import 'package:flutter/material.dart';
import 'package:sncurrencyconverter/Animations/FadeAnimationUp.dart';
import 'package:sncurrencyconverter/Constants/Colors.dart';
import 'package:sncurrencyconverter/Helpers/SaveCountryGetStorage.dart';
import 'package:sncurrencyconverter/MyTestCalculator/screens/home_screen.dart';
import 'package:sncurrencyconverter/Views/Pages/SelectCountryOnStartUp.dart';


class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3),(){
      check();
    });
  }

  check() async{

    var data =  SaveCountry().getFirstCountryData;


    print(data);
    // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomeScreen()), (Route<dynamic> route) => false);

    if(data.toString() == "{}"){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => SelectCountryOnStartUp()), (Route<dynamic> route) => false);

    }else{

      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => SelectCountryOnStartUp()), (Route<dynamic> route) => false);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomeScreen()), (Route<dynamic> route) => false);

    }


  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Container(
      color: primarycolor,
      height: screen.height*1,
      width: screen.width*1,
      child: Center(
        child: Image.asset("assets/logo.png",height: 100,width: 100,),
        // child: FadeAnimationUp(0.1,Image.asset("assets/logo.png",height: 100,width: 100,),),
      )
    );
  }
}
