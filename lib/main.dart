import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:tut_app/presentation/resources/langauge_manager.dart';
import 'app/app.dart';
import 'app/di.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(EasyLocalization(
    supportedLocales: const [ARABIC_LOCAL, ENGLISH_LOCAL],
    path: ASSET_PATH_LOCALISATIONS,
    child: Phoenix(child: MyApp()),
  ));
}
