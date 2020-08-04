import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';
import 'components/exchange_rate_card.dart';
import 'components/dropdown.dart';
import 'services/coin.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String selectedCurrency = 'USD';
  Map<String, int> exchangeRate = {'BTC': 0, 'ETH': 0, 'LTC': 0};

  @override
  void initState() {
    super.initState();
    getCurrencyExchange(selectedCurrency);
  }

  getCurrencyExchange(realCurrency) async {
    CoinModel coinModel = new CoinModel();
    
    // BTC
    double btcExchangeRate = await coinModel.getExchangeRate('BTC', realCurrency);
    print(btcExchangeRate);

    // ETH
    double ethExchangeRate = await coinModel.getExchangeRate('ETH', realCurrency);
    print(ethExchangeRate);

    // LTC
    double ltcExchangeRate = await coinModel.getExchangeRate('LTC', realCurrency);
    print(ltcExchangeRate);

    setState(() {
      exchangeRate['BTC'] = btcExchangeRate.toInt();
      exchangeRate['ETH'] = ethExchangeRate.toInt();
      exchangeRate['LTC'] = ltcExchangeRate.toInt();      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ExchangeRateCard(
                cardColor: Colors.lightBlueAccent, 
                textContent: '1 BTC = ${exchangeRate['BTC']} $selectedCurrency'
              ),
              ExchangeRateCard(
                cardColor: Colors.lightBlueAccent, 
                textContent: '1 ETH = ${exchangeRate['ETH']} $selectedCurrency'
              ),
              ExchangeRateCard(
                cardColor: Colors.lightBlueAccent, 
                textContent: '1 LTC = ${exchangeRate['LTC']} $selectedCurrency'
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: (Platform.isAndroid) ? androidDropdown(
                menuItems: currenciesList, 
                dropdownBtnValue: selectedCurrency, 
                onChanged: (currency) {
                  setState(() {
                    print(currency);
                    selectedCurrency = currency;
                    getCurrencyExchange(currency);
                  });
                }
              ) : iosPicker(
                menuItems: currenciesList, 
                backgroundColor: Colors.lightBlue, 
                itemExtent: 32.0,
                onSelectedItemChanged: (selectedIndex){
                  selectedCurrency = currenciesList[selectedIndex];
                  getCurrencyExchange(currenciesList[selectedIndex]);
                },
                textStyle: TextStyle(
                  color: Colors.white,
                ),
              )
          ),
        ],
      ),
    );
  }
}

