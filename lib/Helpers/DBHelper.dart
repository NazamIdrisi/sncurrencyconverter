import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


class DBHelper{

  Database _database;

  Future openDB() async{

    if(_database == null){
      _database = await openDatabase(
          join(await getDatabasesPath(),"SNCrrencyConverter.db"),
          version: 1,
          onCreate: (Database db,int version) async{
            await db.execute("CREATE TABLE Currencies (id INTEGER PRIMARY KEY autoincrement, FirstCountry TEXT, ConvertFirst TEXT, ConvertRateFirst TEXT, ConvertAmountFirst TEXT, dat TEXT, ConvertName TEXT,RND TEXT)");
            await db.execute("CREATE TABLE History (id INTEGER PRIMARY KEY autoincrement, FirstCountry TEXT, SecondCountry TEXT, ThirdCountry TEXT, FourthCountry TEXT, ConvertAmountFirst TEXT, ConvertAmountSecond TEXT, ConvertAmountThird TEXT, ConvertAmountFourth TEXT,RND TEXT)");
            // await db.execute("CREATE TABLE Currencies (id INTEGER PRIMARY KEY autoincrement, FirstCountry TEXT, SecondCountry TEXT, ThirdCountry TEXT, FourthCountry TEXT, ConvertFirst TEXT, ConvertSecond TEXT, ConvertThird TEXT, ConvertFourth TEXT, ConvertRateFirst TEXT, ConvertRateSecond TEXT, ConvertRateThird TEXT, ConvertRateFourth TEXT, ConvertAmountFirst TEXT, ConvertAmountSecond TEXT, ConvertAmountThird TEXT, ConvertAmountFourth TEXT, dat TEXT, ConvertName TEXT,RND TEXT)");

          }
      );
      return _database;
    }else {
      return _database;
    }

  }

  Future<int> insertcurrency(CountryModalData1 countryModalData1) async{
    await openDB();
    return await _database.insert('Currencies', countryModalData1.toMap());
  }
  // CountryHistoryData countryHistoryData
  Future<int> insertHistory(body) async{
    await openDB();
    // return await _database.insert('History', countryHistoryData.toMap());
    return await _database.insert('History', body);
  }

  Future getcurrency(ConvertName) async{
    // SELECT COUNT(*) FROM table_name
    await openDB();

    final List<Map<String, dynamic>> maps =  await _database.rawQuery("SELECT * FROM Currencies where ConvertName='$ConvertName'");
    return maps;
  }

  Future getHistory() async{
    // SELECT COUNT(*) FROM table_name
    await openDB();

    final List<Map<String, dynamic>> maps =  await _database.rawQuery("SELECT * FROM History");
    return maps;
  }


  Future updatecurrency(row,convertname) async{
    // SELECT COUNT(*) FROM table_name
    await openDB();

    // var tt =  await _database.rawQuery("SELECT * FROM MYCART where token='${token.toString()}'");
    // await db.execute("CREATE TABLE Currencies (id INTEGER PRIMARY KEY autoincrement, FirstCountry TEXT, ConvertFirst TEXT, ConvertRateFirst TEXT, ConvertAmountFirst TEXT, dat TEXT, ConvertName TEXT,RND TEXT)");

    var tt =  await _database.update('Currencies', row,where: "ConvertName = ?",whereArgs: [convertname]);
    return tt.hashCode;
  }
  
  // Future updatecurrency(FirstCountry,price,convertsec,roundsec,cncyform,dat,rnd) async{
  //   // SELECT COUNT(*) FROM table_name
  //   await openDB();
  //
  //   // var tt =  await _database.rawQuery("SELECT * FROM MYCART where token='${token.toString()}'");
  //   // await db.execute("CREATE TABLE Currencies (id INTEGER PRIMARY KEY autoincrement, FirstCountry TEXT, ConvertFirst TEXT, ConvertRateFirst TEXT, ConvertAmountFirst TEXT, dat TEXT, ConvertName TEXT,RND TEXT)");
  //
  //   var tt =  await _database.rawQuery("UPDATE Currencies SET FirstCountry='$FirstCountry', ConvertFirst='$price', ConvertRateFirst='$convertsec',ConvertAmountFirst='$roundsec',dat='$dat',RND='$rnd' where RND='$rnd'");
  //   return tt.length;
  // }

