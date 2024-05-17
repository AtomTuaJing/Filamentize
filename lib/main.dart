import "package:filamentize2/firebase_options.dart";
import "package:filamentize2/services/auth.dart";
import "package:filamentize2/services/filamentizeData.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FilamentizeData())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Auth(),
      ),
    );
  }
}
