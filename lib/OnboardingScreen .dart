import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          _buildOnboardingPage(
            title: "مرحبًا بك في Spectrum Star!",
            description:
                "نحن هنا لنكون شريكك في رحلة دعم طفلك المصاب بطيف التوحد.",
          ),
          _buildOnboardingPage(
            title: "أدواتنا سهلة وممتعة",
            description:
                "من خلال أدواتنا السهلة والممتعة، نساعدك على اكتشاف طرق جديدة لفهم احتياجات طفلك وتطوير مهاراته.",
          ),
          _buildOnboardingPage(
            title: "ابدأ رحلتك الآن!",
            description: "ابدأ رحلتك الآن، لأن كل خطوة تُحدث فرقًا!",
            showStartButton: true,
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage({
    required String title,
    required String description,
    bool showStartButton = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: const TextStyle(fontSize: 18, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
          if (showStartButton)
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB2A4D4), // Button color
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Navigate to the home screen or the main app flow
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: const Text(
                  'ابدأ الآن',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
