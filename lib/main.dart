import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sports_news/core/auth.dart';
import 'package:sports_news/modules/login_module/login_provider.dart';

void main() {
  // register singletons
  GetIt.instance.registerSingleton(
    Auth(),
    signalsReady: true,
  );

  final CatcherOptions options = CatcherOptions(
    SilentReportMode(),
    <ReportHandler>[
      ConsoleHandler(
        enableDeviceParameters: false,
        enableApplicationParameters: false,
      ),
      ToastHandler(
        length: ToastHandlerLength.short,
      ),
    ],
  );

  Catcher(
    rootWidget: MesaApp(),
    debugConfig: options,
  );

}

class MesaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mesa News',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        primaryColor: const Color(0xFFE5E5E5),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: Catcher.navigatorKey,
      home: LoginProvider(),
    );
  }
}
