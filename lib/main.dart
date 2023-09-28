import 'package:finance_folio_app/constant/route_constants.dart';
import 'package:finance_folio_app/pages/AddExpenditurePage.dart';
import 'package:finance_folio_app/pages/AddIncomePage.dart';
import 'package:finance_folio_app/pages/DetailCashFlowPage.dart';
import 'package:finance_folio_app/pages/HomePage.dart';
import 'package:finance_folio_app/pages/LoginPage.dart';
import 'package:finance_folio_app/pages/SettingsPage.dart';
import 'package:finance_folio_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ], child: const MyApp()));
}

final routes = {
  loginRoute: (BuildContext context) => LoginPage(),
  homeRoute: (BuildContext context) => HomePage(),
  settingsRoute: (BuildContext context) => SettingsPage(),
  addExpenseRoute: (BuildContext context) => AddExpenditurePage(),
  addIncomeRoute: (BuildContext context) => AddIncomePage(),
  detailCashFlowRoute: (BuildContext context) => DetailCashFlowPage(),
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "FinanceFolio App",
      theme: ThemeData(primaryColor: Colors.deepPurple.shade800),
      routes: routes,
    );
  }
}
