import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('من نحن؟'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'في Spectrum Star!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'نحن هنا لنكون شريكك في رحلة دعم طفلك المصاب بطيف التوحد. من خلال أدواتنا السهلة والممتعة، نساعدك على اكتشاف طرق جديدة لفهم احتياجات طفلك وتطوير مهاراته. ابدأ رحلتك الآن، لأن كل خطوة تُحدث فرقًا!',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'الخدمات التي يقدمها التطبيق',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '1. تشخيص أولي باستخدام الذكاء الاصطناعي:\n'
              '- رفع صور لطفلك لتحليل سلوكياته وتقديم تقرير أولي يساعدك على فهم حالته.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              '2. ألعاب تعليمية ممتعة:\n'
              '- ألعاب مصممة لتحفيز طفلك على تطوير مهاراته الاجتماعية وتعليمية.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              '3. معلومة مفيدة:\n'
              '- إرشادات عملية تساعدك في التعامل مع طفلك وتحسين جودة حياته.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              '4. البحث عن مراكز التوحد القريبة:\n'
              '- خدمة تحديد المواقع لتسهيل الوصول إلى مراكز متخصصة بالقرب منك.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'ابدأ استخدام التطبيق الآن لتجربة أدواتنا المبتكرة التي صُممت لجعل حياة عائلتك أسهل وأكثر دعمًا.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}