import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:didit/src/app.dart';

void main() async {
  await Parse().initialize(
    "dewdrop",
    //"https://api.dewdrop.app/parse",
    "http://192.16.140.72:1337/parse",
    clientKey: "2EXP5msTGBxqu7rG",
    //debug: false,
    debug: true,
  );
  runApp(App());
}