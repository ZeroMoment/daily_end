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
  //横幅
  DFPBannerViewController _firstBannerViewController;
  DFPBannerViewController _secondBannerViewController;
  DFPBannerViewController _thirdBannerViewController;

  //插页
  DFPInterstitialAd _interstitialAd;

  @override
  void initState() {
    super.initState();
    //插页初始化
    _interstitialAd = DFPInterstitialAd(
      isDevelop: false,
      adUnitId: "ca-app-pub-1984117899270114/2810705794",
      onAdLoaded: () {
        print('interstitialAd onAdLoaded');
      },
      onAdFailedToLoad: (errorCode) {
        print('interstitialAd onAdFailedToLoad: errorCode:$errorCode');
      },
      onAdOpened: () {
        print('interstitialAd onAdOpened');
      },
      onAdClosed: () {
        print('interstitialAd onAdClosed');
        _interstitialAd.load();
      },
      onAdLeftApplication: () {
        print('interstitialAd onAdLeftApplication');
      },
    );
    _interstitialAd.load();

    //显示插页
    _showInterstAd();
  }

  void _showInterstAd() async {
    await _interstitialAd.show();
  }

  Future _reloadAd() async {
    await _firstBannerViewController?.reload();
    await _secondBannerViewController?.reload();
    await _thirdBannerViewController?.reload();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TodoLocalizations.of(context).titleAdBanner),
      ),
      body: RefreshIndicator(
        onRefresh: _reloadAd,
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                TodoLocalizations.of(context).tipItemAdBanner,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            DFPBanner(
              isDevelop: false,
//              testDevices: ADTestDevices(),
              adUnitId: 'ca-app-pub-1984117899270114/2548580404',
              adSize: DFPAdSize.LARGE_BANNER,
              onAdViewCreated: (controller) {
                _firstBannerViewController = controller;
              },
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
            SizedBox(
              height: 30.0,
            ),
            DFPBanner(
              isDevelop: false,
//              testDevices: ADTestDevices(),
              adUnitId: 'ca-app-pub-1984117899270114/9837711787',
              adSize: DFPAdSize.LARGE_BANNER,
              onAdViewCreated: (controller) {
                _secondBannerViewController = controller;
              },
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
            SizedBox(
              height: 30.0,
            ),
            DFPBanner(
              isDevelop: false,
//              testDevices: ADTestDevices(),
              adUnitId: 'ca-app-pub-1984117899270114/6069270432',
              adSize: DFPAdSize.LARGE_BANNER,
              onAdViewCreated: (controller) {
                _thirdBannerViewController = controller;
              },
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
            SizedBox(
              height: 30.0,
            ),
            DFPBanner(
              isDevelop: false,
//              testDevices: ADTestDevices(),
              adUnitId: 'ca-app-pub-1984117899270114/7951351831',
              adSize: DFPAdSize.LARGE_BANNER,
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
            SizedBox(
              height: 30.0,
            ),
            DFPBanner(
              isDevelop: false,
//              testDevices: ADTestDevices(),
              adUnitId: 'ca-app-pub-1984117899270114/5509021326',
              adSize: DFPAdSize.LARGE_BANNER,
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
            SizedBox(
              height: 30.0,
            ),
            DFPBanner(
              isDevelop: false,
//              testDevices: ADTestDevices(),
              adUnitId: 'ca-app-pub-1984117899270114/2882857985',
              adSize: DFPAdSize.LARGE_BANNER,
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
      ),
    );
  }

  @override
  void dispose() {
    _interstitialAd.dispose();
    super.dispose();
  }
}
