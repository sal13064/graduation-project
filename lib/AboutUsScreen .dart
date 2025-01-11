import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Spectrum Star!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'We are here to be your partner in supporting your child with autism spectrum disorder. Through our easy and fun tools, we help you discover new ways to understand your child’s needs and develop their skills. Start your journey now, because every step makes a difference!',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'Services Offered by the App',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '1. Preliminary Diagnosis Using AI:\n'
              '- Upload pictures of your child to analyze their behaviors and provide a preliminary report to help you understand their condition.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              '2. Fun Educational Games:\n'
              '- Games designed to motivate your child to develop their social and educational skills.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              '3. Useful Information:\n'
              '- Practical guidelines to help you manage your child and improve their quality of life.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              '4. Find Nearby Autism Centers:\n'
              '- Location services to facilitate access to specialized centers near you.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'Start using the app now to experience our innovative tools designed to make your family’s life easier and more supportive.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
