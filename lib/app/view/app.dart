import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:test_upwork/app/home/home_view.dart';
import 'package:test_upwork/app/photos/photo_view.dart';
// import 'package:test_upwork/counter/counter.dart';
import 'package:test_upwork/l10n/l10n.dart';
import 'package:test_upwork/services/photo_services.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PhotoService(Dio()),
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: const Color(0xFF13B9FF),
          ),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const PhotoView(),
      ),
    );
  }
}
