import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twisun/routs.dart';
import 'package:twisun/screens/home/home_screen.dart';
import 'package:twisun/screens/splash/splash_screen.dart';
import 'package:twisun/screens/wrapper.dart';
import 'package:twisun/services/auth_service.dart';
import 'package:twisun/theme.dart';

import 'models/user_model.dart';

void main() async {
  //TODO Mejorar este async según las recomendaciones, crear también pantalla de carga cuando hace login
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  // if (!FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
  //   await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  // }

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Twi-Sun',
        theme: theme(),
        //home: SplashScreen(),
        // We use routeName so that we dont need to remember the name
        //initialRoute: SplashScreen.routeName,
        //initialRoute: HomeScreen.routeName,
        initialRoute: Wrapper.routeName,
        routes: routes,
      ),
    );
    /*
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Twi-Sun',
      theme: theme(),
      //home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: SplashScreen.routeName,
      //initialRoute: HomeScreen.routeName,
      routes: routes,
    );*/
  }
}
