import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:didit/util/options_firebase.dart';
import 'package:didit/util/options_parse.dart';
import 'package:didit/util/observer.dart';
import 'package:didit/app.dart';

void main() async {
  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Parse().initialize(
    DefaultParseOptions.appName,
    DefaultParseOptions.serverUrl,
    clientKey: DefaultParseOptions.clientKey,
    debug: DefaultParseOptions.debug,
  );
  Bloc.observer = CubitObserver();
  runApp(const App());
}