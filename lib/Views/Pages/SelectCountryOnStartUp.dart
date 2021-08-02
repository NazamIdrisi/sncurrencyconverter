import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sncurrencyconverter/Animations/FadeAnimationLeft.dart';
import 'package:sncurrencyconverter/Constants/Colors.dart';
import 'package:sncurrencyconverter/Controllers/CountriesController.dart';
import 'package:sncurrencyconverter/Helpers/SaveCountryGetStorage.dart';
import 'package:sncurrencyconverter/MyTestCalculator/screens/home_screen.dart';

class SelectCountryOnStartUp extends StatefulWidget {

  @override
  _SelectCountryOnStartUpState createState() => _SelectCountryOnStartUpState();
}

class _SelectCountryOnStartUpState extends State<SelectCountryOnStartUp> {

  List CountryList = [];
  var isSelected = "";

  @override
  void initState() {
    super.initState();
    getcountry();
  }

  getcountry() async{

    var data = await CountriesController().getcountries();
    setState(() {
      CountryList = data;
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
      CountryList = dd;
    });
    print("FILTER === "+ dd.toString());


  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Container(
      color: primarycolor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor:primarycolor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                  SizedBox(height: 20,),
                  Image.asset("assets/location.png",height: screen.height*0.3,width: screen.width*1,fit: BoxFit.contain,),
                SizedBox(height: 20,),
                Text('Select Your Country',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:  screen.width*0.15),
                  child: TextFormField(
                    onChanged: (val){
                      filterlist(val);
                    },
                    style: TextStyle(
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(
                        color: Colors.white
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white
                        )
                      ),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white
                          )
                      ),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                CountryList.length == 0 ?  Container(
                  height: screen.height*0.5,
                  width: screen.width*1,
                  child: Center(
                    child: Text("Please Wait...",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                  ),
                ) : Container(
                  height: screen.height*0.5,
                  width: screen.width*1,
                  margin: EdgeInsets.symmetric(horizontal: screen.width*0.15),
                  // color: Colors.blue,
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      itemCount: CountryList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                        return Column(
                          children: [

                              GestureDetector(
                                onTap: () async{
                                  setState(() {
                                    isSelected = CountryList[index]['name'].toString();
                                  });


                                  await SaveCountry().addFirstCountryData(CountryList[index]);

                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                        leading: SvgPicture.asset(
                                            "assets/countries/${CountryList[index]['img']}.svg",
                                            height: 40,
                                            width: 40,
                                            semanticsLabel: 'A red up arrow'
                                        ),
                                        title: Text(CountryList[index]['name'].toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                                        // selected: isSelected == CountryList[index]['name'] ? true : false,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 0,
                                      child:  isSelected == CountryList[index]['name'] ? Icon(Icons.check,color: Colors.green,) :  SizedBox(),
                                    ),
                                  ],
                                )
                              ),
                            Divider(
                              color: Colors.grey,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: isSelected != "" ? FadeAnimationLeft(0.8, GestureDetector(
            onTap: (){

              // Navigator.pop(context);
              Route route = MaterialPageRoute(builder: (context) => HomeScreen());
              Navigator.pushReplacement(context, route);

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => HomeScreen()),
              // );
            },
            child: Container(
                height: 60,
                width: 60,
                margin: EdgeInsets.only(bottom: 10,right: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: secondrycolor,
                ),
                child: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),
              ),
          ),
          )  : SizedBox(),
        ),
      ),
    );
  }
}
