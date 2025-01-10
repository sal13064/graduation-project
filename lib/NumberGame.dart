import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import your localization

class NumberGame extends StatefulWidget {
  const NumberGame({super.key});

  @override
  _NumberGameState createState() => _NumberGameState();
}

class _NumberGameState extends State<NumberGame> {
  final FlutterTts _flutterTts = FlutterTts();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int currentNumberIndex = 0;
  int score = 0;
  bool isTraining = true;

  @override
  void initState() {
    super.initState();
    if (isTraining) {
      speakText("Welcome to training mode. Let's learn the numbers!");
    }
  }

  void speakText(String text) async {
    await _flutterTts.setLanguage('en');
    await _flutterTts.speak(text);
  }

  void checkAnswer(int answer) {
    bool isCorrect = numbers[currentNumberIndex] == answer;
    setState(() {
      if (isCorrect) score++;
      if (currentNumberIndex < numbers.length - 1) {
        showFeedbackDialog(isCorrect);
      } else {
        showGameOverDialog();
      }
    });
  }

  void showFeedbackDialog(bool isCorrect) {
    String feedback = isCorrect
        ? AppLocalizations.of(context)!.correct
        : AppLocalizations.of(context)!.incorrect;
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
                  currentNumberIndex++;
                });
                speakText(
                    "${AppLocalizations.of(context)!.nextnumberis} ${numbers[currentNumberIndex]}");
              },
              child: Text(AppLocalizations.of(context)!.next),
            ),
          ],
        );
      },
    );
  }

  void showGameOverDialog() {
    String gameOverText =
        "${AppLocalizations.of(context)!.your_score} $score / ${numbers.length}";
    speakText(AppLocalizations.of(context)!.game_over);
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
    String userId = _auth.currentUser?.uid ?? '';

    if (userId.isEmpty) {
      return;
    }

    try {
      QuerySnapshot userScores = await _firestore
          .collection('scores')
          .where('userId', isEqualTo: userId)
          .where('gamename', isEqualTo: 'Number Game')
          .get();

      if (userScores.docs.isNotEmpty) {
        DocumentReference scoreDocRef = userScores.docs[0].reference;
        await scoreDocRef.update({
          'score': score,
          'timestamp': formattedTime,
        });
      } else {
        await _firestore.collection('scores').add({
          'score': score,
          "userId": userId,
          'gamename': 'Number Game',
          'timestamp': formattedTime,
        });
      }
    } catch (e) {
      // Handle exceptions
    }
  }

  void resetGame() {
    setState(() {
      currentNumberIndex = 0;
      score = 0;
      isTraining = true;
      speakText("Welcome back to training mode. Let's learn the numbers!");
    });
  }

  void skipGame() {
    setState(() {
      isTraining = false;
      speakText("Skipping training mode. Let's start the game!");
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
                  AppLocalizations.of(context)!.learnthenumbers,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2,
                  ),
                  itemCount: numbers.length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      onPressed: () {
                        speakText(numbers[index].toString());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(numbers[index].toString()),
                          SizedBox(
                            width: 20,
                          ),
                          Text(_numberToWords(numbers[index])),
                        ],
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
                          "Game starts now! First number is ${numbers[0]}");
                    });
                  },
                  child: Text(AppLocalizations.of(context)!.startGame),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: skipGame, // Skip Game Button
                  child: Text(AppLocalizations.of(context)!.skipGame),
                ),
              ],
            ),
          ),
        ),
      );
    }

    int currentNumber = numbers[currentNumberIndex];
    String numberAsText =
        _numberToWords(currentNumber); // Convert number to text

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.numberga),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "What is the number?",
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              Text(
                numberAsText, // Display the number in text format
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 2,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  int option = (currentNumber + index - 1) % 10 + 1;
                  return ElevatedButton(
                    onPressed: () => checkAnswer(option),
                    child: Text(option.toString()),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  String _numberToWords(int number) {
    const List<String> units = [
      "",
      "one",
      "two",
      "three",
      "four",
      "five",
      "six",
      "seven",
      "eight",
      "nine",
      "ten"
    ];
    return units[number];
  }
}
