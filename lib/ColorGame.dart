import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import your localization

class ColorGame extends StatefulWidget {
  const ColorGame({super.key});

  @override
  _ColorGameState createState() => _ColorGameState();
}

class _ColorGameState extends State<ColorGame> {
  final FlutterTts _flutterTts = FlutterTts();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.teal,
    Colors.brown,
    Colors.grey,
  ];

  List<String> colorNames = [
    "Red",
    "Blue",
    "Green",
    "Yellow",
    "Purple",
    "Orange",
    "Pink",
    "Teal",
    "Brown",
    "Grey",
  ];

  int currentColorIndex = 0;
  int score = 0;

  bool isTraining = true;

  @override
  void initState() {
    super.initState();
    if (isTraining) {
      speakText("Welcome to training mode. Let's learn the colors!");
    }
  }

  void speakText(String text) async {
    await _flutterTts.setLanguage('en');
    await _flutterTts.speak(text);
  }

  void checkAnswer(Color answer) {
    bool isCorrect = colors[currentColorIndex] == answer;
    setState(() {
      if (isCorrect) score++;
      if (currentColorIndex < colors.length - 1) {
        showFeedbackDialog(isCorrect);
      } else {
        showGameOverDialog();
      }
    });
  }

  void showFeedbackDialog(bool isCorrect) {
    String feedback = isCorrect ? "Correct!" : "Incorrect!";
    speakText(feedback);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(feedback),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  currentColorIndex++;
                });
                speakText(
                    "${AppLocalizations.of(context)!.nextcoloris} ${colorNames[currentColorIndex]}");
              },
              child: Text(AppLocalizations.of(context)!.next),
            ),
          ],
        );
      },
    );
  }

  void showGameOverDialog() {
    String gameOverText = "Your score: $score / ${colors.length}";
    speakText("Game Over");
    speakText(gameOverText);

    saveScoreToFirebase(score);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.game_over),
          content: Text(gameOverText),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: Text(AppLocalizations.of(context)!.restart_button),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.back_button),
            ),
          ],
        );
      },
    );
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
          .where('gamename', isEqualTo: 'Color Game')
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
          'gamename': 'Color Game',
          'timestamp': formattedTime,
        });
        print("Score saved successfully!");
      }
    } catch (e) {
      print("Failed to save or update score: $e");
    }
  }

  void resetGame() {
    setState(() {
      currentColorIndex = 0;
      score = 0;
      isTraining = true;
      speakText("Welcome back to training mode. Let's learn the colors!");
    });
  }

  // Skip Training Mode and start the game
  void skipTraining() {
    setState(() {
      isTraining = false;
      speakText(
          "Game starts now! First color is ${colorNames[0]}"); // Start game after skipping
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isTraining) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.trainingMode),
          backgroundColor: Colors.orange,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.learnthecolors,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2,
                  ),
                  itemCount: colors.length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors[index],
                      ),
                      onPressed: () {
                        speakText(colorNames[index]);
                      },
                      child: Text(
                        colorNames[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isTraining = false;
                      speakText(
                          "Game starts now! First color is ${colorNames[0]}");
                    });
                  },
                  child: Text(AppLocalizations.of(context)!.startGame),
                ),
                // Skip Training Button
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: skipTraining, // Skip Training
                  child: Text(AppLocalizations.of(context)!
                      .skipGame), // Use localization
                ),
              ],
            ),
          ),
        ),
      );
    }

    Color currentColor = colors[currentColorIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.colorGame),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "What is the color?",
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  child: Text(
                    colorNames[currentColorIndex],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 2,
                ),
                itemCount: colors.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () => checkAnswer(colors[index]),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors[index],
                    ),
                    child: Text(
                      '',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}



