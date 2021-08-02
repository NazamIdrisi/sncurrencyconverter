

import 'dart:convert';

import 'package:flutter/services.dart';

class CountriesController{

  getcountries() async{

    final String response = await rootBundle.loadString('assets/country_codes.json');
    final data = await json.decode(response);


    print("COUNTRIES "+data.toString());
    return data;
  }

}