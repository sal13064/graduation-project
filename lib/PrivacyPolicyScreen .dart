import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy for Spectrum Star App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'At Spectrum Star App, we take your privacy seriously. This policy is designed to clarify how we collect, use, and protect your personal data when using our app. By using our app, you agree to the terms and conditions outlined in this privacy policy.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              '2. Information We Collect',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '2.1 Information Provided by Users\n'
              '- Account Information: such as name, email address, phone number, and password upon registration.\n'
              '- Child Information: such as child’s name, date of birth, and any health information entered.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              '2.2 Information Collected Automatically\n'
              '- Technical Data: such as device type, operating system, and app version.\n'
              '- Usage Logs: such as duration of app usage, features used, and activity logs.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              '2.3 Additional Information\n'
              '- Images: uploaded for analysis using AI to provide preliminary diagnoses.\n'
              '- Geographic Location: used to identify nearby autism centers.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              '3. How We Use the Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '3.1 Enhancing the Experience\n'
              '- Providing preliminary diagnostic services.\n'
              '- Offering personalized recommendations and practical advice.\n'
              '- Displaying nearby autism centers based on location.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              '3.2 Development and Improvement\n'
              '- Improving AI algorithms.\n'
              '- Analyzing usage data to develop features.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              '4. Sharing Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '4.1 Third Parties\n'
              '- Service Providers: such as cloud services or data analytics.\n'
              '- Autism Centers: if you request an appointment or share a report.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              '4.2 Legal Compliance\n'
              '- We share information with authorities if legally required.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              '5. Data Protection',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '- We use encryption technologies (SSL) to protect data transmission.\n'
              '- Information is stored on secure servers that follow industry best practices.\n'
              '- Access to sensitive information is restricted.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              '6. Users\' Rights',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '- You can access the data we have collected.\n'
              '- You can correct or update your personal information.\n'
              '- You can request the deletion of your data at any time.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              '7. Data Retention',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '- We retain information as long as necessary to provide services.\n'
              '- Data is deleted upon user request or when the service is discontinued.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              '8. Children\'s Policy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '- We are committed to protecting children\'s privacy.\n'
              '- Parents or guardians must provide relevant information about children.\n'
              '- Data is used only to enhance the child\'s experience and provide preliminary diagnoses.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              '9. Changes to the Privacy Policy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'We may update the privacy policy from time to time. Users will be notified of any significant changes through the app.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              '10. Contact Us',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'If you have any questions about the privacy policy, you can contact us via:\n'
              '- Email: support@spectrumstar.com\n'
              '- Phone: +966-XXX-XXXXXX',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'By using the app, you agree to the terms outlined above. We are committed to protecting your personal data and ensuring it is used transparently and responsibly.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
