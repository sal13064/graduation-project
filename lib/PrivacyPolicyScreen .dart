import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('سياسة الخصوصية'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'سياسة الخصوصية لتطبيق Spectrum Star',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'نحن في تطبيق Spectrum Star نأخذ خصوصيتك على محمل الجد. تم تصميم هذه السياسة لتوضيح كيفية جمع واستخدام وحماية بياناتك الشخصية عند استخدامك لتطبيقنا. باستخدامك لتطبيقنا، فإنك توافق على الشروط والأحكام الواردة في سياسة الخصوصية هذه.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              '2. المعلومات التي نجمعها',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '2.1 المعلومات التي يقدمها المستخدمون\n'
              '- معلومات الحساب: مثل الاسم، عنوان البريد الإلكتروني، رقم الهاتف، وكلمة المرور عند التسجيل.\n'
              '- معلومات الطفل: مثل اسم الطفل، تاريخ الميلاد، وأي معلومات صحية يتم إدخالها.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              '2.2 المعلومات التي يتم جمعها تلقائيًا\n'
              '- البيانات التقنية: مثل نوع الجهاز، نظام التشغيل، وإصدار التطبيق.\n'
              '- سجل الاستخدام: مثل مدة استخدام التطبيق، المميزات المستخدمة، وسجل الأنشطة.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              '2.3 معلومات إضافية\n'
              '- الصور: يتم تحميل الصور لتحليلها باستخدام الذكاء الاصطناعي لتقديم تشخيص أولي.\n'
              '- الموقع الجغرافي: يتم استخدامه لتحديد مراكز التوحد القريبة منك.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              '3. كيفية استخدام المعلومات',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '3.1 تحسين التجربة\n'
              '- تقديم خدمات التشخيص الأولي.\n'
              '- توفير توصيات مخصصة ونصائح عملية.\n'
              '- عرض مراكز التوحد القريبة بناءً على الموقع.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              '3.2 التطوير والتحسين\n'
              '- تحسين خوارزميات الذكاء الاصطناعي.\n'
              '- تحليل بيانات الاستخدام لتطوير الميزات.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              '4. مشاركة المعلومات',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '4.1 الأطراف الثالثة\n'
              '- مزودي الخدمات: مثل خدمات السحابة أو تحليلات البيانات.\n'
              '- مراكز التوحد: إذا طلبت تحديد موعد أو مشاركة تقرير.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              '4.2 الالتزام القانوني\n'
              '- نشارك المعلومات مع السلطات إذا كان ذلك مطلوبًا قانونيًا.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              '5. حماية البيانات',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '- نستخدم تقنيات التشفير (SSL) لحماية نقل البيانات.\n'
              '- يتم تخزين المعلومات في خوادم آمنة تتبع أفضل الممارسات في الصناعة.\n'
              '- يتم تقييد الوصول إلى المعلومات الحساسة.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              '6. حقوق المستخدمين',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '- يمكنك الوصول إلى البيانات التي قمنا بجمعها.\n'
              '- يمكنك تصحيح أو تحديث معلوماتك الشخصية.\n'
              '- يمكنك طلب حذف بياناتك في أي وقت.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              '7. الاحتفاظ بالبيانات',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '- نحتفظ بالمعلومات طالما كانت ضرورية لتقديم الخدمات.\n'
              '- يتم حذف البيانات عند طلب المستخدم أو عند توقف الخدمة.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              '8. سياسة الأطفال',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '- نحن ملتزمون بحماية خصوصية الأطفال.\n'
              '- يجب على الوالدين أو الأوصياء تقديم المعلومات ذات الصلة بالأطفال.\n'
              '- يتم استخدام البيانات فقط لتحسين تجربة الطفل وتقديم التشخيصات الأولية.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              '9. التعديلات على سياسة الخصوصية',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'قد نقوم بتحديث سياسة الخصوصية من وقت لآخر. سيتم إشعار المستخدمين بأي تغييرات مهمة من خلال التطبيق.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              '10. الاتصال بنا',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'إذا كان لديك أي أسئلة حول سياسة الخصوصية، يمكنك الاتصال بنا عبر:\n'
              '- البريد الإلكتروني: support@spectrumstar.com\n'
              '- رقم الهاتف: +966-XXX-XXXXXX',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'باستخدامك للتطبيق، فإنك توافق على الشروط الواردة أعلاه. نلتزم بحماية بياناتك الشخصية وضمان استخدامها بطريقة شفافة ومسؤولة.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
