import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

checkError(ParseResponse response) {
  if (response.error != null) {
    switch (response.error?.code) {
      /*case ParseError.accountAlreadyLinked: throw '';
      case ParseError.aggregateError: throw '';
      case ParseError.cacheMiss: throw '';
      case ParseError.commandUnavailable: throw '';
      case ParseError.connectionFailed: throw '';
      case ParseError.duplicateRequest: throw '';
      case ParseError.duplicateValue: throw '';
      case ParseError.emailMissing: throw '';
      case ParseError.emailNotFound: throw '';
      case ParseError.emailTaken: throw '';*/

      case ParseError.timeout: throw 'Server Connection Timed Out';
      case ParseError.internalServerError: throw 'Server Down';
      case ParseError.connectionFailed: throw 'Server Connection Failed';
      case ParseError.validationError: throw 'Server Validation Failed';
      case ParseError.invalidSessionToken: throw 'Invalid User Session';
      case ParseError.sessionMissing: throw 'Missing User Session';
      case ParseError.aggregateError: throw 'Aggregate Error';
      default: throw 'Response Failed';
    }
  }
}