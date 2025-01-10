import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation/HomeScreen.dart';
import 'package:graduation/OnboardingScreen%20.dart';
import 'package:graduation/contentview.dart';
import 'package:graduation/login.dart';
import 'package:graduation/signup.dart';
import 'profile.dart';
// Import your OnboardingScreen here
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en'); // Default language is Arabic

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthWrapper(changeLanguage: _changeLanguage),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      locale: _locale, // Dynamic locale change
      routes: {
        '/login': (context) =>  LoginPage(changeLanguage:_changeLanguage,),
        '/signup': (context) =>  SignUpPage(changeLanguage:_changeLanguage,),
        '/contactview': (context) =>  ContentView(changeLanguage: _changeLanguage,),
        '/profile': (context) =>  Profile(changeLanguage:  _changeLanguage,),
        '/home': (context) => HomeScreen(changeLanguage: _changeLanguage),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Function(Locale) changeLanguage;

  AuthWrapper({super.key, required this.changeLanguage});

  Future<bool> _checkIfOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboarding_completed') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData && snapshot.data != null) {
          return  ContentView(changeLanguage:changeLanguage ,);
        }

        // Check if onboarding is completed
        return FutureBuilder<bool>(
          future: _checkIfOnboardingCompleted(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.data == true) {
              // If onboarding completed, go to HomeScreen
              return HomeScreen(changeLanguage: changeLanguage);
            } else {
              // If onboarding not completed, show OnboardingScreen
              return OnboardingScreen();
            }
          },
        );
      },
    );
  }
}
