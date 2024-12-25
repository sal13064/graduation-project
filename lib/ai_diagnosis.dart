import 'package:flutter/material.dart';

class AiDiagnosisPage extends StatefulWidget {
  const AiDiagnosisPage({Key? key}) : super(key: key);

  @override
  _AIDiagnosisPageState createState() => _AIDiagnosisPageState();
}

class _AIDiagnosisPageState extends State<AiDiagnosisPage> {
  final List<Map<String, dynamic>> surveyQuestions = [
    {
      'question': 'How does your child communicate?',
      'options': ['Uses basic language', 'Uses advanced language', 'Non-verbal'],
    },
    {
      'question': 'How would you rate your child’s ability to engage?',
      'options': ['Very good', 'Good', 'Fair'],
    },
    {
      'question': 'Do you observe any unusual speech patterns?',
      'options': ['Yes', 'No'],
    },
    {
      'question': 'How does your child interact with peers?',
      'options': ['No issues', 'Somewhat social', 'Avoidant', 'No response'],
    },
  ];

  int currentQuestionIndex = 0;
  Map<int, List<String>> selectedAnswers = {}; // To store selected answers

  void moveToNextQuestion(BuildContext context) {
    if (currentQuestionIndex == surveyQuestions.length - 1) {
      _showInstructionsDialog(context);
    } else {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  void _showInstructionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Instructions for Recording Videos'),
          content: const Text(
            '1. Ensure good lighting when recording.\n'
                '2. Focus on the child’s face and movements.\n'
                '3. Keep the child engaged during the recording.\n'
                '4. Ensure that the audio is clear.\n',
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UploadPage()),
                );
              },
              child: const Text('I understand'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Diagnosis'),
        backgroundColor: const Color(0xFFB2A4D4),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                surveyQuestions[currentQuestionIndex]['question'],
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              for (var option in surveyQuestions[currentQuestionIndex]['options'])
                CheckboxListTile(
                  title: Text(option),
                  value: selectedAnswers[currentQuestionIndex]?.contains(option) ?? false,
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        selectedAnswers.putIfAbsent(currentQuestionIndex, () => []).add(option);
                      } else {
                        selectedAnswers[currentQuestionIndex]?.remove(option);
                      }
                    });
                  },
                ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: selectedAnswers.containsKey(currentQuestionIndex) && selectedAnswers[currentQuestionIndex]!.isNotEmpty
                    ? () => moveToNextQuestion(context)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB2A4D4),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UploadPage extends StatelessWidget {
  const UploadPage({Key? key}) : super(key: key);

  void _showVideoInstructions(BuildContext context, String title, String instructions) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(
            instructions,
            style: const TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('I Understand'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Videos'),
        backgroundColor: const Color(0xFFB2A4D4),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Please upload the recorded videos:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  _showVideoInstructions(
                    context,
                    'Child Playing Instructions',
                    'Record the child while playing with toys or objects. Ensure the child is engaged and interacting naturally. Record from a distance that captures their face and body movements clearly.',
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB2A4D4),
                  fixedSize: const Size(200, 50),
                ),
                child: const Text('Child Playing'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _showVideoInstructions(
                    context,
                    'Child Watching TV Instructions',
                    'Record the child while watching TV. Ensure their facial expressions and reactions to the screen are clearly visible. Avoid background noise as much as possible.',
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB2A4D4),
                  fixedSize: const Size(200, 50),
                ),
                child: const Text('Child Watching TV'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _showVideoInstructions(
                    context,
                    'Child Communicating Instructions',
                    'Record the child while communicating with others. This could include speaking, using gestures, or any other form of interaction. Ensure the child’s face and hands are clearly visible.',
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB2A4D4),
                  fixedSize: const Size(200, 50),
                ),
                child: const Text('Child Communicating'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
