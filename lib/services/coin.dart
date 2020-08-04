import 'dart:convert';

import 'package:http/http.dart' as http;

const coinapiEndpoint = 'https://rest.coinapi.io/v1';
const apiKey = '';

class CoinModel {
  Future<double> getExchangeRate(String virtualCurrency, String realCurrency) async {
    String url = '$coinapiEndpoint/exchangerate/$virtualCurrency/$realCurrency';
    print(url);
    Map<String,String> headers = {'X-CoinAPI-Key': apiKey};
    http.Response response = await http.get(url, headers: headers);
    
    if (response.statusCode == 200){
      dynamic data = jsonDecode(response.body);
      print(data);
      return data['rate'] + 0.0;
    } else {
      print(response.statusCode);
    }

    return 0;
  }
}