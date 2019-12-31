import 'package:daily_end/localization/todo_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ad_manager/flutter_google_ad_manager.dart';


class AdBannerPage extends StatefulWidget {
  static const routeName = '/page/adBannerPage';

  @override
  State<StatefulWidget> createState() {
    return _AdBannerPageState();
  }

}

class _AdBannerPageState extends State<AdBannerPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TodoLocalizations.of(context).titleAdBanner),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
                TodoLocalizations.of(context).tipItemAdBanner,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          DFPBanner(
            isDevelop: true,
            adUnitId: 'ca-app-pub-1984117899270114/2548580404',
            adSize: DFPAdSize.BANNER,
            onAdLoaded: () {
              print('Banner onAdLoaded');
            },
            onAdFailedToLoad: (errorCode) {
              print('Banner onAdFailedToLoad: errorCode:$errorCode');
            },
            onAdOpened: () {
              print('Banner onAdOpened');
            },
            onAdClosed: () {
              print('Banner onAdClosed');
            },
            onAdLeftApplication: () {
              print('Banner onAdLeftApplication');
            },
          ),
          DFPBanner(
            isDevelop: true,
            adUnitId: 'ca-app-pub-1984117899270114/9837711787',
            adSize: DFPAdSize.BANNER,
            onAdLoaded: () {
              print('Banner onAdLoaded');
            },
            onAdFailedToLoad: (errorCode) {
              print('Banner onAdFailedToLoad: errorCode:$errorCode');
            },
            onAdOpened: () {
              print('Banner onAdOpened');
            },
            onAdClosed: () {
              print('Banner onAdClosed');
            },
            onAdLeftApplication: () {
              print('Banner onAdLeftApplication');
            },
          )
        ],
      ),
    );
  }
}