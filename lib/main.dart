import 'package:moneybook/imports.dart';
import 'package:moneybook/models/cash.dart';
import 'package:moneybook/pages/category.dart';
import 'package:moneybook/pages/chart.dart';
import 'package:moneybook/pages/config.dart';
import 'package:moneybook/pages/debug.dart';
import 'package:moneybook/pages/modal/cash_new.dart';
import 'package:moneybook/pages/modal/category_edit.dart';
import 'package:moneybook/pages/modal/category_new.dart';
import 'package:moneybook/pages/home.dart';
import 'package:moneybook/pages/modal/member_edit.dart';
import 'package:moneybook/pages/modal/member_new.dart';
import 'package:moneybook/providers/cash.dart';
import 'package:moneybook/providers/category.dart';
import 'package:moneybook/providers/currency.dart';
import 'package:moneybook/providers/id.dart';
import 'package:moneybook/providers/member.dart';
import 'package:moneybook/themes/schemes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:moneybook/pages/modal/config_currency.dart';
import 'package:moneybook/pages/modal/config_id.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

typedef CategoryEditArgs = Map<String, dynamic>;

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Cash>(CashAdapter());
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
    // await Hive.deleteFromDisk();
    await ref.read(idProvider.notifier).initialize();
    await ref.read(currencyProvider.notifier).initialize();
    await ref.read(categoryProvider.notifier).initialize();
    await ref.read(memberProvider.notifier).initialize();
    await ref.read(cashProvider.notifier).initialize();
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
          '/': (context) => const DebugPage(),
          '/chart': (context) => const ChartPage(),
          '/category': (context) => const CategoryPage(),
          '/config': (context) => const ConfigPage(),
          // '/': (context) => const DbStub(),
          '/config/id': (context) => const ConfigId(),
          '/config/currency': (context) => const ConfigCurrency(),
          '/category/new': (context) => const CategoryNew(),
          '/category/edit': (context) => const CategoryEdit(),
          '/member/new': (context) => const MemberNew(),
          '/member/edit': (context) => const MemberEdit(),
          '/cash/new': (context) => const CashNew(),
          '/cash/edit': (context, {id}) => const CashNew(),
        },
      ),
    );
  }
}
