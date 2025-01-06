import 'package:flutter/material.dart';

class NumberColorGame extends StatelessWidget {
  const NumberColorGame({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NumberColorHomePage(),
    );
  }
}

class NumberColorHomePage extends StatefulWidget {
  const NumberColorHomePage({super.key});

  @override
  _NumberColorHomePageState createState() => _NumberColorHomePageState();
}

class _NumberColorHomePageState extends State<NumberColorHomePage> {
  List<Map<String, dynamic>> challenges = [
    {
      "number": 3,
      "color": Colors.red,
      "correct": "Red",
      "options": ["Red", "Blue", "Green", "Yellow"]
    },
    {
      "number": 5,
      "color": Colors.blue,
      "correct": "Blue",
      "options": ["Blue", "Green", "Yellow", "Red"]
    },
    {
      "number": 2,
      "color": Colors.green,
      "correct": "Green",
      "options": ["Green", "Red", "Blue", "Yellow"]
    },
    {
      "number": 4,
      "color": Colors.yellow,
      "correct": "Yellow",
      "options": ["Yellow", "Blue", "Green", "Red"]
    },
  ];

  int currentChallengeIndex = 0;
  int score = 0;

  void checkAnswer(String answer) {
    bool isCorrect = challenges[currentChallengeIndex]["correct"] == answer;
    setState(() {
      if (isCorrect) score++;
      if (currentChallengeIndex < challenges.length - 1) {
        showFeedbackDialog(isCorrect);
      } else {
        showGameOverDialog();
      }
    });
  }

  void showFeedbackDialog(bool isCorrect) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isCorrect ? "Correct!" : "Incorrect!"),
          content: Text(isCorrect
              ? "Great job! Move on to the next challenge."
              : "Oops! The correct answer was ${challenges[currentChallengeIndex]['correct']}."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  currentChallengeIndex++;
                });
              },
              child: const Text("Next"),
            ),
          ],
        );
      },
    );
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Game Over"),
          content: Text("Your score: $score / ${challenges.length}"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: const Text("Restart"),
            ),
          ],
        );
      },
    );
  }

  void resetGame() {
    setState(() {
      currentChallengeIndex = 0;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> currentChallenge = challenges[currentChallengeIndex];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Number and Color Game"),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Match the number and color to the correct name!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              "Number: ${currentChallenge['number']}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: currentChallenge["color"],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black, width: 2),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 2.5,
                ),
                itemCount: currentChallenge["options"].length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () =>
                        checkAnswer(currentChallenge["options"][index]),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    child: Text(currentChallenge["options"][index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
