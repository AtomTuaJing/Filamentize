import "package:filamentize2/firebase_options.dart";
import "package:filamentize2/services/auth.dart";
import "package:filamentize2/services/filamentizeData.dart";
import "package:filamentize2/services/languages.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:flutter_localization/flutter_localization.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:provider/provider.dart";

final FlutterLocalization localization = FlutterLocalization.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    localization.init(mapLocales: [
      const MapLocale('en', AppLocale.EN),
      const MapLocale('cn', AppLocale.CN),
      const MapLocale('th', AppLocale.TH),
    ], initLanguageCode: 'en');
    localization.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FilamentizeData())
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          supportedLocales: localization.supportedLocales,
          localizationsDelegates: localization.localizationsDelegates,
          home: const Auth(),
        ),
      ),
    );
  }
}
