import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:graduation/ColorGame.dart';
import 'package:graduation/NumberGame.dart';
import 'package:graduation/contentview.dart';
import 'package:graduation/emotions_game.dart';
import 'package:graduation/social_skills_game.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({super.key, required this.changeLanguage});
  final Function(Locale) changeLanguage;

  @override
  _GamesPageState createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to fetch scores from Firestore
  Future<List<Map<String, dynamic>>> fetchScores() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('scores').get();
      return snapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
    } catch (e) {
      print("Error fetching scores: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.app_title2),
        backgroundColor: const Color(0xFFB2A4D4),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ContentView(changeLanguage: widget.changeLanguage)),
              (route) => false,
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildGameButton(
                    context,
                    AppLocalizations.of(context)!.emotions_game_button,
                    EmotionsHomePage()),
                _buildGameButton(
                    context,
                    AppLocalizations.of(context)!.social_skills_game_button,
                    SocialSkillsGame()),
                _buildGameButton(
                    context,
                    AppLocalizations.of(context)!.number_game_button,
                    NumberGame()),
                _buildGameButton(
                    context,
                    AppLocalizations.of(context)!.color_game_button,
                    ColorGame()),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: fetchScores(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                        child: Text(
                            AppLocalizations.of(context)!.no_scores_available));
                  } else {
                    List<Map<String, dynamic>> scores = snapshot.data!;
                    return ListView.builder(
                      itemCount: scores.length,
                      itemBuilder: (context, index) {
                        var score = scores[index];
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${AppLocalizations.of(context)!.score_label}: ${score['score']}",
                                    style: TextStyle(fontSize: 16)),
                                Text(
                                    "${AppLocalizations.of(context)!.name_label}: ${score['gamename']}",
                                    style: TextStyle(fontSize: 16)),
                                Text(
                                    "${AppLocalizations.of(context)!.date_label}: ${score['timestamp']}",
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameButton(BuildContext context, String label, Widget gamePage) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => gamePage));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFB2A4D4),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      ),
      child: Text(label, textAlign: TextAlign.center),
    );
  }
}