  Future updatecart(qty,rnd) async{
    // SELECT COUNT(*) FROM table_name
    await openDB();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');

    // var tt =  await _database.rawQuery("SELECT * FROM MYCART where token='${token.toString()}'");
    var tt =  await _database.rawQuery("UPDATE MYCART SET QTY='$qty' where RND_NUM='$rnd' AND token='${token.toString()}'");
    return tt.length;
  }

  Future deletecart(rnd) async{
    await openDB();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    // var yy =  await _database.rawQuery("DELETE FROM MYCART where token='${token.toString()} AND PROD_ID='${pid.toString()}'");
    // return "Cart Deleted Successful.";
    await _database.delete('MYCART',where: "RND_NUM = ?", whereArgs: [rnd]);
    // return yy.length;
  }

  Future totalcart() async{
    // SELECT COUNT(*) FROM table_name
    await openDB();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');

    var tt =  await _database.rawQuery("SELECT * FROM MYCART where token='${token.toString()}'");
    return tt.length;
  }



  Future getproductqq(pid,PRODVAR_UNITVALUE,PRODVAR_NAME) async{
    // SELECT COUNT(*) FROM table_name
    await openDB();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');

    final List<Map<String, dynamic>> maps =  await _database.rawQuery("SELECT * FROM MYCART where PROD_UNITVALUE='$PRODVAR_UNITVALUE' AND PRODVAR_NAME='$PRODVAR_NAME' AND PROD_ID='$pid' AND token='${token.toString()}'");
    return maps;
  }




  Future getproductbyid(variant,pid) async{
    // SELECT COUNT(*) FROM table_name
    await openDB();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');

    final List<Map<String, dynamic>> maps =  await _database.rawQuery("SELECT * FROM MYCART where PROD_UNITNAME='$variant' AND PROD_ID='$pid' AND token='${token.toString()}'");
    return maps;
  }




  Future getallcart() async{
    await openDB();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    // final List<Map<String, dynamic>> maps = await _database.query('MYCART');
    final List<Map<String, dynamic>> maps = await _database.query('MYCART',where: "token = ?", whereArgs: [token]);
    return maps;
  }

  Future<List<CartModel>> getcartList() async{
      await openDB();
      final List<Map<String, dynamic>> maps = await _database.query('MYCART');
      return List.generate(maps.length, (i){
        return CartModel(
          id: maps[i]['id'].toString(),
          RND_NUM: maps[i]['RND_NUM'],
          token: maps[i]['token'],
          PROD_ID:  maps[i]['PROD_ID'],
          PROD_NAME: maps[i]['PROD_NAME'],
          PROD_BRANDID: maps[i]['PROD_BRANDID'],
          PROD_BRANDNAME: maps[i]['PROD_BRANDNAME'],
          PROD_IMAGE: maps[i]['PROD_IMAGE'],
          PROD_META: maps[i]['PROD_META'],
          PROD_PRICE: maps[i]['PROD_PRICE'],
          PROD_DISC_PRICE: maps[i]['PROD_DISC_PRICE'],
          PROD_CGST: maps[i]['PROD_CGST'],
          PROD_SGST: maps[i]['PROD_SGST'],
          PROD_IGST: maps[i]['PROD_IGST'],
          PROD_HSNCODE: maps[i]['PROD_HSNCODE'],
          PROD_DISC_PERC: maps[i]['PROD_DISC_PERC'],
          PROD_DESC: maps[i]['PROD_DESC'],
          PROD_GROUPID: maps[i]['PROD_GROUPID'],
          PROD_GROUPNAME: maps[i]['PROD_GROUPNAME'],
          PROD_CREATED_USERID: maps[i]['PROD_CREATED_USERID'],
          PROD_CAPACITY: maps[i]['PROD_CAPACITY'],
          PROD_UNITID: maps[i]['PROD_UNITID'],
          PROD_UNITNAME: maps[i]['PROD_UNITNAME'],
          PROD_PACKCOUNT: maps[i]['PROD_PACKCOUNT'],
          PROD_MARKETID: maps[i]['PROD_MARKETID'],
          PROD_MARKETNAME: maps[i]['PROD_MARKETNAME'],
          PROD_CATID: maps[i]['PROD_CATID'],
          PROD_CATNAME: maps[i]['PROD_CATNAME'],
          PROD_ISFEATURED: maps[i]['PROD_ISFEATURED'],
          PROD_ISDELIVERABLE: maps[i]['PROD_ISDELIVERABLE'],
          PROD_ISSUBSCRIBE: maps[i]['PROD_ISSUBSCRIBE'],
          PROD_CREATED_AT: maps[i]['PROD_CREATED_AT'],
          PROD_UPDATED_AT: maps[i]['PROD_UPDATED_AT'],
          PROD_STATUS: maps[i]['PROD_STATUS']
        );
      });
  }

}

