import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:numbertrivia/core/localization/app_localization.dart';
import 'package:numbertrivia/core/localization/app_localization_delegate.dart';
import 'package:numbertrivia/features/number_trivia/presentation/provider/trivia_provider.dart';
import 'package:numbertrivia/features/number_trivia/presentation/screens/main_screen.dart';
import 'package:provider/provider.dart';
import './core/util/dependency_injection_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencyInjection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GetIt.instance.get<TriviaProvider>(),
      child: MaterialApp(
        onGenerateTitle: (context) => AppLocalization.of(context).title,
        localizationsDelegates: [
          const AppLocalizationDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [
          const Locale('en'),
          const Locale('ar'),
        ],
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainScreen(),
      ),
    );
  }
}
