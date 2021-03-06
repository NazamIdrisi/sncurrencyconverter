import 'package:flutter/material.dart';
import 'package:sncurrencyconverter/Constants/Colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sncurrencyconverter/Helpers/SaveTranslationText.dart';
import 'package:sncurrencyconverter/MyTestCalculator/screens/home_screen.dart';
import '../../transslation/local_keys.g.dart';

class AllTranslateNames extends StatefulWidget {

  @override
  _AllTranslateNamesState createState() => _AllTranslateNamesState();
}

class _AllTranslateNamesState extends State<AllTranslateNames> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Container(
      color: Color(0xFF292D36),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF292D36),
            title: Text("Language"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 20,left: 16,right: 16),
              child: Column(
                children: [

                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async{
                            // await context.setLocale(Locale('en'));

                            Map<String,dynamic> val = {
                              "hi_text": "Hello",
                              "ChangeColorScheme_Text": "Change Color Scheme",
                              "Translate_Text": "Language",
                              "History_Text": "History",
                              "SelectColor_Text": "Select Color",
                              "SelectCountry_Text": "Select Country",
                              "Search_Text": "Search",
                              "AlertTextFirstTimeConvert_Text": "Please Turn On Your Internet For First Time Converting Currency."
                            };

                           await SaveTranslationText().addTranslationData(val);

                            Navigator.pop(context);
                            Route route = MaterialPageRoute(builder: (context) => HomeScreen());
                            Navigator.pushReplacement(context, route);

                          },
                          child: Container(
                            height: 180,
                            width: screen.width*1,
                            decoration: BoxDecoration(
                              color: primarycolor.withOpacity(0.7)
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Text("EN",style: TextStyle(color: Colors.white.withOpacity(0.4),fontSize:screen.height*0.1,),),
                                ),
                                Positioned(
                                  top: 15,
                                  left: 15,
                                  child: Text("English",style: TextStyle(color: Colors.white.withOpacity(0.8),fontSize:screen.height*0.05),),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async{
                            // await context.setLocale(Locale('fr'));
                            Map<String,dynamic> val = {
                              "hi_text": "Hello FR",
                              "ChangeColorScheme_Text": "Changer le sch??ma de couleurs",
                              "Translate_Text": "changer de langue",
                              "History_Text": "voir l'histoire",
                              "SelectColor_Text": "Choisissez la couleur",
                              "SelectCountry_Text": "choisissez le pays",
                              "Search_Text": "Chercher",
                              "AlertTextFirstTimeConvert_Text": "Veuillez activer votre Internet pour la premi??re conversion de devise."
                            };

                            await SaveTranslationText().addTranslationData(val);

                            Navigator.pop(context);
                            Route route = MaterialPageRoute(builder: (context) => HomeScreen());
                            Navigator.pushReplacement(context, route);

                          },
                          child: Container(
                            height: 180,
                            width: screen.width*1,
                            decoration: BoxDecoration(
                                color: primarycolor.withOpacity(0.7)
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Text("FR",style: TextStyle(color: Colors.white.withOpacity(0.4),fontSize:screen.height*0.1,),),
                                ),
                                Positioned(
                                  top: 15,
                                  left: 15,
                                  child: Text("French",style: TextStyle(color: Colors.white.withOpacity(0.8),fontSize:screen.height*0.05),),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async{
                            // await context.setLocale(Locale('th'));

                            Map<String,dynamic> val = {
                              "hi_text": "Hello THAI",
                              "ChangeColorScheme_Text": "???????????????????????????????????????????????????",
                              "Translate_Text": "?????????????????????????????????",
                              "History_Text": "???????????????????????????",
                              "SelectColor_Text": "?????????????????????",
                              "SelectCountry_Text": "?????????????????????????????????",
                              "Search_Text": "???????????????",
                              "AlertTextFirstTimeConvert_Text": "????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????"
                            };

                            await SaveTranslationText().addTranslationData(val);

                            Navigator.pop(context);
                            Route route = MaterialPageRoute(builder: (context) => HomeScreen());
                            Navigator.pushReplacement(context, route);

                          },
                          child: Container(
                            height: 180,
                            width: screen.width*1,
                            decoration: BoxDecoration(
                                color: primarycolor.withOpacity(0.7)
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Text("TH",style: TextStyle(color: Colors.white.withOpacity(0.4),fontSize:screen.height*0.1,),),
                                ),
                                Positioned(
                                  top: 15,
                                  left: 15,
                                  child: Text("Thai",style: TextStyle(color: Colors.white.withOpacity(0.8),fontSize:screen.height*0.05),),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async{
                            // await context.setLocale(Locale('hi'));

                            Map<String,dynamic> val = {
                              "hi_text": "Hello Hindi",
                              "ChangeColorScheme_Text": "????????? ??????????????? ???????????????",
                              "Translate_Text": "???????????? ????????????",
                              "History_Text": "?????????????????? ???????????????",
                              "SelectColor_Text": "????????? ????????????",
                              "SelectCountry_Text": "????????? ???????????????",
                              "Search_Text": "?????????",
                              "AlertTextFirstTimeConvert_Text": "??????????????? ???????????? ????????? ?????????????????? ??????????????? ?????? ????????? ???????????? ????????????????????? ???????????? ???????????????"
                            };

                            await SaveTranslationText().addTranslationData(val);

                            Navigator.pop(context);
                            Route route = MaterialPageRoute(builder: (context) => HomeScreen());
                            Navigator.pushReplacement(context, route);

                          },
                          child: Container(
                            height: 180,
                            width: screen.width*1,
                            decoration: BoxDecoration(
                                color: primarycolor.withOpacity(0.7)
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Text("HI",style: TextStyle(color: Colors.white.withOpacity(0.4),fontSize:screen.height*0.1,),),
                                ),
                                Positioned(
                                  top: 15,
                                  left: 15,
                                  child: Text("Hindi",style: TextStyle(color: Colors.white.withOpacity(0.8),fontSize:screen.height*0.05),),
                                  // child: Text(LocaleKeys.ChangeColorScheme_Text.tr() ,style: TextStyle(color: Colors.white.withOpacity(0.8),fontSize:screen.height*0.05),),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async{
                            // await context.setLocale(Locale('ko'));

                            Map<String,dynamic> val = {
                              "hi_text": "Hello Korean",
                              "ChangeColorScheme_Text": "??? ????????? ??????",
                              "Translate_Text": "?????? ??????",
                              "History_Text": "????????? ??????",
                              "SelectColor_Text": "?????? ??????",
                              "SelectCountry_Text": "????????? ??????",
                              "Search_Text": "??????",
                              "AlertTextFirstTimeConvert_Text": "???????????? ????????? ??????????????? ???????????? ????????????."
                            };

                            await SaveTranslationText().addTranslationData(val);

                            Navigator.pop(context);
                            Route route = MaterialPageRoute(builder: (context) => HomeScreen());
                            Navigator.pushReplacement(context, route);

                            // Navigator.pop(context);
                          },
                          child: Container(
                            height: 180,
                            width: screen.width*1,
                            decoration: BoxDecoration(
                                color: primarycolor.withOpacity(0.7)
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Text("KO",style: TextStyle(color: Colors.white.withOpacity(0.4),fontSize:screen.height*0.1,),),
                                ),
                                Positioned(
                                  top: 15,
                                  left: 15,
                                  child: Text("Korean",style: TextStyle(color: Colors.white.withOpacity(0.8),fontSize:screen.height*0.05),),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async{
                            // await context.setLocale(Locale('ja'));


                            Map<String,dynamic> val = {
                              "hi_text": "Hello JAPAN",
                              "ChangeColorScheme_Text": "??????????????????????????????",
                              "Translate_Text": "???????????????",
                              "History_Text": "???????????????",
                              "SelectColor_Text": "????????????",
                              "SelectCountry_Text": "????????????",
                              "Search_Text": "??????",
                              "AlertTextFirstTimeConvert_Text": "?????????????????????????????????????????????????????????????????????????????????????????????"
                            };

                            await SaveTranslationText().addTranslationData(val);

                            Navigator.pop(context);
                            Route route = MaterialPageRoute(builder: (context) => HomeScreen());
                            Navigator.pushReplacement(context, route);

                          },
                          child: Container(
                            height: 180,
                            width: screen.width*1,
                            decoration: BoxDecoration(
                                color: primarycolor.withOpacity(0.7)
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Text("JA",style: TextStyle(color: Colors.white.withOpacity(0.4),fontSize:screen.height*0.1,),),
                                ),
                                Positioned(
                                  top: 15,
                                  left: 15,
                                  child: Text("Japanese",style: TextStyle(color: Colors.white.withOpacity(0.8),fontSize:screen.height*0.05),),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
