

import 'package:sncurrencyconverter/Helpers/ApiManager.dart';

App app = App();

class SearchHistoricalDataController{


  searchdata(context,FirstCountry,SecondCountry,startdate,enddate) async{

    var cncyform = "${FirstCountry['currency']+"_"+SecondCountry['currency']}";

    print(cncyform.toString());

    var url = "https://api.currconv.com/api/v7/convert?q=$cncyform&compact=ultra&date=$startdate&endDate=$enddate&apiKey=4c50d0c9131c42b589a14674f23ad236";

    var data = await app.getApi(url, context);

    print("============ HISTORICAL DATA "+data.toString());

    var body = data[cncyform];

    return body;
  }

}