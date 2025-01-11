import 'package:flutter/material.dart';

class AutismScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Autism Spectrum Disorder'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Introductory Text
              Text(
                'What is Autism Spectrum Disorder?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Autism Spectrum Disorder (ASD) is a developmental disorder that affects how a person communicates and interacts with others. The degree and severity of symptoms vary from one child to another. Autism can range from mild to severe, characterized by repetitive behaviors and difficulties in social communication. However, every child is unique in their own way.',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),

              // Expandable Sections for Different Topics
              ExpansionTile(
                title: Text(
                  'Types of Autism Spectrum Disorder',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                children: [
                  Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(
                        '1. Classic Autism',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Classic autism is the most common form of ASD. It is characterized by noticeable challenges in social communication, difficulties understanding or expressing emotions, and repetitive behaviors.',
                      ),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(
                        '2. Asperger Syndrome',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Asperger syndrome is a type of ASD where there is no delay in language or intelligence development, but the child struggles with understanding social cues.',
                      ),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(
                        '3. Pervasive Developmental Disorder-Not Otherwise Specified (PDD-NOS)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'PDD-NOS includes children who exhibit some autism symptoms but do not fully meet the criteria for classic autism or Asperger syndrome. These children may have challenges in communication or social interaction.',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Risk Factors
              ExpansionTile(
                title: Text(
                  'Who is at Risk of Autism?',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                children: [
                  ListTile(
                    title: Text(
                        '• Boys: They are more likely to develop autism than girls.'),
                  ),
                  ListTile(
                    title: Text(
                      '• Family History: A history of autism in the family increases the risk.',
                    ),
                  ),
                  ListTile(
                    title: Text(
                      '• Genetic and Environmental Factors: Such as maternal infections or exposure to chemicals during pregnancy.',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Age Range for Autism Symptoms
              ExpansionTile(
                title: Text(
                  'Age of Autism Onset',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                children: [
                  ListTile(
                    title: Text(
                      '• Symptoms often appear between 18 months and 3 years of age.',
                    ),
                  ),
                  ListTile(
                    title: Text(
                      '• Early signs like delayed speech or difficulty in social interaction can aid in early diagnosis.',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Tips for Dealing with Autism
              ExpansionTile(
                title: Text(
                  'How to Support a Child with Autism',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                children: [
                  ListTile(
                    title: Text(
                      '1. Communicate in simple, direct ways using pictures or gestures to make interaction easier. Give the child enough time to express themselves.',
                    ),
                  ),
                  ListTile(
                    title: Text(
                      '2. Establish Routines: Ensure a consistent daily routine to provide the child with a sense of security. Notify them of any schedule changes in advance to maintain stability.',
                    ),
                  ),
                  ListTile(
                    title: Text(
                      '3. Provide Emotional Support: Be patient and understanding, encouraging the child to express their feelings and thoughts in a warm, supportive environment.',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Treatment and Management
              ExpansionTile(
                title: Text(
                  'Treatment and Management',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                children: [
                  ListTile(
                    title: Text(
                      '• Behavioral Therapy: Focuses on improving social skills and reducing unwanted behaviors like repetitive actions or isolation.',
                    ),
                  ),
                  ListTile(
                    title: Text(
                      '• Occupational Therapy: Helps the child develop daily life skills such as eating, dressing, and using the toilet.',
                    ),
                  ),
                  ListTile(
                    title: Text(
                      '• Psychological Therapy: Works to improve social skills and alleviate autism-related anxiety.',
                    ),
                  ),
                  ListTile(
                    title: Text(
                      '• Medication: Used to manage symptoms like anxiety or hyperactivity, under medical supervision.',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // When to Visit the Doctor
              ExpansionTile(
                title: Text(
                  'When to Consult a Doctor?',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                children: [
                  ListTile(
                    title: Text(
                      '• Delayed Development: If there are delays in language or social skills.',
                    ),
                  ),
                  ListTile(
                    title: Text(
                      '• Difficulty Communicating: Such as not responding to names or simple commands.',
                    ),
                  ),
                  ListTile(
                    title: Text(
                      '• Excessive Behaviors: Like repetitive movements or severe tantrums.',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Features of an Autistic Child
              ExpansionTile(
                title: Text(
                  'What Makes a Child with Autism Unique?',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                children: [
                  ListTile(
                    title: Text(
                      '• Some children may display exceptional artistic or athletic abilities.',
                    ),
                  ),
                  ListTile(
                    title: Text(
                      '• Their unique way of thinking and creativity can make them stand out with special talents in specific areas.',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Tips for Parents
              ExpansionTile(
                title: Text(
                  'Tips for Parents',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                children: [
                  ListTile(
                    title: Text(
                      '1. Accept your child as they are: Understand their needs and provide support at every stage of their development.',
                    ),
                  ),
                  ListTile(
                    title: Text(
                      '2. Join Support Groups: Sharing experiences with others can be very helpful.',
                    ),
                  ),
                  ListTile(
                    title: Text(
                      '3. Seek Professional Help: Reach out to autism specialists to get strategies for improving the child’s skills and development.',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
