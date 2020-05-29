import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';
const appColor = Colors.lightGreen;

/*
class IconButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return new IconButton(
      // Bitcoin
      icon: new Icon(CryptoFontIcons.BTC),
    );
  }
}*/

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  double howManyCrypto = 2;
  String selectedCurrency = 'EUR';
  String selectedCrypto = 'BTC';


  DropdownButton<String> androidCryptoDropdown(){
    List<DropdownMenuItem<String>> dropDownItems = [];

    for( int i = 0 ; i < cryptoList.length; i++) {
      String crypto = cryptoList[i];
      var newItem = DropdownMenuItem(
          child: Text(crypto),
          value: crypto,

      );
      dropDownItems.add(newItem);
    }

    return DropdownButton(
      value: selectedCrypto,
      items: dropDownItems,
      onChanged: (value){
        setState(() {
          selectedCrypto = value;
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSCryptoPicker(){
    List<Text> list = [];

    for(String crypto in cryptoList){
      list.add(Text(crypto));
    }
    return CupertinoPicker(
      backgroundColor: appColor,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex){
        print(selectedIndex);
        setState(() {
          selectedCrypto = currenciesList[selectedIndex];
          getData();
        });
      },
      children: list,
    );
  }

  DropdownButton<String> androidCurrencyDropdown(){
    List<DropdownMenuItem<String>> dropDownItems = [];

    for( int i = 0 ; i < currenciesList.length; i++) {
      String currency = currenciesList[i];
      var newItem = DropdownMenuItem(
          child: Text(currency),
          value: currency
      );
      dropDownItems.add(newItem);
    }

    return DropdownButton(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value){
        setState(() {
          selectedCurrency = value;
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSCurrencyPicker(){
    List<Text> list = [];

    for(String currency in currenciesList){
      list.add(Text(currency));
    }
    return CupertinoPicker(
        backgroundColor: appColor,
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex){
        print(selectedIndex);
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getData();
        });
    },
    children: list,
    );
  }

  Widget getPicker(){
    if(Platform.isIOS){
      return iOSCurrencyPicker();
    } else if(Platform.isAndroid){
      return androidCurrencyDropdown();
    }
  }

  String bitcoinValue = '?';

  void getData() async {
    try {
      double data = await CoinData().getCoinData(selectedCurrency, selectedCrypto);
      setState(() {
        bitcoinValue = data.toStringAsFixed(0);
      });
    } catch (e){
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: <Widget>[
        IconButton(
          icon: new Icon(
              CryptoFontIcons.BTC,
              color: Colors.yellow,
          ),
        )
      ],
        title: Text('Live Crypto Price'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: appColor,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $selectedCrypto = $bitcoinValue $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: appColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Platform.isAndroid ? androidCurrencyDropdown() : iOSCurrencyPicker(),
                Platform.isAndroid ? androidCryptoDropdown(): iOSCryptoPicker(),
              ],
            ),
            ),
        ],
      ),
    );
  }
}



