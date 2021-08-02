import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sncurrencyconverter/Constants/Colors.dart';
import 'package:sncurrencyconverter/Controllers/HomeController.dart';
import 'package:sncurrencyconverter/Helpers/RouteHelper.dart';
import 'package:sncurrencyconverter/Helpers/SaveColors.dart';
import 'package:sncurrencyconverter/Helpers/SaveCountryGetStorage.dart';
import 'package:sncurrencyconverter/Helpers/SaveTranslationText.dart';
import 'package:sncurrencyconverter/Helpers/admob_helper.dart';
import 'package:sncurrencyconverter/MyTestCalculator/calculator.dart';
import 'package:sncurrencyconverter/MyTestCalculator/constants.dart';
import 'package:sncurrencyconverter/MyTestCalculator/screens/widgets/displayer.dart';
import 'package:sncurrencyconverter/MyTestCalculator/screens/widgets/keyboart.dart';
import 'package:sncurrencyconverter/MyTestCalculator/utils/ColorList.dart';
import 'package:sncurrencyconverter/MyTestCalculator/utils/customSearchableDropDown.dart';
import 'package:sncurrencyconverter/MyTestCalculator/utils/utils.dart';
import 'package:country_picker/country_picker.dart';
import 'package:sncurrencyconverter/Views/Dialog/AlertDialogue.dart';
import 'package:sncurrencyconverter/Views/Pages/AllTranslateNames.dart';
import 'package:sncurrencyconverter/Views/Pages/FilterCountries.dart';
import 'package:sncurrencyconverter/Views/Pages/SearchHistoricalData.dart';
import 'package:admob_flutter/admob_flutter.dart';



