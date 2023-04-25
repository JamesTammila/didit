import 'package:flutter_dotenv/flutter_dotenv.dart';

class DefaultParseOptions {
  static const String appName = 'Jumbl';
  static String serverUrl = dotenv.env['SERVER_URL']!;
  //static const String serverUrl = 'http://192.168.50.252:1337/';
  static String clientKey = dotenv.env['CLIENT_KEY']!;
  static const bool debug = false;
//static const bool debug = true;
}