import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sncurrencyconverter/Constants/Colors.dart';
import 'package:sncurrencyconverter/Controllers/CountriesController.dart';
import 'package:sncurrencyconverter/Helpers/SaveColors.dart';
import 'package:sncurrencyconverter/Helpers/SaveCountryGetStorage.dart';
import 'package:sncurrencyconverter/Helpers/SaveTranslationText.dart';
import 'package:sncurrencyconverter/MyTestCalculator/screens/home_screen.dart';
import 'package:sncurrencyconverter/Views/Pages/SearchHistoricalData.dart';

class FilterCountries extends StatefulWidget {
  int conid;
  FilterCountries({ this.conid});

  @override
  _FilterCountriesState createState() => _FilterCountriesState();
}

class _FilterCountriesState extends State<FilterCountries> {

  int red;
  int green;
  int blue;
  List CountriesList = [];
  int Mapindex;
  String SelectedIndex = "";
  Map translatetxt = {};

  @override
  void initState() {
    super.initState();
    get();
  }

  get() async{
    await setmapindex();
    await getcolor();
    await getcountry();
    await gettranstaletext();
  }

  gettranstaletext() async{

    var data = await SaveTranslationText().getTranslateData;
    setState(() {
      translatetxt = data;
    });

  }

  setmapindex() async{

    setState(() {
      Mapindex = widget.conid;
    });

  }
  getcountry() async{

    var data = await CountriesController().getcountries();

    print(data.toString());

    setState(() {
      CountriesList = data;
    });

  }

  getcolor(){

    var aa = ColorData().getRedData;
    var bb= ColorData().getGreenData;
    var cc = ColorData().getBlueData;
    print("RED"+aa.toString());
    print("Greeb"+bb.toString());
    print("blue"+cc.toString());

    setState(() {
      red = aa;
      green = bb;
      blue = cc;
    });

  }


  filterlist(val) async{


    List data = await CountriesController().getcountries();

    print(val);
    var dd=  data.where(
            (x) => x['name'].toLowerCase().contains(val.toLowerCase())
    ).toList();


    // return CountriesList;
    setState(() {
      CountriesList = dd;
    });
    print("FILTER === "+ dd.toString());


  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: (){

       if(Mapindex == 5 || Mapindex == 6){
         Navigator.pop(context);
         Route route = MaterialPageRoute(builder: (context) => SearchHistoricalData());
         Navigator.pushReplacement(context, route);
       }else{
         Navigator.pop(context);
         Route route = MaterialPageRoute(builder: (context) => HomeScreen());
         Navigator.pushReplacement(context, route);
       }

        // return false;
      },
      child: Container(
        color: primarycolor,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(translatetxt['SelectCountry_Text'].toString()),
              backgroundColor: Color(0xFF292D36),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [

                  SizedBox(height: screen.height*0.05,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal:20),
                    child: TextFormField(
                      onChanged: (val){
                        filterlist(val.toString());
                      },
                      style: TextStyle(
                        color: Color.fromRGBO(red, green, blue, 1),
                      ),
                      decoration: InputDecoration(
                        hintText: translatetxt['Search_Text'].toString(),
                        hintStyle: TextStyle(color: Color.fromRGBO(red, green, blue, 1)),
                        labelStyle: TextStyle(color: Color.fromRGBO(red, green, blue, 1)),
                        labelText: translatetxt['Search_Text'].toString(),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(red, green, blue, 1),
                          )
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(red, green, blue, 1),
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(red, green, blue, 1),
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(red, green, blue, 1),
                            )
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(red, green, blue, 1),
                            )
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: CountriesList.length,
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: () async{
                          setState(() {
                            SelectedIndex = CountriesList[index]['name'];
                          });

                          if(Mapindex == 1){
                            print("Map 1");
                            // print(CountriesList[index]);
                            await SaveCountry().addFirstCountryData(CountriesList[index]);
                          }else if(Mapindex == 2){
                            print("Map 2");
                            await SaveCountry().addSecondCountryData(CountriesList[index]);
                          }else if(Mapindex == 3){
                            print("Map 3");
                            await SaveCountry().addThirdCountryData(CountriesList[index]);
                          }else if(Mapindex == 4){
                            print("Map 4");
                            await SaveCountry().addFourthCountryData(CountriesList[index]);
                          }else if(Mapindex == 5){
                            await SaveCountry().addHistoryCountryData1(CountriesList[index]);
                          }else if(Mapindex == 6){
                            await SaveCountry().addHistoryCountryData2(CountriesList[index]);
                          }

                          if(Mapindex == 5 || Mapindex == 6){
                            Navigator.pop(context);
                            Route route = MaterialPageRoute(builder: (context) => SearchHistoricalData());
                            Navigator.pushReplacement(context, route);
                          }else{
                            Navigator.pop(context);
                            Route route = MaterialPageRoute(builder: (context) => HomeScreen());
                            Navigator.pushReplacement(context, route);
                          }


                        },
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(
                                child:  ListTile(
                                  leading: SvgPicture.asset(
                                      "assets/countries/${CountriesList[index]['img']}.svg",
                                      height: 40,
                                      width: 40,
                                      semanticsLabel: 'A red up arrow'
                                  ),
                                  title: Text(CountriesList[index]['name'].toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                ),
                              ),
                              Expanded(
                                flex: 0,
                                child: SelectedIndex  == CountriesList[index]['name'].toString() ? Icon(Icons.check,color: Colors.green,) : SizedBox(),
                              ),
                              SizedBox(width: 10,),
                            ],
                          ),
                        ),
                      );
                    },
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