// await db.execute("CREATE TABLE Currencies (id INTEGER PRIMARY KEY autoincrement, FirstCountry TEXT, ConvertFirst TEXT, ConvertRateFirst TEXT, ConvertAmountFirst TEXT, dat TEXT, ConvertName TEXT,RND TEXT)");

class CountryHistoryData{

  int id;
  Map FirstCountry;
  Map SecondCountry;
  Map ThirdCountry;
  Map FourthCountry;
  String ConvertAmountFirst;
  String ConvertAmountSecond;
  String ConvertAmountThird;
  String ConvertAmountFourth;
  String RND;

  CountryHistoryData({id,this.FirstCountry,this.SecondCountry,this.ThirdCountry,this.FourthCountry,this.ConvertAmountFirst,this.ConvertAmountSecond,this.ConvertAmountThird,this.ConvertAmountFourth,this.RND});

  Map<String,dynamic> toMap(){
    return {
      "FirstCountry":FirstCountry,
      "SecondCountry":SecondCountry,
      "ThirdCountry":ThirdCountry,
      "FourthCountry":FourthCountry,
      "ConvertAmountFirst":ConvertAmountFirst,
      "ConvertAmountSecond":ConvertAmountSecond,
      "ConvertAmountThird":ConvertAmountThird,
      "ConvertAmountFourth":ConvertAmountFourth,
      "RND":RND,
    };
  }

}


class CountryModalData1{

  int id;
  Map FirstCountry;
  String ConvertFirst;
  String ConvertRateFirst;
  String ConvertAmountFirst;
  String dat;
  String ConvertName;
  String RND;

  CountryModalData1({id,this.FirstCountry,this.ConvertFirst,this.ConvertRateFirst,this.ConvertAmountFirst,this.dat,this.ConvertName,this.RND});



  Map<String,dynamic> toMap(){
    return {
      "FirstCountry":FirstCountry,
      "ConvertFirst": ConvertFirst,
      "ConvertRateFirst":ConvertRateFirst,
      "ConvertAmountFirst":ConvertAmountFirst,
      "dat":dat,
      "ConvertName": ConvertName,
      "RND":RND,
    };
  }


}


class CountryModalData{

  int id;
  Map FirstCountry;
  Map SecondCountry;
  Map ThirdCountry;
  Map FourthCountry;
  String ConvertFirst;
  String ConvertSecond;
  String ConvertThird;
  String ConvertFourth;
  String ConvertRateFirst;
  String ConvertRateSecond;
  String ConvertRateThird;
  String ConvertRateFourth;
  String ConvertAmountFirst;
  String ConvertAmountSecond;
  String ConvertAmountThird;
  String ConvertAmountFourth;
  String dat;
  String ConvertName;
  String RND;

  CountryModalData({id,this.FirstCountry,this.SecondCountry,this.ThirdCountry,this.FourthCountry,this.ConvertFirst,this.ConvertSecond,this.ConvertThird,this.ConvertFourth,this.ConvertRateFirst,this.ConvertRateSecond,this.ConvertRateThird,this.ConvertRateFourth,this.ConvertAmountFirst,this.ConvertAmountSecond,this.ConvertAmountThird,this.ConvertAmountFourth, this.dat,this.ConvertName, this.RND});

  Map<String,dynamic> toMap(){
    return {
      "FirstCountry":FirstCountry,
      "SecondCountry":SecondCountry,
      "ThirdCountry":ThirdCountry,
      "FourthCountry":FourthCountry,
      "ConvertFirst": ConvertFirst,
      "ConvertSecond": ConvertSecond,
      "ConvertThird":ConvertThird,
      "ConvertFourth": ConvertFourth,
      "ConvertRateFirst":ConvertRateFirst,
      "ConvertRateSecond":ConvertRateSecond,
      "ConvertRateThird":ConvertRateThird,
      "ConvertRateFourth": ConvertRateFourth,
      "ConvertAmountFirst":ConvertAmountFirst,
      "ConvertAmountSecond":ConvertAmountSecond,
      "ConvertAmountThird": ConvertAmountThird,
      "ConvertAmountFourth": ConvertAmountFourth,
      "dat":dat,
      "ConvertName":ConvertName,
      "RND" : RND,
    };
  }

}

class CartModel{

