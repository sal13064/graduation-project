import 'package:flutter/material.dart';
import 'package:graduation/AutismScreen.dart';
import 'profile.dart';
import 'centers.dart';
import 'games.dart';
import 'ai_diagnosis.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContentView extends StatelessWidget {
      final Function(Locale) changeLanguage;

  const ContentView({super.key,required this.changeLanguage});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.welcome,
          style: const TextStyle(color: Colors.black, fontSize: 24),
        ),
        iconTheme: const IconThemeData(color: Colors.black, size: 30),
        leading: IconButton(
          icon: const Icon(Icons.account_circle, size: 35),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  Profile(changeLanguage: changeLanguage,)),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset('assets/logo.jpg', width: 300, height: 300),
            const SizedBox(height: 60),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CentersPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB2A4D4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 25),
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        child: Text(AppLocalizations.of(context)!.centers),
                      ),
                      const SizedBox(width: 30),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  GamesPage(changeLanguage: changeLanguage,)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB2A4D4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 25),
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        child: Text(AppLocalizations.of(context)!.games),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AiDiagnosisPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB2A4D4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 25),
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        child: Text(AppLocalizations.of(context)!.ai_diagnosis),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AutismScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB2A4D4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 25),
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        child: Text(AppLocalizations.of(context)!.autism),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
