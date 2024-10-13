import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/generated/l10n.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Localization(),
      child: Consumer<Localization>(
        builder: (context, Localization localization, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            locale: Locale(localization.locale),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const MyHomePage(title: 'Flutter Demo Home Page'),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(S.of(context).title),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Text(S.of(context).hello),
              Padding(
                padding: EdgeInsets.only(
                  left: isArabic() ? 0 : 8,
                  right: isArabic() ? 8 : 0,
                ),
                child: Text(S.of(context).name),
              ),
            ],
          ),
          Center(
            child: Switch(
              value: isArabic(),
              onChanged: (value) {
                Provider.of<Localization>(context, listen: false)
                    .setLocale(isArabic() ? 'en' : 'ar');
              },
            ),
          )
        ],
      ),
    );
  }
}

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

class Localization extends ChangeNotifier {
  String locale = 'en';

  void setLocale(String newLocale) {
    locale = newLocale;
    notifyListeners();
  }
}
