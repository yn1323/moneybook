import 'package:moneybook/imports.dart';
import 'package:moneybook/pages/category_edit.dart';
import 'package:moneybook/pages/category_new.dart';
import 'package:moneybook/pages/home.dart';
import 'package:moneybook/providers/category.dart';
import 'package:moneybook/providers/currency.dart';
import 'package:moneybook/providers/id.dart';
import 'package:moneybook/themes/schemes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:moneybook/pages/config_currency.dart';
import 'package:moneybook/pages/config_id.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

typedef CategoryEditArgs = Map<String, dynamic>;

void main() async {
  await Hive.initFlutter();
  await Firebase.initializeApp();
  final auth = FirebaseAuth.instance;
  await auth.signInAnonymously();
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

  Future<void> _init(WidgetRef ref) async {
    await Hive.deleteFromDisk();
    await ref.read(idProvider.notifier).initialize();
    await ref.read(currencyProvider.notifier).initialize();
    await ref.read(categoryProvider.notifier).initialize();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: _init(ref),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) =>
          MaterialApp(
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
          '/category/new': (context) => const CategoryNew(),
          '/category/edit': (context) => const CategoryEdit(),
        },
      ),
    );
  }
}
