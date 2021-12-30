import 'package:moneybook/imports.dart';
import 'package:moneybook/pages/dbstub.dart';
import 'package:moneybook/pages/home.dart';
import 'package:moneybook/themes/schemes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:moneybook/pages/config_currency.dart';
import 'package:moneybook/pages/config_id.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      locale: locale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        locale,
      ],
      theme: ThemeData.from(colorScheme: lightTheme),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        // '/': (context) => const DbStub(),
        '/config/id': (context) => const ConfigId(),
        '/config/currency': (context) => const ConfigCurrency(),
      },
    );
  }
}
