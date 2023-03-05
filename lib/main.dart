import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'util/firebase_options.dart';
import 'package:didit/util/observer.dart';
import 'package:didit/app.dart';

void main() async {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      //statusBarColor: Colors.transparent,
      //statusBarBrightness: Brightness.dark,
      //statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      //systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await Parse().initialize(
    'Jumbl',
    'http://192.168.50.252:1337/parse',
    clientKey: '2EXP5msTGBxqu7rG',
    debug: true,
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = CubitObserver();
  runApp(const App());
}