class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _primaryDisplayerText = '';
  String _SecondDisplayerText = '';
  String _ThirdDisplayerText = '';
  String _FourthDisplayerText = '';
  String _secondaryDisplayerText = '';
  List countriesList = [];
  List HistoryList = [];
  int tabIndex = 0;
  List tabs = [];
  int red = 0;
  int blue = 0;
  int green = 255;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  HomeController homeController = HomeController();
  bool visible = false;
  Map translatetxt = {};
  bool VisibleAd = false;


  Map FirstCountry = {};
  Map SecondCountry = {};
  Map ThirdCountry = {};
  Map FourthCountry = {};
  final ams  = AdMobHelper();
  AdmobBanner adbanner;

  @override
  void initState() {
    super.initState();
    Admob.initialize(ams.getAdMobAppID());
    get();

  }


  get() async{
    await getcountrymap();
    await getcolor();
    await getHistory();
    await gettranstaletext();
    await loadad();
  }

  loadad() async{

    setState(() {
      VisibleAd = true;
    });

    adbanner = AdmobBanner(
      adUnitId: ams.getBannerAdId(),
      adSize: AdmobBannerSize.FULL_BANNER,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.loaded){
          print("LOADED ADDD");

          setState(() {
            VisibleAd = false;
          });
          setfalsedata();
          // handleEvent(event, args, 'Interstitial');
        }else if(event == AdmobAdEvent.completed){
          print("COMPLETED");
          setState(() {
            VisibleAd = false;
          });
        }else if(event == AdmobAdEvent.started){
          print("Started");
          setState(() {
            VisibleAd = false;
          });
        }

      },
    );


    print("ISVISIBLE"+VisibleAd.toString());
  }


  setfalsedata(){

    setState(() {
      VisibleAd = false;
    });

    print("ISVISIBLE"+VisibleAd.toString());
  }

  gettranstaletext() async{

    var data = await SaveTranslationText().getTranslateData;
    setState(() {
      translatetxt = data;
    });

  }

  getHistory() async{

    var data = await dbHelper.getHistory();
    print("================ HISTORY "+data.toString());
    setState(() {
      HistoryList = data;
    });
    // if(HistoryList.toString() == "[]"){
    //   HistoryList.clear();
    // }else{
    //   setState(() {
    //     HistoryList = data;
    //   });
    // }

  }

  getcountrymap(){

    var data = SaveCountry().getFirstCountryData;
    var seconddata = SaveCountry().getSecondCountryData;
    var thirddata = SaveCountry().getThirdCountryData;
    var fourthdata = SaveCountry().getFourthCountryData;
    setState(() {
      FirstCountry = data;
      SecondCountry = seconddata;
      ThirdCountry = thirddata;
      FourthCountry = fourthdata;
    });

    print("FIRST COUNTRY"+ FirstCountry.toString());

  }

  getcolor(){

    var aa = ColorData().getRedData;
    var bb= ColorData().getGreenData;
    var cc = ColorData().getBlueData;
    print("RED"+aa.toString());
    print("Greeb"+bb.toString());
    print("blue"+cc.toString());


  }


  void buttonPressed(String id) async{

    setState(
      () {
        if (id == ButtonId.ac) {
          _primaryDisplayerText = '';
          _secondaryDisplayerText = '';
        } else if (id == ButtonId.equal) {
          double result = calculate(_primaryDisplayerText);
          if (result != double.infinity) {
            // _secondaryDisplayerText = _primaryDisplayerText;
            _primaryDisplayerText = cleanResult(result);
          } else {
            _secondaryDisplayerText = 'Bad expression';
          }
        } else if (id == ButtonId.backspace) {
          _primaryDisplayerText =
              _primaryDisplayerText.replaceAll(RegExp(r'.$'), '');
          double result = calculate(_primaryDisplayerText);
          if (result != double.infinity)
            _secondaryDisplayerText = cleanResult(result);
        } else {
          _primaryDisplayerText += id;
          double result = calculate(_primaryDisplayerText);
          if (result != double.infinity)
            _secondaryDisplayerText = cleanResult(result);
        }
      },
    );



    // print("CLICK");
    print(_secondaryDisplayerText);
    print(_secondaryDisplayerText.length.toString() + " LEN");
    print(_primaryDisplayerText.toString());

    if(_primaryDisplayerText.isEmpty){
      print("PRIMARY EMPTY ");
      setState(() {

        _secondaryDisplayerText = '0';
      });
    }
    if(id == ButtonId.ac){
      setState(() {
        _SecondDisplayerText = '0';
        _ThirdDisplayerText = '0';
        _FourthDisplayerText = '0';
      });
    }else if(id == ButtonId.equal && _secondaryDisplayerText == '0'){
      setState(() {
        _SecondDisplayerText = '0';
        _ThirdDisplayerText = '0';
        _FourthDisplayerText = '0';
      });

    }else if(id == ButtonId.backspace && _secondaryDisplayerText == '0'){
      setState(() {
        _SecondDisplayerText = '0';
        _ThirdDisplayerText = '0';
        _FourthDisplayerText = '0';
      });
    }  else{
      setState(() {
        visible = true;
      });

      var data = await homeController.ConvertCurrency(_secondaryDisplayerText,FirstCountry,SecondCountry,ThirdCountry,FourthCountry,context);

      print("ALL CONVERTED DATA ONLIE"+data.toString());
      if(data['notfound'] == true){

        setState(() {
          _SecondDisplayerText = data['Second'].toString();
          _ThirdDisplayerText = data['Third'].toString();
          _FourthDisplayerText = data['Fourth'].toString();
          visible = false;
        });

        // AlertDialogue().showtoast("Please Turn On Your Internet For First Time Converting Currency.");
        AlertDialogue().showtoast(translatetxt['AlertTextFirstTimeConvert_Text'].toString());
      }else{

        setState(() {
          _SecondDisplayerText = data['Second'].toString();
          _ThirdDisplayerText = data['Third'].toString();
          _FourthDisplayerText = data['Fourth'].toString();
          visible = false;
        });

      }
      getHistory();


    }


  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          // Padding(
          //   padding: EdgeInsets.only(right: 10),
          //   child: Icon(Icons.more_vert),
          // ),

          PopupMenuButton<String>(
            color: primarycolor,
            onSelected: (val){
                  if(val.toString() == translatetxt['ChangeColorScheme_Text'].toString()){
                   showcolordialog();
                  }else if(val.toString() == translatetxt['Translate_Text'].toString()) {
                    RouteHelper().gotonext(context, AllTranslateNames());
                  }else if(val.toString() == translatetxt['History_Text'].toString()){
                    // showHistoryDialog();
                        RouteHelper().gotonext(context, SearchHistoricalData());
                  }
            },
            itemBuilder: (BuildContext context) {
              // LocaleKeys.ChangeColorScheme_Text.tr()
              // 'Change Color Scheme', 'Translate'
              return {translatetxt['ChangeColorScheme_Text'].toString(), translatetxt['Translate_Text'].toString(),translatetxt['History_Text'].toString()}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  // child: Text(choice,style: TextStyle(color: Colors.white),),
                  child: Text(choice,style: TextStyle(color: Colors.white),),
                );
              }).toList();
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: [

                  // First Country Section
                  GestureDetector(
                    onTap: () async{
                      // setState(() {
                      //   tabIndex = 1;
                      // });

                      showbottm(1);
                    },
                    child: Container(
                      width: screen.width*1,
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: CircleAvatar(
                                  radius: 20,
                                  child: SvgPicture.asset("assets/countries/${FirstCountry['img']}.svg"),
                                ),
                              )
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Container(
                              width: screen.width,
                              // child: Displayer(
                              //     primaryText: _primaryDisplayerText,
                              //     secondaryText: _secondaryDisplayerText
                              // ),
                              child: Text(_primaryDisplayerText.toString() == '' ? "0" : _primaryDisplayerText.toString(),style: TextStyle(fontSize: 35,color: whitecolor),),
                              // child: Text( _secondaryDisplayerText.toString() == '' ?  "0" : _secondaryDisplayerText ,style: TextStyle(fontSize: 35,color: whitecolor),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1.0,
                    color: greycolor,
                  ),
                  // Second Country Section
                  GestureDetector(
                    onTap: () async{
                      // setState(() {
                      //   tabIndex = 1;
                      // });

                      showbottm(2);
                    },
                    child: Container(
                      width: screen.width*1,
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: ColorData().getRedData == 0 ?   Color.fromRGBO(241, 137, 0, 1) :  Color.fromRGBO(ColorData().getRedData, ColorData().getGreenData, ColorData().getBlueData, 1),
                                  child: SecondCountry == null ? Text("?") : SecondCountry.toString() == "{}" ? Text("?") : SvgPicture.asset("assets/countries/${SecondCountry['img']}.svg"),
                                ),
                              )
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            flex:visible ? 0 : 1,
                            child: Container(
                              width: visible ? screen.width*0.1 : screen.width,
                              // child: Displayer(
                              //     primaryText: _primaryDisplayerText,
                              //     secondaryText: _secondaryDisplayerText
                              // ),
                              child:  visible ? SizedBox(
                                height: 30,
                                width: 10,
                                child: LoadingIndicator(
                                  indicatorType: Indicator.ballPulse,
                                  colors: [
                                    Color.fromRGBO(ColorData().getRedData, ColorData().getGreenData, ColorData().getBlueData, 1),
                                  ],
                                  strokeWidth: 1,
                                ),
                              )
                                  : Text(_SecondDisplayerText.toString() == '' ? "0" : _SecondDisplayerText.toString(),style: TextStyle(fontSize: 35,color: whitecolor),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1.0,
                    color: greycolor,
                  ),
                  // Third Country Section
                  GestureDetector(
                    onTap: () async{
                      // setState(() {
                      //   tabIndex = 1;
                      // });

                      showbottm(3);
                    },
                    child: Container(
                      width: screen.width*1,
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: ColorData().getRedData == 0 ?   Color.fromRGBO(241, 137, 0, 1) :  Color.fromRGBO(ColorData().getRedData, ColorData().getGreenData, ColorData().getBlueData, 1),
                                  child: ThirdCountry == null ? Text("?") : ThirdCountry.toString() == "{}" ? Text("?") : SvgPicture.asset("assets/countries/${ThirdCountry['img']}.svg"),
                                ),
                              )
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            flex:visible ? 0 : 1,
                            child: Container(
                              width: visible ? screen.width*0.1 : screen.width,
                              // child: Displayer(
                              //     primaryText: _primaryDisplayerText,
                              //     secondaryText: _secondaryDisplayerText
                              // ),
                              child: visible ?
                              SizedBox(
                                height: 30,
                                width: 10,
                                child: LoadingIndicator(
                                  indicatorType: Indicator.ballPulse,
                                  colors: [
                                    Color.fromRGBO(ColorData().getRedData, ColorData().getGreenData, ColorData().getBlueData, 1),
                                  ],
                                  strokeWidth: 1,
                                ),
                              )
                                  :Text(_ThirdDisplayerText.toString() == '' ? "0" : _ThirdDisplayerText.toString(),style: TextStyle(fontSize: 35,color: whitecolor),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1.0,
                    color: greycolor,
                  ),
                  // Fourth Country Section
                  GestureDetector(
                    onTap: () async{
                      // setState(() {
                      //   tabIndex = 1;
                      // });

                      showbottm(4);
                    },
                    child: Container(
                      width: screen.width*1,
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: ColorData().getRedData == 0 ?   Color.fromRGBO(241, 137, 0, 1) :  Color.fromRGBO(ColorData().getRedData, ColorData().getGreenData, ColorData().getBlueData, 1),
                                  child: FourthCountry == null ? Text("?") : FourthCountry.toString() == "{}" ? Text("?") : SvgPicture.asset("assets/countries/${FourthCountry['img']}.svg"),
                                ),
                              )
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            flex:visible ? 0 : 1,
                            child: Container(
                              width: visible ? screen.width*0.1 : screen.width,
                              // child: Displayer(
                              //     primaryText: _primaryDisplayerText,
                              //     secondaryText: _secondaryDisplayerText
                              // ),
                              child: visible ?
                              SizedBox(
                                height: 30,
                                width: 10,
                                child: LoadingIndicator(
                                  indicatorType: Indicator.ballPulse,
                                  colors: [
                                    Color.fromRGBO(ColorData().getRedData, ColorData().getGreenData, ColorData().getBlueData, 1),
                                  ],
                                  strokeWidth: 1,
                                ),
                              )
                                  :Text(_FourthDisplayerText.toString() == '' ? "0" : _FourthDisplayerText.toString(),style: TextStyle(fontSize: 35,color: whitecolor),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Divider(
                    thickness: 1.0,
                    color: greycolor,
                  ),

                  // Displayer(
                  //     primaryText: _primaryDisplayerText,
                  //     secondaryText: _secondaryDisplayerText),
                ],
              ),
            ),
            Container(
              height: screen.height*0.46,
              width: screen.width*1,
              child: Keyboard(buttonPressed),
            ),
          ],
        ),
      ),
      bottomNavigationBar:adbanner
    );
  }


  setcolor(red,green,blue) async{

    await ColorData().addRedColor(red);
    await ColorData().addBlueColor(blue);
    await ColorData().addGreenColor(green);

    Navigator.of(context).pop();
    Route route = MaterialPageRoute(builder: (context) => HomeScreen());
    Navigator.pushReplacement(context, route);

  }

  setbackgroundcolor(red,green,blue) async{

    await ColorData().addBackgroundRedColor(red);
    await ColorData().addBackgroundBlueColor(blue);
    await ColorData().addBackgroundGreenColor(green);

    Navigator.of(context).pop();
    Route route = MaterialPageRoute(builder: (context) => HomeScreen());
    Navigator.pushReplacement(context, route);
  }

  showHistoryDialog() {

    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
            child: ListBody(
              children: <Widget>[

                Container(
                    color: primarycolor,
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.symmetric(vertical: 50,horizontal: 15),
                    width: Get.width*0.6,
                    child: Column(
                      children: [

                        SizedBox(height: 10,),
                        Text(translatetxt['History_Text'].toString(),style: TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize: 14),),
                        SingleChildScrollView(
                          child: ListView.builder(
                            itemCount: HistoryList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index){
                              // print("============================= HISTORY IMAGE "+ HistoryList[index]['FirstCountry']['img'].toString());
                              return Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(25),
                                                    child: CircleAvatar(
                                                      radius: 20,
                                                      backgroundColor: ColorData().getRedData == 0 ?   Color.fromRGBO(241, 137, 0, 1) :  Color.fromRGBO(ColorData().getRedData, ColorData().getGreenData, ColorData().getBlueData, 1),
                                                      child: SvgPicture.asset("assets/countries/${HistoryList[index]['FirstCountry']}.svg"),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10,),
                                                  Text(HistoryList[index]['ConvertAmountFirst'].toString(),style: TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize:23),),

                                                ],
                                              ),
                                              SizedBox(height: 20,),
                                              Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(25),
                                                    child: CircleAvatar(
                                                      radius: 20,
                                                      backgroundColor: ColorData().getRedData == 0 ?   Color.fromRGBO(241, 137, 0, 1) :  Color.fromRGBO(ColorData().getRedData, ColorData().getGreenData, ColorData().getBlueData, 1),
                                                      child: SvgPicture.asset("assets/countries/${HistoryList[index]['SecondCountry']}.svg"),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10,),
                                                  Text(HistoryList[index]['ConvertAmountSecond'].toString(),style: TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize:23),),

                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(25),
                                                    child: CircleAvatar(
                                                      radius: 20,
                                                      backgroundColor: ColorData().getRedData == 0 ?   Color.fromRGBO(241, 137, 0, 1) :  Color.fromRGBO(ColorData().getRedData, ColorData().getGreenData, ColorData().getBlueData, 1),
                                                      child: SvgPicture.asset("assets/countries/${HistoryList[index]['ThirdCountry']}.svg"),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10,),
                                                  Text(HistoryList[index]['ConvertAmountThird'].toString(),style: TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize:23),),

                                                ],
                                              ),
                                              SizedBox(height: 20,),
                                              Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(25),
                                                    child: CircleAvatar(
                                                      radius: 20,
                                                      backgroundColor: ColorData().getRedData == 0 ?   Color.fromRGBO(241, 137, 0, 1) :  Color.fromRGBO(ColorData().getRedData, ColorData().getGreenData, ColorData().getBlueData, 1),
                                                      child: SvgPicture.asset("assets/countries/${HistoryList[index]['FourthCountry']}.svg"),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10,),
                                                  Text(HistoryList[index]['ConvertAmountFourth'].toString(),style: TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize:23),),

                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Divider(
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        ),
                      ],
                    )
                )
              ],
            ));
      },
      animationType: DialogTransitionType.slideFromBottomFade,
      curve: Curves.easeIn,
    );

  }

  showcolordialog() {

    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
            child: ListBody(
              children: <Widget>[

                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.symmetric(vertical: 50,horizontal: 15),
                  width: Get.width*0.6,
                  child: Column(
                    children: [
                      // Container(
                      //   child: Column(
                      //     children: [
                      //       SizedBox(height: 20,),
                      //       Text("Select Background",style: TextStyle(color: Colors.black,decoration: TextDecoration.none,fontSize: 14),),
                      //       SizedBox(height: 20,),
                      //       Row(
                      //         children: [
                      //           Expanded(
                      //             child: GestureDetector(
                      //               onTap: (){
                      //                 setbackgroundcolor(7, 16, 21,);
                      //               },
                      //               child: Container(
                      //                 height: 20,
                      //                 width: Get.width,
                      //                 decoration: BoxDecoration(
                      //                   color: Color.fromRGBO(7, 16, 21, 1)
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //           Expanded(
                      //             child: Container(
                      //               height: 20,
                      //               width: Get.width,
                      //               decoration: BoxDecoration(
                      //                   color: Color.fromRGBO(255, 255, 255, 1)
                      //               ),
                      //               child: Text("White Color",textAlign: TextAlign.center,style: TextStyle(decoration: TextDecoration.none,fontSize: 10,color: Colors.black),),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //
                      //     ],
                      //   ),
                      // ),
                      SizedBox(height: 10,),
                      Text(translatetxt['SelectColor_Text'].toString(),style: TextStyle(color: Colors.black,decoration: TextDecoration.none,fontSize: 14),),
                      SingleChildScrollView(
                        child: GridView.builder(
                          shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6,
                                childAspectRatio: 2 / 2,
                                crossAxisSpacing: 3,
                                mainAxisSpacing: 3),
                          itemCount: ColorList.length,
                          itemBuilder: (context,index){
                            var red  = ColorList[index]['rgb'].toString().split(",")[0];
                            var green =ColorList[index]['rgb'].toString().split(",")[1];
                            var blue = ColorList[index]['rgb'].toString().split(",")[2];
                              return GestureDetector(
                                onTap: (){
                                  setcolor(int.parse(red), int.parse(green), int.parse(blue));
                                },
                                child: Container(
                                    height: 40,
                                    width: 50,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(int.parse(red), int.parse(green), int.parse(blue), 1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                            ),
                              );
                          },
                        ),
                      ),
                    ],
                  )
                )
              ],
            ));
      },
      animationType: DialogTransitionType.size,
      curve: Curves.linear,
    );

  }


  showbottm(ind) async{


    RouteHelper().gotonext(context, FilterCountries(conid:ind));


  }

}
