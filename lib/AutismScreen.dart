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
                'ما هو طيف التوحد؟',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'طيف التوحد هو اضطراب نمائي يؤثر على كيفية تواصل الشخص وتفاعله مع الآخرين. يختلف من طفل لآخر في درجة وشدة الأعراض. يمكن أن يكون التوحد خفيفًا أو شديدًا، ويتميز الأطفال المصابون به بأنماط سلوكية متكررة وصعوبة في التواصل الاجتماعي. لكن كل طفل فريد بطريقته الخاصة.',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),

              // Expandable Sections for Different Topics
              ExpansionTile(
                title: Text(
                  'أنواع طيف التوحد',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                children: [
                  Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(
                        '1. التوحد الكلاسيكي',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('التوحد الكلاسيكي هو الشكل الأكثر شيوعًا من اضطراب طيف التوحد. يتسم بوجود تحديات واضحة في التواصل الاجتماعي، صعوبات في فهم العواطف أو تعبيرها، وسلوكيات متكررة.'),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(
                        '2. متلازمة أسبرجر',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('متلازمة أسبرجر هي نوع من أنواع طيف التوحد، حيث لا يكون هناك تأخر في تطور اللغة أو الذكاء، لكن الطفل يواجه صعوبة في فهم تلميحات التواصل الاجتماعي.'),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(
                        '3. اضطراب النمو الشامل غير المحدد (PDD-NOS)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('اضطراب النمو الشامل غير المحدد يشمل الأطفال الذين يظهرون بعض أعراض التوحد، لكن ليس لديهم جميع الأعراض المحددة للتوحد الكلاسيكي أو متلازمة أسبرجر. يمكن أن تظهر لديهم صعوبة في التواصل أو التفاعل الاجتماعي.'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Risk Factors
              ExpansionTile(
                title: Text(
                  'من هو الأكثر عرضة للإصابة بطيف التوحد؟',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                children: [
                  ListTile(
                    title: Text('• الأطفال الذكور: هم أكثر عرضة للإصابة من الإناث.'),
                  ),
                  ListTile(
                    title: Text('• التاريخ العائلي: وجود إصابة سابقة في العائلة يمكن أن يزيد من احتمالية الإصابة.'),
                  ),
                  ListTile(
                    title: Text('• العوامل الجينية والبيئية: مثل تعرض الأم لعدوى أو مواد كيميائية أثناء الحمل.'),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Age Range for Autism Symptoms
              ExpansionTile(
                title: Text(
                  'الأعمار التي يظهر فيها طيف التوحد',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                children: [
                  ListTile(
                    title: Text('• تبدأ الأعراض في الغالب بالظهور بين عمر 18 شهرًا و3 سنوات.'),
                  ),
                  ListTile(
                    title: Text('• قد تظهر العلامات المبكرة مثل تأخر الكلام أو صعوبة التفاعل الاجتماعي، مما يساعد في التشخيص المبكر.'),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Tips for Dealing with Autism
              ExpansionTile(
                title: Text(
                  'كيفية التعامل مع طفل مصاب بطيف التوحد',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                children: [
                  ListTile(
                    title: Text('1. التواصل بطرق مختلفة: استخدام أساليب بسيطة ومباشرة، مع استخدام الصور والإشارات لتسهيل التفاعل. منح الطفل وقتًا كافيًا للتعبير عن نفسه.'),
                  ),
                  ListTile(
                    title: Text('2. الروتين: تأكد من وجود روتين يومي ثابت يساعد الطفل على الشعور بالأمان. أبلغ الطفل مسبقًا بأي تغييرات في الجدول لضمان استقرار الحالة النفسية.'),
                  ),
                  ListTile(
                    title: Text('3. الدعم النفسي: التحلي بالصبر والتفهم، وتشجيع الطفل على التعبير عن مشاعره وأفكاره. توفير بيئة دافئة ومحبة تدعم نموه الاجتماعي.'),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Treatment and Management
              ExpansionTile(
                title: Text(
                  'العلاج وإدارة الحالة',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                children: [
                  ListTile(
                    title: Text('• العلاج السلوكي: يركز على تعزيز المهارات الاجتماعية وتقليل السلوكيات غير المرغوب فيها، مثل تكرار الأفعال أو العزلة.'),
                  ),
                  ListTile(
                    title: Text('• العلاج الوظيفي: يساعد الطفل على تطوير مهارات الحياة اليومية مثل الأكل، اللبس، واستخدام المرحاض.'),
                  ),
                  ListTile(
                    title: Text('• العلاج النفسي: يعمل على تحسين المهارات الاجتماعية، والتخفيف من القلق المرتبط بالتوحد.'),
                  ),
                  ListTile(
                    title: Text('• العلاج الدوائي: يُستخدم لتقليل أعراض مثل القلق أو فرط الحركة، مع إشراف طبي.'),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // When to visit the doctor
              ExpansionTile(
                title: Text(
                  'متى يجب زيارة الطبيب؟',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                children: [
                  ListTile(
                    title: Text('• تأخر في التطور: إذا لاحظت تأخرًا في مهارات الطفل اللغوية أو الاجتماعية.'),
                  ),
                  ListTile(
                    title: Text('• صعوبة في التواصل: مثل عدم الاستجابة للأسماء أو الأوامر البسيطة.'),
                  ),
                  ListTile(
                    title: Text('• سلوكيات مفرطة: مثل تكرار حركات أو نوبات غضب شديدة.'),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Features of an Autistic Child
              ExpansionTile(
                title: Text(
                  'ما يميز طفل التوحد؟',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                children: [
                  ListTile(
                    title: Text('• قد يظهر لدى بعض الأطفال مهارات فنية أو رياضية متميزة.'),
                  ),
                  ListTile(
                    title: Text('• طريقة تفكيرهم وإبداعهم يمكن أن تكون فريدة، مما قد يجعلهم يظهرون بمواهب خاصة في مجالات معينة.'),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Tips for Parents
              ExpansionTile(
                title: Text(
                  'نصائح للأهل',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                children: [
                  ListTile(
                    title: Text('1. تقبَّل طفلك كما هو: فهم احتياجاته وتقديم الدعم في كل مرحلة من مراحل نموه.'),
                  ),
                  ListTile(
                    title: Text('2. الانضمام إلى مجموعات دعم: مشاركة التجارب مع الآخرين يمكن أن تكون مفيدة جدًا.'),
                  ),
                  ListTile(
                    title: Text('3. طلب الدعم المهني: التوجه إلى مختصين في التوحد للحصول على استراتيجيات لتحسين مهارات الطفل وتطوره.'),
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
