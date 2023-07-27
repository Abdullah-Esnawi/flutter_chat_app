// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `WhatsApp`
  String get whatsapp {
    return Intl.message(
      'WhatsApp',
      name: 'whatsapp',
      desc: '',
      args: [],
    );
  }

  /// `online`
  String get online {
    return Intl.message(
      'online',
      name: 'online',
      desc: '',
      args: [],
    );
  }

  /// `offline`
  String get offline {
    return Intl.message(
      'offline',
      name: 'offline',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get bottomChatFieldHint {
    return Intl.message(
      'Message',
      name: 'bottomChatFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `This Number does not exist on this app.`
  String get numberDoesNotExist {
    return Intl.message(
      'This Number does not exist on this app.',
      name: 'numberDoesNotExist',
      desc: '',
      args: [],
    );
  }

  /// `The provided phone number is not valid.`
  String get phoneNumberNotValid {
    return Intl.message(
      'The provided phone number is not valid.',
      name: 'phoneNumberNotValid',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Error`
  String get unknownErr {
    return Intl.message(
      'Unknown Error',
      name: 'unknownErr',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get changeLanguageScreenEnglish {
    return Intl.message(
      'English',
      name: 'changeLanguageScreenEnglish',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get changeLanguageScreenArabic {
    return Intl.message(
      'Arabic',
      name: 'changeLanguageScreenArabic',
      desc: '',
      args: [],
    );
  }

  /// `Something Went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something Went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `You don't have contacts yet`
  String get youDontHaveContacts {
    return Intl.message(
      'You don\'t have contacts yet',
      name: 'youDontHaveContacts',
      desc: '',
      args: [],
    );
  }

  /// `Select Contact`
  String get selectContact {
    return Intl.message(
      'Select Contact',
      name: 'selectContact',
      desc: '',
      args: [],
    );
  }

  /// `CHATS`
  String get chatsTabLabel {
    return Intl.message(
      'CHATS',
      name: 'chatsTabLabel',
      desc: '',
      args: [],
    );
  }

  /// `STATUS`
  String get statusTabLabel {
    return Intl.message(
      'STATUS',
      name: 'statusTabLabel',
      desc: '',
      args: [],
    );
  }

  /// `CALLS`
  String get callsTabLabel {
    return Intl.message(
      'CALLS',
      name: 'callsTabLabel',
      desc: '',
      args: [],
    );
  }

  /// `Document`
  String get docFileTypeName {
    return Intl.message(
      'Document',
      name: 'docFileTypeName',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get cameraFileTypeName {
    return Intl.message(
      'Camera',
      name: 'cameraFileTypeName',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get galleryFileTypeName {
    return Intl.message(
      'Gallery',
      name: 'galleryFileTypeName',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get contactFileTypeName {
    return Intl.message(
      'Contact',
      name: 'contactFileTypeName',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get locationFileTypeName {
    return Intl.message(
      'Location',
      name: 'locationFileTypeName',
      desc: '',
      args: [],
    );
  }

  /// `Audio`
  String get audioFileTypeName {
    return Intl.message(
      'Audio',
      name: 'audioFileTypeName',
      desc: '',
      args: [],
    );
  }

  /// `Poll`
  String get pollFileTypeName {
    return Intl.message(
      'Poll',
      name: 'pollFileTypeName',
      desc: '',
      args: [],
    );
  }

  /// `from`
  String get from {
    return Intl.message(
      'from',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `Hold to record, release to send`
  String get recordToastMsg {
    return Intl.message(
      'Hold to record, release to send',
      name: 'recordToastMsg',
      desc: '',
      args: [],
    );
  }

  /// `You`
  String get you {
    return Intl.message(
      'You',
      name: 'you',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Name`
  String get enterName {
    return Intl.message(
      'Enter Your Name',
      name: 'enterName',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
