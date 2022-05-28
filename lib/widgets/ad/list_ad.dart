import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:moneybook/imports.dart';

class ListAd extends ConsumerStatefulWidget {
  const ListAd({
    Key? key,
  }) : super(key: key);

  @override
  _ListAd createState() => _ListAd();
}

class _ListAd extends ConsumerState<ListAd> {
  @override
  Widget build(BuildContext context) {
    BannerAd myBanner = BannerAd(
      adUnitId: "ca-app-pub-6362026991302319/6545841792",
      size: AdSize.banner,
      request: const AdRequest(),
      listener: const BannerAdListener(),
    );
    myBanner.load();

    final AdWidget adWidget = AdWidget(ad: myBanner);
    final Container adContainer = Container(
      alignment: Alignment.center,
      child: adWidget,
      width: myBanner.size.width.toDouble(),
      height: myBanner.size.height.toDouble(),
    );

    return adContainer;
  }
}
