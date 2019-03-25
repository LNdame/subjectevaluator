import 'package:flutter/material.dart';
import 'landing.dart';
import 'home.dart';
import 'colors.dart';
import 'splashpage.dart';



class EvaluatorApp extends StatefulWidget{
  
  @override
  _EvaluatorAppState createState() {
    // TODO: implement createState
    return new _EvaluatorAppState();
  }
}

class _EvaluatorAppState extends State<EvaluatorApp>{
  
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rate Your Learning Experience',
      home: HomePage() ,
      initialRoute: '/splash',
      routes: {
        '/landing':(context)=>LandingPage(),
      },
      onGenerateRoute: _getRoute,
      theme: _EvaluatorTheme,
    );//material
  }

  Route<dynamic> _getRoute(RouteSettings settings){
    if(settings.name!='/splash'){
      return null;
    }

    return MaterialPageRoute<void>(
     settings: settings,
    builder: (BuildContext context) => SplashPage(),
    fullscreenDialog: true,
    );
  }

}



final ThemeData _EvaluatorTheme = _builEvaluatorTheme();


ThemeData _builEvaluatorTheme(){
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    accentColor: kShrineAltDarkGrey,
    primaryColor: kShrineAltDarkGrey,
    buttonColor: kShrineAltYellow,
    scaffoldBackgroundColor: kShrineAltDarkGrey,
    cardColor: kShrineAltLightGrey,
    textSelectionColor: kShrinePink100,
    errorColor: kShrineErrorRed,
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.accent,
    ),
    primaryIconTheme: base.iconTheme.copyWith(
        color: kShrineAltYellow
    ),
    inputDecorationTheme: InputDecorationTheme(
      border:OutlineInputBorder( borderRadius: BorderRadius.circular(4.0)
      ),
    ),
    textTheme: _buildEvaluatorTextTheme(base.textTheme),
    primaryTextTheme: _buildEvaluatorTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildEvaluatorTextTheme(base.accentTextTheme),
  );
}


TextTheme _buildEvaluatorTextTheme(TextTheme base) {
  return base.copyWith(
    headline: base.headline.copyWith(
      fontWeight: FontWeight.w500,
    ),
    title: base.title.copyWith(
        fontSize: 18.0
    ),
    caption: base.caption.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
    ),
    body2: base.body2.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
    ),
  ).apply(
    fontFamily: 'Rubik',
    displayColor: kShrineBrown900,
    bodyColor: kShrineBrown900,
  );
}