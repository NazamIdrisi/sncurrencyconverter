

import 'dart:math';

import 'package:connectivity/connectivity.dart';
import 'package:random_string/random_string.dart';
import 'package:sncurrencyconverter/Helpers/ApiManager.dart';
import 'package:sncurrencyconverter/Helpers/DBHelper.dart';
import 'package:sncurrencyconverter/Helpers/SaveCountryGetStorage.dart';
import 'package:sncurrencyconverter/Views/Dialog/AlertDialogue.dart';

App app = App();
DBHelper dbHelper = DBHelper();
CountryModalData countryModalData = CountryModalData();
CountryModalData1 countryModalData1 = CountryModalData1();
CountryHistoryData countryHistoryData = CountryHistoryData();
var dat = DateTime.now();


class HomeController{

  double roundDouble(double value, int places){
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

      ConvertCurrency(_secondaryDisplayerText,FirstCountry,SecondCountry,ThirdCountry,FourthCountry,context) async{

        var secondarytext = _secondaryDisplayerText.toString().replaceAll(RegExp(','), '');
        double price = double.parse('$secondarytext');
        var data  = await CheckInternetConnection();
        double sec;
        double third;
        double fourth;
        var convertsec;
        var convertthird;
        var convertfourth;
        bool notfound = false;

        print("INTERNET CONNECTION "+data.toString());

        var ok = await dbHelper.getHistory();

        print("====================== HISTORY "+ok.toString());
        var rnd = randomAlphaNumeric(30);
        if(data == true){


          if(SaveCountry().getSecondCountryData.isNotEmpty){
            sec = await ConvertSecondCurrencyOnline(FirstCountry, SecondCountry, context);
            var getsec = await GetCurrencyOffline(FirstCountry, SecondCountry, context);

            print("============================== "+getsec.toString());

            double roundsec = roundDouble(sec, 2);
            var cnsec = price.toDouble() * roundsec.toDouble();
            convertsec = roundDouble(cnsec, 2);
            if(getsec['data'].toString() == "[]"){
              print("GET CURRENCY OFFLINE DATA  EMPTY" );


            print("======================= SECOND CONVER "+convertsec.toString());
              var insert = await InsertOfflineData(SecondCountry, price,convertsec,roundsec.toString(),getsec['cncyform'],dat,rnd);

              print("=============== DATA INSERT" +insert.toString());

        }else{
              print(SecondCountry.toString()+" === "+ price.toString()+" ==== "+convertsec.toString()+" === "+roundsec.toString()+" ==== "+getsec['cncyform'].toString() +" ==== "+ dat.toString() +" ===== "+rnd.toString());

              Map<String, dynamic> row = {
                "ConvertFirst": price.toString(),
                "ConvertRateFirst": convertsec.toString(),
                "ConvertAmountFirst": roundsec.toString(),
                "dat": dat.toString(),
              };
              var update = await dbHelper.updatecurrency(row,getsec['cncyform'].toString());


              var getscec = await GetCurrencyOffline(FirstCountry, SecondCountry, context);
              print("PLEASE UPDATE DATA SECOND===========" + getscec.toString());
              print("PLEASE UPDATE DATA SECOND===========" + update.toString());
            }


          }else{
            convertsec =0.0;
          }


          if(SaveCountry().getThirdCountryData.isNotEmpty){
            third = await ConvertSecondCurrencyOnline(FirstCountry, ThirdCountry, context);

            var getthird = await GetCurrencyOffline(FirstCountry, ThirdCountry, context);

            print("============================== "+getthird.toString());

            double roundthird = roundDouble(third, 2);
            var conthir = price.toDouble() * roundthird.toDouble();
            convertthird = roundDouble(conthir, 2);

            if(getthird['data'].toString() == "[]"){
              print("GET CURRENCY OFFLINE DATA  EMPTY" );

              var insert = await InsertOfflineData(ThirdCountry, price,convertthird,roundthird.toString(),getthird['cncyform'],dat,rnd);

              print("=============== DATA INSERT THIRD" +insert.toString());

            }else{

              print(ThirdCountry.toString()+" === "+ price.toString()+" ==== "+convertsec.toString()+" === "+roundthird.toString()+" ==== "+getthird['cncyform'].toString() +" ==== "+ dat.toString() +" ===== "+rnd.toString());

              Map<String, dynamic> row = {
                "ConvertFirst": price.toString(),
                "ConvertRateFirst": convertthird.toString(),
                "ConvertAmountFirst": roundthird.toString(),
                "dat": dat.toString(),
              };
              var update = await dbHelper.updatecurrency(row,getthird['cncyform'].toString());

              var getscec = await GetCurrencyOffline(FirstCountry, ThirdCountry, context);
              print("PLEASE UPDATE DATA THIRD===========" + getscec.toString());
              print("PLEASE UPDATE DATA THIRD===========" + update.toString());

            }

          }else{
            convertthird = 0.0;
          }


          if(SaveCountry().getFourthCountryData.isNotEmpty){
            fourth = await ConvertSecondCurrencyOnline(FirstCountry, FourthCountry, context);

            var getfourth = await GetCurrencyOffline(FirstCountry, FourthCountry, context);

            print("============================== "+getfourth.toString());

            double roundfourth = roundDouble(fourth, 2);
            var confourth = price.toDouble() * roundfourth.toDouble();
            convertfourth = roundDouble(confourth, 2);

            if(getfourth['data'].toString() == "[]"){
              print("GET CURRENCY OFFLINE DATA  EMPTY" );


              var insert = await InsertOfflineData(FourthCountry, price,convertfourth,roundfourth.toString(),getfourth['cncyform'],dat,rnd);

            }else{

              print(FourthCountry.toString()+" === "+ price.toString()+" ==== "+convertfourth.toString()+" === "+roundfourth.toString()+" ==== "+getfourth['cncyform'].toString() +" ==== "+ dat.toString() +" ===== "+rnd.toString());

              Map<String, dynamic> row = {
                "ConvertFirst": price.toString(),
                "ConvertRateFirst": convertfourth.toString(),
                "ConvertAmountFirst": roundfourth.toString(),
                "dat": dat.toString(),
              };
              var update = await dbHelper.updatecurrency(row,getfourth['cncyform'].toString());

              var getscec = await GetCurrencyOffline(FirstCountry, FourthCountry, context);
              print("PLEASE UPDATE DATA FOURTH===========" + getscec.toString());
              print("PLEASE UPDATE DATA FOURTH===========" + update.toString());

              print(getfourth);
            }

          }else{
            convertfourth = 0.0;
          }

        }else{

          if(SaveCountry().getSecondCountryData.isNotEmpty){

            var getsec = await GetCurrencyOffline(FirstCountry, SecondCountry, context);

            print("======== OFFLINE SECOND "+getsec.toString());

            if(getsec['data'].toString() == "[]"){
              notfound = true;
              convertsec =0.0;
            }else{

              print("OFFLINE DATA FOR CONVERT "+getsec.toString());
              print("OFFLINE DATA FOR CONVERT "+getsec['data'][0]['ConvertAmountFirst'].toString());
              double secrate = double.parse(getsec['data'][0]['ConvertAmountFirst']);
              double consec = price.toDouble() * secrate.toDouble();
              convertsec = roundDouble(consec, 2);
              // Map<String, dynamic> row = {
              //   "ConvertFirst": price.toString(),
              //   "ConvertRateFirst": convertsec.toString(),
              //   "dat": dat.toString(),
              // };
              // var update = await dbHelper.updatecurrency(row,getsec['cncyform'].toString());


            }

          }else{
            convertsec =0.0;
          }

          if(SaveCountry().getThirdCountryData.isNotEmpty){

            var getthird = await GetCurrencyOffline(FirstCountry, ThirdCountry, context);

            print("======== OFFLINE SECOND "+getthird.toString());

            if(getthird['data'].toString() == "[]"){
              notfound = true;
              convertthird = 0.0;
            }else{

              print("OFFLINE DATA FOR CONVERT "+getthird.toString());
              print("OFFLINE DATA FOR CONVERT "+getthird['data'][0]['ConvertAmountFirst'].toString());
              double secrate  = double.parse(getthird['data'][0]['ConvertAmountFirst']);
              double conthird = price.toDouble() * secrate.toDouble();
              convertthird = roundDouble(conthird, 2);

            }

          }else{
            convertthird = 0.0;
          }

          if(SaveCountry().getFourthCountryData.isNotEmpty){

            var getfourth = await GetCurrencyOffline(FirstCountry, FourthCountry, context);

            print("======== OFFLINE SECOND "+getfourth.toString());

            if(getfourth['data'].toString() == "[]"){
              notfound = true;
              convertfourth = 0.0;
            }else{

              print("OFFLINE DATA FOR CONVERT "+getfourth.toString());
              print("OFFLINE DATA FOR CONVERT "+getfourth['data'][0]['ConvertAmountFirst'].toString());
              double secrate  = double.parse(getfourth['data'][0]['ConvertAmountFirst']);
              double confourth = price.toDouble() * secrate.toDouble();
              convertfourth = roundDouble(confourth, 2);

            }

          }else{
            convertfourth = 0.0;
          }


        }

        // var third = await ConvertThirdCurrencyOnline(FirstCountry, ThirdCountry, context);
        // var fourth = await ConvertFourthCurrencyOnline(FirstCountry, FourthCountry, context);

        // double roundsec = roundDouble(sec, 2);
        // double roundthird = roundDouble(third, 2);
        // double roundfourth = roundDouble(fourth, 2);
        // var convertsec = price.toDouble() * roundsec.toDouble();
        // var convertthird = price.toDouble() * roundthird.toDouble();
        // var convertfourth = price.toDouble() * roundfourth.toDouble();

        print("PRICE  "+price.toString());
        print("FINAL SECOND CONVERT ONLINE DATA "+ convertsec.toString());
        print("FINAL THIRD CONVERT ONLINE DATA "+ convertthird.toString());
        print("FINAL Fourth CONVERT ONLINE DATA "+ convertfourth.toString());



        // Map<String,dynamic> body = {
        //   "Second": roundDouble(convertsec, 2),
        //   "Third": roundDouble(convertthird, 2),
        //   "Fourth": roundDouble(convertfourth, 2),
        // };

        if(convertsec.toString() == "0" || convertsec.toString() == "0.0"){

        }

        InsertHistoryData(FirstCountry, SecondCountry, ThirdCountry, FourthCountry, price, convertsec, convertthird, convertfourth, rnd);

        Map<String,dynamic> body = {
          "Second": convertsec,
          "Third": convertthird,
          "Fourth": convertfourth,
          "notfound":notfound,
        };

        return body;

      }

      GetCurrencyOffline(FirstCountry,SecondCountry,context) async{

        var cncyform = "${FirstCountry['currency']+"_"+SecondCountry['currency']}";
        var ddata = await DBHelper().getcurrency(cncyform.toString());
        // print("GET CURRENCY OFFLINE"+cncyform);

        // if(ddata.toString() == "[]"){
        //   print("GET CURRENCY OFFLINE DATA  EMPTY" );
        // }else{
        //   print(ddata);
        // }

        Map<String,dynamic> body = {
          "cncyform" : cncyform,
          "data":ddata,
        };
        return body;


      }


      InsertHistoryData(FirstCountry,SecondCountry,ThirdCountry,FourthCountry,ConvertAmountFirst,ConvertAmountSecond,ConvertAmountThird,ConvertAmountFourth,rnd) async{

        print("HISTORY DATA =========== "+FirstCountry['img'].toString());

        var fimg = FirstCountry['img'];
        var simg = SecondCountry['img'];
        var timg = ThirdCountry['img'];
        var fouthimg = FourthCountry['img'];
        // CountryHistoryData countryHistoryData = new CountryHistoryData(
        //   FirstCountry: fimg,
        //   SecondCountry: simg,
        //   ThirdCountry: timg,
        //   FourthCountry: fouthimg,
        //   ConvertAmountFirst: ConvertAmountFirst.toString(),
        //   ConvertAmountSecond: ConvertAmountSecond.toString(),
        //   ConvertAmountThird: ConvertAmountThird.toString(),
        //   ConvertAmountFourth: ConvertAmountFourth.toString(),
        //   RND: rnd.toString(),
        // );



        Map<String,dynamic> body = {
            "FirstCountry": FirstCountry['img'].toString(),
            "SecondCountry": SecondCountry['img'].toString(),
            "ThirdCountry": ThirdCountry['img'].toString(),
            "FourthCountry":FourthCountry['img'].toString(),
            "ConvertAmountFirst":ConvertAmountFirst,
            "ConvertAmountSecond":ConvertAmountSecond,
            "ConvertAmountThird":ConvertAmountThird,
            "ConvertAmountFourth":ConvertAmountFourth,
            "RND":rnd,
          };

        await dbHelper.insertHistory(body);

        // dbHelper.insertHistory(countryHistoryData).then((value) async{
        //   print("===== DATA INSERTED INTO HISTORY "+value.toString());
        //   return true;
        // });

      }

      InsertOfflineData(FirstCountry,price,convertsec,roundsec,cncyform,dat,rnd)async{


              CountryModalData1 countryModalData1 = new CountryModalData1(
                  FirstCountry: FirstCountry,
                  ConvertFirst: price.toString(),
                  ConvertAmountFirst: convertsec.toString(),
                  ConvertRateFirst: roundsec.toString(),
                  ConvertName: cncyform.toString(),
                  dat: dat.toString(),
                  RND:rnd,
              );

              dbHelper.insertcurrency(countryModalData1).then((value) async{
                print("===== DATA INSERTED INTO OFFLINE "+value.toString());
                return true;
              });



        return false;
      }






  ConvertSecondCurrencyOnline(FirstCountry,SecondCountry,context) async{

        var cncyform = "${FirstCountry['currency']+"_"+SecondCountry['currency']}";
        var url = app.baseurl(cncyform);

        var data =  await app.getApi(url, context);

        var dd = data['$cncyform'];
        print("SECOND CONVERT CURRENCY"+dd.toString());
        return dd;
      }

      ConvertThirdCurrencyOnline(FirstCountry,ThirdCountry,context) async{

        var cncyform = "${FirstCountry['currency']+"_"+ThirdCountry['currency']}";
        var url = app.baseurl(cncyform);

        var data =  await app.getApi(url, context);

        var dd = data['$cncyform'];
        print("THIRD CONVERT CURRENCY"+dd.toString());
        return dd;
      }


      ConvertFourthCurrencyOnline(FirstCountry,FourthCountry,context) async{

        var cncyform = "${FirstCountry['currency']+"_"+FourthCountry['currency']}";
        var url = app.baseurl(cncyform);

        var data =  await app.getApi(url, context);

        var dd = data['$cncyform'];
        print("FOURTH CONVERT CURRENCY"+dd.toString());
        return dd;
      }

    CheckInternetConnection() async{

      var connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult == ConnectivityResult.mobile) {
        // I am connected to a mobile network.
        // AlertDialogue().showtoast("You Are Mobile ");
        return true;
      } else if (connectivityResult == ConnectivityResult.wifi) {
        // I am connected to a wifi network.
        // AlertDialogue().showtoast("You Are WIFI ");
        return true;
      }else if(connectivityResult == ConnectivityResult.none){
            // AlertDialogue().showtoast("You Are OffLine For Best Result Please On Your Internet.");
      return false;
      }

    }

}