  int id;
  String RND_NUM;
  String QTY;
  String token;
  String PROD_ID;
  String PROD_NAME;
  String PROD_BRANDID;
  String PROD_BRANDNAME;
  String PROD_IMAGE;
  String PROD_META;
  String PROD_PRICE;
  String PROD_DISC_PRICE;
  String PROD_CGST;
  String PROD_SGST;
  String PROD_IGST;
  String PROD_HSNCODE;
  String PROD_DISC_PERC;
  String PROD_DESC;
  String PROD_GROUPID;
  String PROD_GROUPNAME;
  String PROD_CREATED_USERID;
  String PROD_CAPACITY;
  String PRODVAR_NAME;
  String PROD_UNITID;
  String PROD_UNITVALUE;
  String PROD_UNITNAME;
  String PROD_PACKCOUNT;
  String PROD_MARKETID;
  String PROD_MARKETNAME;
  String PROD_CATID;
  String PROD_CATNAME;
  String PROD_ISFEATURED;
  String PROD_ISDELIVERABLE;
  String PROD_ISSUBSCRIBE;
  String PROD_CREATED_AT;
  String PROD_UPDATED_AT;
  String PROD_STATUS;

  CartModel({id,this.RND_NUM,this.QTY,this.token,this.PROD_ID,this.PROD_NAME,this.PROD_BRANDID,this.PROD_BRANDNAME,this.PROD_IMAGE,this.PROD_META,this.PROD_PRICE,this.PROD_DISC_PRICE,this.PROD_CGST,this.PROD_SGST,this.PROD_IGST,this.PROD_HSNCODE,this.PROD_DISC_PERC,this.PROD_DESC,this.PROD_GROUPID,this.PROD_GROUPNAME,this.PROD_CREATED_USERID,this.PROD_CAPACITY,this.PRODVAR_NAME,this.PROD_UNITID,this.PROD_UNITVALUE,this.PROD_UNITNAME,this.PROD_PACKCOUNT,this.PROD_MARKETID,this.PROD_MARKETNAME,this.PROD_CATID,this.PROD_CATNAME,this.PROD_ISFEATURED,this.PROD_ISDELIVERABLE,this.PROD_ISSUBSCRIBE,this.PROD_CREATED_AT,this.PROD_UPDATED_AT,this.PROD_STATUS});
  Map<String,dynamic> toMap(){
    return{
      "RND_NUM":RND_NUM,
      "QTY":QTY,
      "token" : token,
      "PROD_ID": PROD_ID,
      "PROD_NAME": PROD_NAME,
      "PROD_BRANDID": PROD_BRANDID,
      "PROD_BRANDNAME": PROD_BRANDNAME,
      "PROD_IMAGE": PROD_IMAGE,
      "PROD_META": PROD_META,
      "PROD_PRICE": PROD_PRICE,
      "PROD_DISC_PRICE": PROD_DISC_PRICE,
      "PROD_CGST": PROD_CGST,
      "PROD_SGST": PROD_SGST,
      "PROD_IGST": PROD_IGST,
      "PROD_HSNCODE": PROD_HSNCODE,
      "PROD_DISC_PERC": PROD_DISC_PERC,
      "PROD_DESC": PROD_DESC,
      "PROD_GROUPID": PROD_GROUPID,
      "PROD_GROUPNAME": PROD_GROUPNAME,
      "PROD_CREATED_USERID": PROD_CREATED_USERID,
      "PROD_CAPACITY": PROD_CAPACITY,
      "PRODVAR_NAME":PRODVAR_NAME,
      "PROD_UNITID": PROD_UNITID,
      "PROD_UNITVALUE":PROD_UNITVALUE,
      "PROD_UNITNAME": PROD_UNITNAME,
      "PROD_PACKCOUNT": PROD_PACKCOUNT,
      "PROD_MARKETID": PROD_MARKETID,
      "PROD_MARKETNAME": PROD_MARKETNAME,
      "PROD_CATID": PROD_CATID,
      "PROD_CATNAME": PROD_CATNAME,
      "PROD_ISFEATURED": PROD_ISFEATURED,
      "PROD_ISDELIVERABLE": PROD_ISDELIVERABLE,
      "PROD_ISSUBSCRIBE": PROD_ISSUBSCRIBE,
      "PROD_CREATED_AT": PROD_CREATED_AT,
      "PROD_UPDATED_AT": PROD_UPDATED_AT,
      "PROD_STATUS": PROD_STATUS
    };
  }

}

