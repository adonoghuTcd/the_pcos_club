import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pcos_club/auth/authFirebase.dart';
import 'package:provider/provider.dart';

import 'pages/monthly_view.dart';
import 'pages/authentication.dart';
import 'pages/settings.dart';

import 'widgets/bottom_navigation_bar.dart';
import 'utils/colours.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Authentication()
        )
      ],
      child: MaterialApp(
        title: 'The PCOS Club',
        theme: ThemeData(
          primarySwatch: CustomColour.primary()
        ),
        // initialRoute:
        routes: {
          HomePage.routeName: (context) => HomePage(),
          MonthlyViewCalendar.routeName: (context) => MonthlyViewCalendar(),
          SettingsScreen.routeName: (context) => SettingsScreen()
        },
        home: AuthenticationPage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  static const routeName = '/';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The PCOS Club'),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
            child: IconButton(
              icon: const Icon(Icons.save, size: 30.0),
              onPressed: () {
                Navigator.of(context).pushNamed(SettingsScreen.routeName);
              },
            ),
          ),
        ],
      ),
      body: MonthlyViewCalendar(),
      bottomNavigationBar: NavigationBar()
    );
  }
}