import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import your localization

class SocialSkillsGame extends StatefulWidget {
  const SocialSkillsGame({Key? key}) : super(key: key);

  @override
  _SocialSkillsGameState createState() => _SocialSkillsGameState();
}

class _SocialSkillsGameState extends State<SocialSkillsGame> {
  int currentScenarioIndex = 0;
  int score = 0;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlayingSound = false;
  bool gameEnded = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<Map<String, dynamic>> scenarios = [
    {
      "question": "كيف ستقول مرحبا؟",
      "options": [
        {"image": "assets/hello.jpg", "isCorrect": true},
        {"image": "assets/ignore.jpg", "isCorrect": false},
      ],
    },
    {
      "question": "كيف ستطلب المساعدة؟",
      "options": [
        {"image": "assets/ask.jpg", "isCorrect": true},
        {"image": "assets/askshy.jpg", "isCorrect": false},
      ],
    },
    {
      "question": "ماذا ستفعل إذا رأيت لعبة مع صديقك؟",
      "options": [
        {"image": "assets/ask_share.png", "isCorrect": true},
        {"image": "assets/take_force.png", "isCorrect": false},
      ],
    },
  ];

  void playSound(String soundPath, VoidCallback onComplete) async {
    if (isPlayingSound) return;

    setState(() {
      isPlayingSound = true;
    });

    try {
      await _audioPlayer.setSource(AssetSource(soundPath));
      await _audioPlayer.resume();

      _audioPlayer.onPlayerComplete.listen((_) {
        onComplete();
        setState(() {
          isPlayingSound = false;
        });
      });
    } catch (e) {
      print("Error playing sound: $e");
      setState(() {
        isPlayingSound = false;
      });
      onComplete();
    }
  }

  void checkAnswer(bool isCorrect) {
    if (isCorrect) {
      score++;
      playSound('correct.mp3', nextScenario);
    } else {
      playSound('wrong.wav', nextScenario);
    }
  }

  void nextScenario() {
    if (currentScenarioIndex < scenarios.length - 1) {
      setState(() {
        currentScenarioIndex++;
      });
    } else if (!gameEnded) {
      gameEnded = true;
      showEndDialog();
    }
  }

  void showEndDialog() {
    saveScoreToFirebase(score); // Save the score to Firebase
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.game_over),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${score}/${scenarios.length}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              _calculatePerformance(score, scenarios.length),
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                currentScenarioIndex = 0;
                score = 0;
                gameEnded = false;
              });
            },
            child: Text(AppLocalizations.of(context)!.play_again),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)!.exit_game),
          ),
        ],
      ),
    );
  }

  String _calculatePerformance(int score, int total) {
    double percentage = (score / total) * 100;
    if (percentage >= 80) {
      return AppLocalizations.of(context)!.awesome; // Use localization
    } else if (percentage >= 50) {
      return AppLocalizations.of(context)!.very_good; // Use localization
    } else {
      return AppLocalizations.of(context)!.try_again; // Use localization
    }
  }

  Future<void> saveScoreToFirebase(int score) async {
    String formattedTime = DateFormat('d/M/yyyy h:mma').format(DateTime.now());
    String userId = _auth.currentUser?.uid ?? ''; // Ensure userId is not null

    if (userId.isEmpty) {
      print("User not logged in.");
      return; // Prevent further actions if the user is not logged in
    }

    try {
      QuerySnapshot userScores = await _firestore
          .collection('scores')
          .where('userId', isEqualTo: userId)
          .where('gamename', isEqualTo: 'Social Skills Game')
          .get();

      if (userScores.docs.isNotEmpty) {
        DocumentReference scoreDocRef = userScores.docs[0].reference;
        await scoreDocRef.update({
          'score': score,
          'timestamp': formattedTime,
        });
        print("Score updated successfully!");
      } else {
        await _firestore.collection('scores').add({
          'score': score,
          "userId": userId,
          'gamename': 'Social Skills Game',
          'timestamp': formattedTime,
        });
        print("Score saved successfully!");
      }
    } catch (e) {
      print("Failed to save or update score: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final scenario = scenarios[currentScenarioIndex];

    return Scaffold(
      appBar: AppBar(
        title:
            Text(AppLocalizations.of(context)!.app_title4), // Use localization
        backgroundColor: const Color(0xFFB2A4D4),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  scenario['question'],
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 20,
                  runSpacing: 10,
                  children: scenario['options'].map<Widget>((option) {
                    return GestureDetector(
                      onTap: () => checkAnswer(option['isCorrect']),
                      child: Image.asset(
                        option['image'],
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Text(
                  score.toString(), // Use localization
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
