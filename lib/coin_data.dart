import 'package:http/http.dart' as http;
import 'dart:convert';
import 'price_screen.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];


class CoinData {
  Future getCoinData(String selectedCurrency, String selectedCrypto) async {
    String apiKey = 'D396793E-99F0-466B-BA48-B2EA642A37B3';
    String apiWebPage = 'https://rest.coinapi.io/v1/exchangerate/$selectedCrypto/$selectedCurrency?apikey=';
    http.Response response = await http.get(apiWebPage + apiKey);

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      var lastPrice = decodedData['rate'];
      return lastPrice;
    } else {
      print(response.statusCode);
    }
  }
}
