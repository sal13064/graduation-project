import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:intl/intl.dart';
import 'package:graduation/games.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import your localization

class EmotionsHomePage extends StatefulWidget {
  const EmotionsHomePage({super.key});

  @override
  _EmotionsHomePageState createState() => _EmotionsHomePageState();
}

class _EmotionsHomePageState extends State<EmotionsHomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final FlutterTts _flutterTts = FlutterTts();
  bool isPlayingSound = false;

  int currentStep = 0;
  bool inQuizMode = false;
  int quizIndex = 0;
  int score = 0;

  List<Map<String, dynamic>> steps = [
    {
      "image": "assets/happy.jpg",
      "sound": "assets/sound-effect-baby-laughing-01-237186.mp3",
      "description":
          "This is a happy face. It means feeling joy and being cheerful."
    },
    {
      "image": "assets/sad.jpg",
      "sound": "assets/sound-effect-baby-crying.mp3",
      "description": "This is a sad face. It means feeling upset or unhappy."
    },
    {
      "image": "assets/angry.jpg",
      "sound": "assets/sound-effect-angry.mp3",
      "description":
          "This is an angry face. It means feeling mad or frustrated."
    },
    {
      "image": "assets/surprised.jpg",
      "sound": "assets/sound-effect-surprised.mp3",
      "description":
          "This is a surprised face. It means feeling amazed or shocked."
    },
    {
      "image": "assets/scared.jpg",
      "sound": "assets/sound-effect-scared.mp3",
      "description":
          "This is a scared face. It means feeling afraid of something."
    },
    {
      "image": "assets/screaming_angry.jpg",
      "sound": "assets/sound-effect-screaming-angry.mp3",
      "description": "This is a screaming angry face. It shows being very mad."
    },
    {
      "image": "assets/screaming_scared.jpg",
      "sound": "assets/sound-effect-screaming-scared.mp3",
      "description":
          "This is a screaming scared face. It shows being very afraid."
    },
    {
      "image": "assets/shy.jpg",
      "sound": "assets/sound-effect-shy.mp3",
      "description":
          "This is a shy face. It means feeling a little embarrassed."
    },
    {
      "image": "assets/excited.jpg",
      "sound": "assets/sound-effect-excited.mp3",
      "description":
          "This is an excited face. It means feeling very happy and eager."
    },
    {
      "image": "assets/bored.jpg",
      "sound": "assets/sound-effect-bored.mp3",
      "description":
          "This is a bored face. It means feeling tired of doing nothing fun."
    }
  ];

  final List<Map<String, String>> quiz = [
    {"image": "assets/happy.jpg", "answer": "Happy"},
    {"image": "assets/sad.jpg", "answer": "Sad"},
    {"image": "assets/angry.jpg", "answer": "Angry"},
    {"image": "assets/surprised.jpg", "answer": "Surprised"},
    {"image": "assets/scared.jpg", "answer": "Scared"},
    {"image": "assets/excited.jpg", "answer": "Excited"},
    {"image": "assets/screaming_scared.jpg", "answer": "Confused"},
    {"image": "assets/bored.jpg", "answer": "Bored"},
    {"image": "assets/screaming_angry.jpg", "answer": "Proud"},
    {"image": "assets/shy.jpg", "answer": "Shy"},
  ];
  List shuffledAnswers = [];

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    shuffleAnswers();
    playStepSound();
  }

  Future<void> speakText(String text) async {
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.speak(text);
  }

  Future<void> playSound(String soundPath) async {
    if (isPlayingSound) return;

    setState(() {
      isPlayingSound = true;
    });

    try {
      await _audioPlayer.play(AssetSource(soundPath));
      _audioPlayer.onPlayerComplete.listen((_) {
        setState(() {
          isPlayingSound = false;
        });
      });
    } catch (e) {
      print("Error playing sound: $e");
      setState(() {
        isPlayingSound = false;
      });
    }
  }

  Future<void> playStepSound() async {
    if (!inQuizMode && currentStep < steps.length) {
      String soundPath = steps[currentStep]["sound"];
      await playSound(soundPath);
      speakText(steps[currentStep]['description']);
    }
  }

  Future<void> saveScoreToFirebase(int score) async {
    String formattedTime = DateFormat('d/M/yyyy h:mma').format(DateTime.now());
    String userId = _auth.currentUser?.uid ?? '';

    if (userId.isEmpty) {
      print("User not logged in.");
      return;
    }

    try {
      QuerySnapshot userScores = await _firestore
          .collection('scores')
          .where('userId', isEqualTo: userId)
          .where('gamename', isEqualTo: 'Emotions Game')
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
          'gamename': 'Emotions Game',
          'timestamp': formattedTime,
        });
        print("Score saved successfully!");
      }
    } catch (e) {
      print("Failed to save or update score: $e");
    }
  }

  void shuffleAnswers() {
    List<String> allAnswers = quiz.map((q) => q['answer']!).toList();
    shuffledAnswers = [quiz[quizIndex]['answer']!];
    allAnswers.remove(quiz[quizIndex]['answer']);
    shuffledAnswers.addAll((allAnswers..shuffle()).take(3));
    shuffledAnswers.shuffle();
  }

  String getResultMessage() {
    if (score <= 4) {
      return AppLocalizations.of(context)!.not_bad; // Use localization
    } else if (score <= 7) {
      return AppLocalizations.of(context)!.well_done; // Use localization
    } else {
      return AppLocalizations.of(context)!.excellent; // Use localization
    }
  }

  void nextStep() {
    setState(() {
      if (!inQuizMode) {
        if (currentStep < steps.length - 1) {
          currentStep++;
          playStepSound();
        } else {
          inQuizMode = true;
        }
      } else {
        quizIndex++;
        if (quizIndex < quiz.length) {
          shuffleAnswers();
        }
      }
    });
  }

  void checkAnswer(String answer) {
    bool isCorrect = quiz[quizIndex]['answer'] == answer;
    setState(() {
      if (isCorrect) {
        score++;
        playSound("assets/correct.mp3");
      } else {
        playSound("assets/wrong.wav");
      }
    });

    String resultMessage = isCorrect
        ? AppLocalizations.of(context)!.correct_message // Use localization
        : "${AppLocalizations.of(context)!.correct_message} ${quiz[quizIndex]['answer']}."; // Use localization

    speakText(resultMessage);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isCorrect
              ? AppLocalizations.of(context)!.correct_title
              : AppLocalizations.of(context)!.wrong_title), // Use localization
          content: Text(
            resultMessage,
            style: const TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                nextStep();
              },
              child: const Text("Next"),
            ),
          ],
        );
      },
    );
  }

  void handleQuizEnd() {
    saveScoreToFirebase(score);
    setState(() {
      currentStep = 0;
      inQuizMode = false;
      quizIndex = 0;
      score = 0;
      shuffleAnswers();
      playStepSound();
    });

    speakText(
        "game over Your score: $score / ${quiz.length}"); // Use localization
    speakText(getResultMessage());
  }

  // Skip the training mode and go directly to the quiz
  void skipTraining() {
    setState(() {
      inQuizMode = true;
      quizIndex = 0;
      shuffleAnswers();
      playStepSound();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(AppLocalizations.of(context)!.app_title), // Use localization
        backgroundColor: const Color(0xFFB2A4D4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: !inQuizMode
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    steps[currentStep]['image']!,
                    height: 200,
                    errorBuilder: (context, error, stackTrace) {
                      return const Text(
                        "Image not available",
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    steps[currentStep]['description'], // Use localization
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: nextStep,
                    child: Text(AppLocalizations.of(context)!
                        .next), // Use localization for "Next"
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: skipTraining, // Skip Training Button
                    child: Text(AppLocalizations.of(context)!
                        .skipGame), // Use localization
                  ),
                ],
              )
            : quizIndex < quiz.length
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        quiz[quizIndex]['image']!,
                        height: 200,
                        errorBuilder: (context, error, stackTrace) {
                          return const Text(
                            "Image not available",
                            style: TextStyle(fontSize: 18, color: Colors.red),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: shuffledAnswers.length,
                        itemBuilder: (context, index) {
                          return ElevatedButton(
                            onPressed: () =>
                                checkAnswer(shuffledAnswers[index]),
                            child: Text(shuffledAnswers[index]),
                          );
                        },
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "game over  Your score: $score / ${quiz.length}\n${getResultMessage()}",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: handleQuizEnd,
                        child: Text(AppLocalizations.of(context)!
                            .restart_button), // Use localization
                      ),
                    ],
                  ),
      ),
    );
  }
}
