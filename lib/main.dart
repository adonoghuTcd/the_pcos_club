import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'pages/monthly_view.dart';

import 'widgets/bottom_navigation_bar.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

Map<int, Color> color ={50:Color.fromRGBO(136,14,79, .1),
  100:Color.fromRGBO(243, 93, 109, .2),
  200:Color.fromRGBO(243, 93, 109, .3),
  300:Color.fromRGBO(243, 93, 109, .4),
  400:Color.fromRGBO(243, 93, 109, .5),
  500:Color.fromRGBO(243, 93, 109, .6),
  600:Color.fromRGBO(243, 93, 109, .7),
  700:Color.fromRGBO(243, 93, 109, .8),
  800:Color.fromRGBO(243, 93, 109, .9),
  900:Color.fromRGBO(243, 93, 109, 1),};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TableCalendar Example',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFFF35D6D, color)
      ),
      home: StartPage(),
    );
  }
}

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The Pcos Club'),
      ),
      body: MonthlyViewCalendar(),
      bottomNavigationBar: NavigationBar()
    );
  }
}