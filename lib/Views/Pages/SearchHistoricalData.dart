import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sncurrencyconverter/Constants/Colors.dart';
import 'package:sncurrencyconverter/Controllers/SearchHistoricalData.dart';
import 'package:sncurrencyconverter/Helpers/RouteHelper.dart';
import 'package:sncurrencyconverter/Helpers/SaveCountryGetStorage.dart';
import 'package:sncurrencyconverter/Helpers/SaveTranslationText.dart';
import 'package:sncurrencyconverter/Views/Dialog/AlertDialogue.dart';
import 'package:sncurrencyconverter/Views/Pages/FilterCountries.dart';

class SearchHistoricalData extends StatefulWidget {

  @override
  _SearchHistoricalDataState createState() => _SearchHistoricalDataState();
}

class _SearchHistoricalDataState extends State<SearchHistoricalData> {

  Map translatetxt = {};
  Map historyCountryData1 = {};
  Map historyCountryData2 = {};
  DateTime startdate = DateTime.now();
  DateTime enddate = DateTime.now();
  String datone = "";
  String dattwo = "";
  List DataList = [];



  @override
  void initState() {
    super.initState();
    get();
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: startdate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != startdate)
      setState(() {
        startdate = pickedDate;
        datone = pickedDate.toLocal().toString();
      });
  }
  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: enddate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != enddate)
      setState(() {
        enddate = pickedDate;
        dattwo = pickedDate.toLocal().toString();
      });
  }

  get() async{
    await gettranstaletext();
    await gethistorydata();
  }

  gethistorydata() async{

    var data = await SaveCountry().gethistoryCountryData1;
    var data2 = await SaveCountry().gethistoryCountryData2;

    setState(() {
      historyCountryData1 = data;
      historyCountryData2 = data2;
    });

    print(historyCountryData1.toString());
    print(historyCountryData2.toString());
  }

  gettranstaletext() async{

    var data = await SaveTranslationText().getTranslateData;
    setState(() {
      translatetxt = data;
    });

  }


  _searchdata() async{

    if(datone == "" || dattwo == "" || historyCountryData1.toString() == "{}" || historyCountryData1.toString() == "{}"){

      AlertDialogue().showtoast("All Field Must Not Be Blank.");
    }else{

      var data = await SearchHistoricalDataController().searchdata(context, historyCountryData1, historyCountryData2, datone.toString().split(' ').first, dattwo.toString().split(' ').first);

      // print(data.toString());

      data.forEach((k,v){

        print("OKK $k + $v");

        Map<String,dynamic> arr = {
          "dat":k,
          "value":v
        };

        setState(() {
          DataList.add(arr);
        });

      });


      print(DataList.toString());

    }


  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Container(
      color: primarycolor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(translatetxt['Search_Text'].toString()),
            backgroundColor: Color(0xFF292D36),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 20,right: 16,left: 16),
              child: Column(
                children: [

                  GestureDetector(
                    onTap: () async{
                      // setState(() {
                      //   tabIndex = 1;
                      // });

                      showbottm(5);
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
                              child:historyCountryData1.toString() == "{}"? CircleAvatar(
                                radius: 20,
                                backgroundColor: primarycolor,
                                child: Text("?",style: TextStyle(color: Colors.white),),
                              ) : ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: CircleAvatar(
                                  radius: 20,
                                  child: SvgPicture.asset("assets/countries/${historyCountryData1['img']}.svg"),
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
                              child: Text(historyCountryData1.toString() == "{}" ? "Select Country" : historyCountryData1['name'].toString(),style: TextStyle(fontSize: 25,color: whitecolor),),
                              // child: Text( _secondaryDisplayerText.toString() == '' ?  "0" : _secondaryDisplayerText ,style: TextStyle(fontSize: 35,color: whitecolor),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () async{
                      // setState(() {
                      //   tabIndex = 1;
                      // });

                      showbottm(6);
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
                              child:historyCountryData2.toString() == "{}"? CircleAvatar(
                                radius: 20,
                                backgroundColor: primarycolor,
                                child: Text("?",style: TextStyle(color: Colors.white),),
                              ) : ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: CircleAvatar(
                                  radius: 20,
                                  child: SvgPicture.asset("assets/countries/${historyCountryData2['img']}.svg"),
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
                              child: Text(historyCountryData2.toString() == "{}" ? "Select Country" : historyCountryData2['name'].toString(),style: TextStyle(fontSize: 25,color: whitecolor),),
                              // child: Text( _secondaryDisplayerText.toString() == '' ?  "0" : _secondaryDisplayerText ,style: TextStyle(fontSize: 35,color: whitecolor),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child:  GestureDetector(
                          onTap: (){
                            _selectDate(context);
                          },
                          child: Container(
                            height: 50,
                            width: screen.width*1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                  color: Colors.white
                              ),
                            ),
                            child: Center(child: Text(datone == "" ? "Select Start Date" : datone.toString().split(' ').first,style: TextStyle(color: Colors.white,fontSize: 17),)),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child:  GestureDetector(
                          onTap: (){
                            _selectEndDate(context);
                          },
                          child: Container(
                            height: 50,
                            width: screen.width*1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                  color: Colors.white
                              ),
                            ),
                            child: Center(child: Text(dattwo == "" ? "Select End Date" : dattwo.toString().split(' ').first,style: TextStyle(color: Colors.white,fontSize: 17),)),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20,),
                  SizedBox(
                    width: screen.width*1,
                    height: 47,
                    child: ElevatedButton(
                        onPressed: (){
                          _searchdata();
                        },
                        style: ButtonStyle(

                        ),
                        child:  Text(translatetxt['Search_Text'].toString())
                    ),
                  ),

                  SizedBox(height: 20,),
                  ListView.builder(
                    itemCount: DataList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      return Container(
                        margin: EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                            color: Colors.white
                          )
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(DataList[index]['dat'].toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                            ),
                            Expanded(
                              flex: 0,
                                child: Container(
                                  height: 20,
                                  width: 2,
                                  color: Colors.white,
                                )
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Text(DataList[index]['value'].toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                            ),
                          ],
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

  showbottm(ind) async{


    RouteHelper().gotonext(context, FilterCountries(conid:ind));


  }
}
