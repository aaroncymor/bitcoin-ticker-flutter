import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'components/exchange_rate_card.dart';
import 'components/dropdown.dart';
import 'services/coin.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String selectedCurrency = 'USD';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrencyExchange();
  }

  getCurrencyExchange() async {
    CoinModel coinModel = new CoinModel();
    double exchange = await coinModel.getExchangeRate('BTC', 'PHP');
   return exchange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ExchangeRateCard(
            cardColor: Colors.lightBlueAccent, 
            textContent: '1 BTC = ? USD'
          ),
          ExchangeRateCard(
            cardColor: Colors.lightBlueAccent, 
            textContent: '1 ETH = ? USD'
          ),
          ExchangeRateCard(
            cardColor: Colors.lightBlueAccent, 
            textContent: '1 LTC = ? USD'
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
                  });
                }
              ) : iosPicker(
                menuItems: currenciesList, 
                backgroundColor: Colors.lightBlue, 
                itemExtent: 32.0,
                onSelectedItemChanged: (selectedIndex){
                  print(selectedIndex);
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

