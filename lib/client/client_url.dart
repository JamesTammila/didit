import 'package:url_launcher/url_launcher.dart';

abstract class IUrlClient {
  Future<void> openWebsite();
  Future<void> openTerms();
  Future<void> openPrivacy();
  Future<void> openContact();
}

class UrlClient implements IUrlClient {
  static const String link = 'https://jumbl.social/';
  static const String contact = 'https://jumbl.social/contact';
  static const String terms = 'https://jumbl.social/terms';
  static const String privacy = 'https://jumbl.social/privacy';

  @override
  Future<void> openWebsite() async {
    if (!await launchUrl(Uri.parse(link))) {
      throw 'Could not connect to $link.';
    }
  }

  @override
  Future<void> openContact() async {
    if (!await launchUrl(Uri.parse(contact))) {
    throw 'Could not connect to $contact.';
    }
  }

  @override
  Future<void> openTerms() async {
    if (!await launchUrl(Uri.parse(terms))) {
      throw 'Could not connect to $terms.';
    }
  }

  @override
  Future<void> openPrivacy() async {
    if (!await launchUrl(Uri.parse(privacy))) {
    throw 'Could not connect to $privacy.';
    }
  }
}