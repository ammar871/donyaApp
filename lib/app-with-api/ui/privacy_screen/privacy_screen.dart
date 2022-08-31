import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class PrivacyPolicyScreen extends StatefulWidget {
  static String id = "/PrivacyPolicyScreen";
  final int stayus;

  PrivacyPolicyScreen(this.stayus);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.stayus.toString()+"dhjdjd");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title:   Text(
            'privacybar'.tr(),

            style: TextStyle(
              decoration: TextDecoration.underline,
              fontFamily: 'pnuB',
              fontSize: 15,
              color:  Colors.black,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
          leading: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: HtmlWidget(

              widget.stayus== 0 ?kHtmlAr:widget.stayus==2 ?kHtmlAr :kHtmlEn,

              textStyle: TextStyle(fontSize: 14, color:Colors.black),

            ),
          ),
        ));
  }
}


const kHtmlAr ="""
<p>1730967 / V سياسة الخصوصية لتطبيق دنيا
دنيا اعتمدت سياسة الخصوصية هذه  لشرح كيفية قيام وتخزين واستخدام المعلومات التي تم جمعها فيما يتعلق بخدمات دنيا 
 </p>
<p>  
من خلال تثبيت الخدمات أو استخدامها أو التسجيل فيها أو الوصول إليها بأي طريقة أخرى، فإنك توافق على سياسة الخصوصية هذه وتعطي موافقة صريحة ومستنيرة لمعالجة بياناتك الشخصية وفقًا لسياسة الخصوصية هذه. إذا كنت لا توافق على سياسة الخصوصية هذه، فيرجى عدم تثبيت الخدمات أو استخدامها أو التسجيل فيها أو الوصول إليها بأي طريقة أخرى. تحتفظ دنيا بالحق في تعديل سياسة الخصوصية هذه في أوقات معقولة، لذا يرجى مراجعتها بشكل متكرر. إذا قامت بإجراء تغييرات جوهرية أو مهمة على سياسة دنيا الخصوصية هذه، فقد تنشر إشعارًا على تطبيق دنيا Donyawebsite جنبًا إلى جنب مع سياسة الخصوصية المحدثة. إن استمرارك في استخدام الخدمات يعني موافقتك على التغييرات التي تطرأ على سياسة الخصوصية هذه

</p>
<li>البيانات غير الشخصية. 
</li>
<p> 
لأغراض سياسة الخصوصية هذه، تعني "البيانات غير الشخصية" المعلومات التي لا تحدد هويتك بشكل مباشر. تشمل أنواع البيانات غير الشخصية التي قد تجمعها وتستخدمها، على سبيل المثال لا الحصر: خصائص التطبيق، بما في ذلك، على سبيل المثال لا الحصر ، اسم التطبيق واسم الحزمة والرمز المثبت على جهازك. سيتم الكشف عن تسجيل الوصول الخاص بك (بما في ذلك مثل، التوصية) لجميع مستخدمي
يجوز لشركة بتطبيق دنيا استخدام البيانات غير الشخصية التي تم جمعها  والإفصاح عنها لشركاء MoApps والمتعاقدين معها لأغراض تحليل استخدام الخدمات، وخدمة الإعلانات، وإدارة الخدمات وتقديمها، ولتطوير الخدمات وغيرها من خدمات ومنتجاتها.
بيانات شخصية
لأغراض سياسة الخصوصية هذه، تعني "البيانات الشخصية" معلومات التعريف الشخصية التي تحدد هويتك على وجه التحديد كفرد.
المعلومات الشخصية التي تجمعها أوامرك المعلومات التي قدمتها لنا طواعية عندما تقوم بإنشاء حسابك أو تغيير حسابك
معلومة. تتضمن المعلومات معرف google الخاص بك على facebook والاسم والجنس والموقع وأصدقائك على facebook. تقوم أيضًا بتخزين تسجيلات الوصول الخاصة بك ، وإبداءات الإعجاب بدنيا  ، وعدم الإعجاب ، والتوصيات والرسائل.
قد تستخدم البيانات الشخصية المجمعة لأغراض تحليل استخدام دنيا الخدمات، وتوفير الدعم للعملاء والدعم الفني، وإدارة الخدمات وتقديمها (بما في ذلك إدارة خدمة الإعلانات) ولتطوير الخدمات وغيرها من خدمات ومنتجات. قد تجمع دنيا البيانات غير الشخصية والبيانات الشخصية.

يرجى ملاحظة أن بعض ميزات الخدمات قد تكون قادرة على الاتصال بمواقع الشبكات الاجتماعية الخاصة بك للحصول على معلومات إضافية عنك. في مثل هذه الحالات، قد تتمكن من جمع معلومات معينة من ملفك التعريفي لدنيا على الشبكات الاجتماعية عندما يسمح موقع الشبكة الاجتماعية الخاص بك بذلك، وعندما توافق على السماح لموقعك على الشبكة الاجتماعية بإتاحة هذه المعلومات لتطبيقاتي. قد تتضمن هذه المعلومات، على سبيل المثال لا الحصر، اسمك وصورة ملفك الشخصي والجنس ومعرف المستخدم وعنوان البريد الإلكتروني وبلدك لغتك، ومنطقتك الزمنية، والمنظمات والروابط الموجودة على صفحة ملفك الشخصي، والأسماء وصور الملف الشخصي الخاصة بموقع "الأصدقاء" على شبكة التواصل الاجتماعي والمعلومات الأخرى التي قمت بتضمينها في ملف تعريف موقع التواصل الاجتماعي الخاص بك. قد تقوم بربط و / أو دمج واستخدام دنيا ومواقع المعلومات التي تجمعها و / أو الحصول عليها من خلال مواقع دنيا الاجتماعية هذه وفقًا لسياسة الخصوصية هذه.
إفشاء ونقل البيانات الشخصية
تقوم دنيا تقوم بجمع ومعالجة البيانات الشخصية على أساس طوعي وليس في مجال بيع بياناتك الشخصية إلى أطراف ثالثة. ومع ذلك، قد يتم الكشف عن البيانات الشخصية في بعض الأحيان وفقًا للتشريعات المعمول بها وسياسة الخصوصية هذه. بالإضافة إلى ذلك، يجوز لشركة دنيا الكشف عن البيانات الشخصية لشركاتها الأم والشركات التابعة لها وفقًا لسياسة الخصوصية هذه.

قد تقوم دنيا بتوظيف وكلاء ومقاولين لجمع ومعالجة البيانات الشخصية نيابة عن Mo Apps وفي مثل هذه الحالات سيتم توجيه هؤلاء الوكلاء والمقاولين للامتثال لسياسة الخصوصية الخاصة بنا واستخدام البيانات الشخصية فقط للأغراض التي تم إشراك الطرف الثالث من أجلها بواسطة MoApps. لا يجوز لهؤلاء الوكلاء والمقاولين استخدام بياناتك الشخصية لأغراض التسويق الخاصة بهم. قد تستخدم موفري خدمات تابعين لجهات خارجية مثل معالجات بطاقات الائتمان ومقدمي خدمات البريد الإلكتروني ووكلاء الشحن ومحللي البيانات ومقدمي استخبارات الأعمال. يحق لدنيا مشاركة بياناتك الشخصية عند الضرورة للأطراف الثالثة المذكورة أعلاه لتقديم خدماتهم إلى MoApps. دنيا ليست مسؤولة عن أفعال وإغفالات هذه الأطراف الثالثة، باستثناء ما ينص عليه القانون الإلزامي.

عن بياناتك الشخصية لأطراف ثالثة كما هو مطلوب من قبل. 
دنيا قد تكشف عند تطبيق القانون أو غيرهم من المسؤولين الحكوميين فيما يتعلق بالتحقيق في الاحتيال أو انتهاكات الملكية الفكرية أو أي نشاط آخر غير قانوني أو قد يعرضك أنت أو للمسؤولية القانونية. دنيا قد تفصح أيضًا عن بياناتك الشخصية لأطراف ثالثة عندما يكون لدى سبب للاعتقاد بأن الكشف ضروري لمعالجة الإصابة المحتملة أو الفعلية أو التدخل في حقوق MoApps أو ممتلكاتها أو عملياتها أو المستخدمين أو غيرهم ممن قد يتعرضون للأذى أو قد يتعرضون للخسارة أو الضرر، أو يعتقد دنيا أن هذا الكشف ضروري لحماية حقوق دنيا، ومكافحة الاحتيال و / أو الامتثال لإجراء قضائي، أو أمر محكمة، أو إجراء قانوني مقدم على MoApps. إلى الحد الذي يسمح به القانون المعمول به، دنيا تبذل جهودًا معقولة لإعلامك بهذا الكشف من خلال موقع MoApps على الويب أو بطريقة أخرى معقولة.
الضمانات
تتبع معايير الصناعة المقبولة عمومًا وتحافظ على ضمانات معقولة لمحاولة ضمان أمن وسلامة وخصوصية المعلومات الموجودة في حوزة MoApps. فقط الأشخاص الذين يحتاجون إلى معالجة بياناتك الشخصية فيما يتعلق بإنجاز مهامهم وفقًا لأغراض سياسة الخصوصية هذه ولأغراض إجراء الصيانة الفنية، يمكنهم الوصول إلى بياناتك الشخصية الموجودة في حوزة MoApps. يتم تخزين البيانات الشخصية التي يجمعها دنيا في بيئات تشغيل آمنة غير متاحة للجمهور. لمنع الوصول غير المصرح به عبر الإنترنت إلى البيانات الشخصية، تحتفظ دنيا بالبيانات الشخصية خلف خادم محمي بجدار الحماية. و اعتمدت دنيا بسياسة الخصوصية هذه ("سياسة الخصوصية") لشرح كيفية قيام بجمع وتخزين واستخدام المعلومات التي تم جمعها فيما يتعلق بخدمات دنيا. ذلك، لا يمكن أن يكون أي نظام آمنًا بنسبة 100٪ وهناك احتمال أنه على الرغم من الجهود المعقولة التي تبذلها MoApps، فقد يكون هناك وصول غير مصرح به إلى بياناتك الشخصية. باستخدام الخدمات، فإنك تتحمل هذه المخاطر.
آخر
يرجى الانتباه إلى الطبيعة المفتوحة لبعض الشبكات الاجتماعية وغيرها من الميزات المفتوحة للخدمات التي قد توفرها لك. يمكنك اختيار الكشف عن بيانات عنك في سياق المساهمة بالمحتوى الذي ينشئه المستخدم في الخدمات. أي بيانات تكشف عنها في أي من هذه المنتديات أو المدونات أو الدردشات أو ما شابه ذلك هي معلومات عامة، وليس هناك أي توقع للخصوصية أو السرية. دنيا ليست مسؤولة عن أي بيانات شخصية تختار نشرها على الملأ في أي من هذه المنتديات.
إذا كان عمرك أقل من 15 عامًا أو قاصرًا في بلد إقامتك، فيرجى طلب إذن ولي أمرك القانوني لاستخدام الخدمات أو الوصول إليها. تتعامل   مع خصوصية الأطفال على محمل الجد، وتشجع الآباء و / أو الأبناء على دور نشط في تجربة أطفالهم عبر الإنترنت في جميع الأوقات. لا تجمع عن قصد أي معلومات شخصية من الأطفال دون السن المذكورة أعلاه، وإذا علم تطبيق دنيا أن دنيا قد قام عن غير قصد بجمع بيانات شخصية من أطفال دون السن المذكورة أعلاه، فستتخذ دنيا إجراءات معقولة لمحو هذه البيانات الشخصية على الفور من سجلات MoApps.
يجوز لـ تخزين و / أو نقل بياناتك الشخصية إلى الشركات التابعة لها وشركائها داخل وخارج الدول الأعضاء في الاتحاد الأوروبي / المنطقة الاقتصادية الأوروبية والولايات المتحدة وفقًا للتشريعات الإلزامية وسياسة الخصوصية هذه. قد تفصح عن بياناتك الشخصية لأطراف ثالثة فيما يتعلق بدمج الشركة، أو توحيدها، أو إعادة هيكلتها، أو بيع جميع أسهم و / أو أصول MoApps أو أي تغيير مؤسسي آخر، بما في ذلك، على سبيل المثال لا الحصر، أثناء عملية العناية الواجبة شريطة أن تستمر سياسة الخصوصية هذه في التحكم في هذه البيانات الشخصية.

تراجع بانتظام امتثالها لسياسة الخصوصية هذه. إذا تلقت دنيا تقودم رسمية مكتوبة منك، فمن سياسة MoApps محاولة الاتصال بك مباشرةً لمعالجة أي من مخاوفك. ستتعاون مع السلطات الحكومية المختصة، بما في ذلك سلطات حماية البيانات، لحل أي شكاوى تتعلق بجمع البيانات الشخصية أو استخدامها أو نقلها أو الكشف عنها والتي لا يمكن حلها وديًا بينك وبينها MoApps.
خدمات الطرف الثالث
نحن نستخدم خدمات الطرف الثالث في تطبيقاتنا. تجمع هذه الخدمات بيانات الاستخدام وفقًا لسياسات الخصوصية الخاصة بها. الخدمات موصوفة أدناه.
دعاية
تسمح أنظمة عرض إعلانات الجهات الخارجية باستخدام بيانات المستخدم لأغراض الاتصالات الإعلانية المعروضة في شكل لافتات وإعلانات أخرى على اعتمدت Donya سياسة الخصوصية هذه ("سياسة الخصوصية") لشرح كيفية قيام Donya بجمع وتخزين واستخدام المعلومات التي تم جمعها فيما يتعلق بخدمات Donya. اعتمدت Donya سياسة الخصوصية هذه ("سياسة الخصوصية") لشرح كيفية قيام Donya بجمع وتخزين واستخدام المعلومات التي تم جمعها فيما يتعلق بخدمات Donya. اعتمدت Donya سياسة الخصوصية هذه ("سياسة الخصوصية") لشرح كيفية قيام Donya بجمع وتخزين واستخدام المعلومات التي تم جمعها فيما يتعلق بخدمات Donya. اعتمدت Donya سياسة الخصوصية هذه ("سياسة الخصوصية") لشرح كيفية قيام Donya بجمع وتخزين واستخدام المعلومات التي تم جمعها فيما يتعلق بخدمات Donya. اعتمدت Donya سياسة الخصوصية هذه ("سياسة الخصوصية") لشرح كيفية قيام Donya بجمع وتخزين واستخدام المعلومات التي تم جمعها فيما يتعلق بخدمات Donya. اعتمدت Donya سياسة الخصوصية هذه ("سياسة الخصوصية") لشرح كيفية قيام Donya بجمع وتخزين واستخدام المعلومات التي تم جمعها فيما يتعلق بخدمات Donya. اعتمدت Donya سياسة الخصوصية هذه ("سياسة الخصوصية") لشرح كيفية قيام Donya بجمع وتخزين واستخدام المعلومات التي تم جمعها فيما يتعلق بخدمات Donya. اعتمدت Donya سياسة الخصوصية هذه ("سياسة الخصوصية") لشرح كيفية قيام Donya بجمع وتخزين واستخدام المعلومات التي تم جمعها فيما يتعلق بخدمات Donya.تطبيقات، ربما بناءً على اهتمامات المستخدم.
AdMob
نستخدم Admob من Google كخادم الإعلانات الرئيسي. يرجى الاطلاع على سياسة خصوصية Admob - https://www.google.com/intl/en/policies/privacy/
تحليلات
تتيح لنا خدمات تحليلات الجهات الخارجية مراقبة استخدام التطبيق وتحليله، وفهم جمهورك وسلوك المستخدم بشكل أفضل.
مضطرب
نحن نستخدم بليسك لجمع بيانات السجل ومراقبتها وتحليلها، بما في ذلك تكرار الاستخدام، وطول الوقت الذي يقضيه التطبيق، من أجل تحسين وظائف تطبيقاتنا وسهولة استخدامها. يرجى الاطلاع على سياسة خصوصية Flurry - https://www.plesk.com/plesk-free-
تحليلات google
Google Analytics هي خدمة تحليل تقدمها شركة Google Inc.. تستخدم Google البيانات التي تم جمعها لتتبع وفحص استخدام DonyaApps، لإعداد تقارير عن أنشطة المستخدم ومشاركتها مع خدمات Google الأخرى. قد تستخدم Google البيانات لتهيئة إعلانات شبكة الإعلانات الخاصة بها وتخصيصها. (http://www.google.com/intl/en/policies/privacy/)
الامتثال لقانون حماية خصوصية الأطفال على الإنترنت
نحن ملتزمون بمتطلبات قانون حماية خصوصية الأطفال على الإنترنت (COPPA) ، ولا نجمع أي معلومات شخصية من أي شخص يقل عمره عن 13 عامًا. جميع منتجاتنا وخدماتنا موجهة إلى الأشخاص الذين لا تقل أعمارهم عن 13 عامًا أو أكبر

</p>
<p>
اتصل بنا
</p>
<p>
<li>
www.donya.com.tn

</li> 
<li>
+447594966051 whatsApp
</li> 
<li>
00971588117248
</li> 
<li>
المهندس معاوية الحسيني

</li> 
<li>
مؤسس ورئيس مجلس الإدارة
</li> 
</p>


""";


/*"""
<p>تتمثل سياسة الخصوصية هذه في كيفية تداول معلوماتك الشخصية ونقوم بتحصيل واستخدام وتبادل المعلومات الشخصية لمساعدة موقع دنيا الإلكتروني (دنيا) في العمل والاحتفاظ به أمنًا (المعلومات الواردة أدناه) وفي المصطلحات الرسمية، تعد بوابة دنيا الإلكترونية – ش.ذ.م.م دنيا الرقمية 046 شارع جعفر رعود 2083 تونس مسجلة في تونس تحت رقم 1730967 / V والقائمة بالعمل عن نفسها ومن خلال الشركات التابعة لها بمثابة مراقب معلومات بياناتكم الشخصية. </p>
<p> التحصيل 
يتم إتاحة المعلومات المدونة في دنيا بشكل عام وواضح وتتاح الملقمات الخاصة بنا في تونس وستقوم دنيا بالحصول على المعلومات الخاصة بك ونقلها في بيئة أمنة وسرية ومضمونة وفي حالة ما إذا اخترت تزويدنا بالمعلومات الشخصية، فإنك بذلك توافق على نقل وتخزين تلك المعلومات في الملقمات الخاصة بنا في تونس ونقوم بتحصيل المعلومات الشخصية التالية وتخزينها</p>
<li>عنوان البريد الإلكتروني وبيانات التواصل المادية. 
</li>
<li>المعلومات الأخرى التي تتضمن عنوان بروتوكول الانترنت للمستخدمين وبيانات الجهاز. 
</li>
<li>
بيانات تحليل جوجل والتي يأتي من بينها العمل والجنس والمصالح استنادًا إلى عرض الإعلانات (أي إعادة التسويق والإبلاغ عن انطباع شبكة عرض جوجل وتكامل مدير حملة انقر مرتين أو الخصائص السكانية لتحليلات جوجل والإبلاغ عن المصالح). 
</li>
<li>
يمكن للزوار تجاهل تحليلات جوجل لعرض الإعلان وتخصيص إعلانات شبكة عرض جوجل من خلال استخدام إعدادات الإعلانات أو من خلال تحميل وتركيب ملحق متصفح تجاوز تحليلات جوجل. 
 
</li>

<li>
لن يتم تخزين بيانات بطاقات الاعتماد / الدين والمعلومات المعرفة بشكل شخصي أو تأجيرها إلى الغير. 
</li>
<p>الاستخدام </p>
<p> نقوم باستخدام المعلومات المحصلة الشخصية الخاصة بالمستخدم إلى</p>
<ul>
<li>- تقديم الخدمات الخاصة بنا.  </li>
<li>- تسوية النزاعات وحل المشاكل</li>
<li>- التشجيع على التداول الأمن وتفعيل السياسات الخاصة بنا. </li>
<li>تخصيص خبرات المستخدم وتقييم المصالح في الخدمات الخاصة بنا وإبلاغ المستخدمين بشأن الخدمات والتحديثات. </li>
<li>- تقديم عروض التسويق والعروض الترويجية إليكم</li>
<li>- تقديم عروض التسويق والعروض الترويجية إليكم</li>
<li>- القيام بالأشياء الأخرى للمسخدمين وفقًا لما هو موصوف عندما نقوم بتحصيل المعلومات. </li>
</ul>
<p>الإفصاح </p>
<p>لا نقوم ببيع أو تأجير المعلومات الشخصية الخاصة بك إلى الغير لأغراض التسويق دون موافقتكم الصريحة ويجوز لنا الإفصاح عن المعلومات الشخصية للرد على المتطلبات القانونية وتفعيل السياسات الخاصة بنا والرد على الإدعاءات بشأن مخالفة أي من عمليات التدوين أو سبل التواصل الأخرى للحقوق الأخرى أو حماية حقوق أي شخص أو السلامة (على سبيل المثال في حالة تقدمك ببيانات تواصل زائفة أو انتحال شخصية أخرى، فإنه يجوز لنا تمرير المعلومات الشخصية الخاصة بك لأي من الأطراف المتضررة أو وكيلهم أو أي من وكالات تفعيل القانون). كما يجوز لنا كذلك تبادل المعلومات الشخصية مع مزودي الخدمات الذين يساعدون في عملياتنا التجارية. </p>
<p>استخدام المعلومات الواردة من دنيا </p>
<p>يجوز لك استخدام المعلومات الشخصية التي لا يتم تجمعيها من دنيا إلا للمتابعة مع مستخدم أخر بشأن بعض الملصقات وعدم إرسال رسائل بريد إلكتروني غير مرغوب فيها أو تحصيل المعلومات الشخصية من أي شخص لم يوافق على ذلك. </p>

<p>التسويق</p>
<p>في حالة ما إذا كنت لا ترغب في الحصول على مراسلات تسويق منا، فإنه يمكنك ببساطة مراسلتنا عبر البريد الإلكتروني في أي وقت</p>
<li>التسويق من خلال أنظمة تحليل جوجل </li>
<li>تقوم دنيا باستخدام نظم إعادة اتسويق من خلال أنظمة تحليل جوجل للإعلان عبر الانترنت</li>
<li>يظهر موردو الغير بما في ذلك جوجل إعلانات دنيا على المواقع الإلكترونية عبر الانترنت. 
</li>
<p>عام </p>
<li>في حالة دخول أي من الشركات الفرعية التجارية التابعة لنا في أي دمج أو عمليات الاستحواذ، فإنه يجوز لنا تبادل المعلومات الشخصية مع شركة أخرى ويحق لهذه الشركة الأخرى تبادل المعلومات الشخصية الخاصة بك مع الشركات الأخرى لكنه خلاف ذلك في كافة الأوقات يلزم احترام المعلومات الشخصية الخاصة بك وفقًا لما هو وارد في هذه السياسة. </li>
<li>قد يتم تغيير سياسات دنيا أو تحديثها أحيانًا للوفاء بالمتطلبات والمعايير وبالتالي، يحث المستخدمين على زيارة تلك الأقسام بشكل متكرر لكي يتم تزويدهم بأخر مستجدات التغييرات الواردة في الموقع الإلكتروني وسيتم تفعيل التعديل في اليوم الذي يتم تدوينها به. </li>
<p>الأمن </p>
<li>نقوم باستخدام العديد من الأدوات لحماية المعلومات الشخصية الخاصة بك من الوصول غير المصرح به والإفصاح لكنه نظرًا لأنه لا يمكنك معرفة أي شئ مميز، لذا فإننا لا نقدم أي ضمانات. </li>
<p>تونس 02 / 06 / 2023</p>



""";*/


const kHtmlEn = """

<p></p>
<p> Donya has adopted this privacy policy (“Privacy Policy”) to explain how Donya collects, stores, and uses the information collected in connection with Donya’s Services.
 BY INSTALLING, USING, REGISTERING TO OR OTHERWISE ACCESSING THE SERVICES, YOU AGREE TO THIS PRIVACY POLICY AND GIVE AN EXPLICIT AND INFORMED CONSENT TO THE PROCESSING OF YOUR PERSONAL DATA IN ACCORDANCE WITH THIS PRIVACY POLICY. IF YOU DO NOT AGREE TO THIS PRIVACY POLICY, PLEASE DO NOT INSTALL, USE, REGISTER TO OR OTHERWISE ACCESS THE SERVICES. Donya reserves the right to modify this Privacy Policy at reasonable times, so please review it frequently. If Donya makes material or significant changes to this Privacy Policy, Donya may post a notice on Donyawebsite)www.donya.com.tn) along with the updated Privacy Policy. Your continued use of Services will signify your acceptance of the changes to this Privacy Policy.

Non-personal data
For purposes of this Privacy Policy, “non-personal data” means information that does not directly identify you. The types of non-personal data Donya may collect and use include, but are not limited to: application properties, including, but not limited to application name, package name and icon installed on your device. Your checkin (include like, recommendation) of a Donya will be disclosed to all Donya  users.
Donya may use and disclose to MoApps’s partners and contractors the collected non-personal data for purposes of analyzing usage of the Services, advertisement serving, managing and providing the Services and to further develop the Services and other Donya services and products.
Personal Data
For purposes of this Privacy Policy, “personal data” means personally identifiable information that specifically identifies you as an individual.
Personal information collected by Donya information voluntarily provided to us by you when you create your account or change your account 
information. The information includes your facebook id google id, name, gender, location and your friends’id on facebook. Donya also stores your  checkins, likes, dislikes, recommendations and messages.
Donya may use collected personal data for purposes of analyzing usage of the Services, providing customer and technical support, managing and providing Services (including managing advertisement serving) and to further develop the Services and other Donya services and products. Donya may combine non-personal data with personal data
Please note that certain features of the Services may be able to connect to your social networking sites to obtain additional information about you. In such cases, Donya may be able to collect certain information from your social networking profile when your social networking site permits it, and when you consent to allow your social networking site to make that information available to My Apps. This information may include, but is not limited to, your name, profile picture, gender, user ID, email address, your country,
your language, your time zone, the organizations and links on your profile page, the names and profile pictures of your social networking site “friends” and other information you have included in your social networking site profile. Donya may associate and/or combine as well as use information collected by Donya and/or obtained through such social networking sites in accordance with this Privacy Policy.
Disclosure and Transfer of Personal Data
Donya collects and processes personal data on a voluntary basis and it is not in the business of selling your personal data to third parties. Personal data may, however, occasionally be disclosed in accordance with applicable legislation and this Privacy Policy. Additionally, Donya may disclose personal data to its parent companies and its subsidiaries in accordance with this Privacy Policy.
Donya  may hire agents and contractors to collect and process personal data on Mo Apps’s behalf and in such cases such agents and contractors will be instructed to comply with our Privacy Policy and to use personal data only for the purposes for which the third party has been engaged by MoApps. These agents and contractors may not use your personal data for their own marketing purposes. Donya may use third party service providers such as credit card processors, e-mail service providers, shipping agents, data analyzers and business intelligence providers. Donya the right to share your personal data as necessary for the aforementioned third parties to provide their services for MoApps. Donya is not liable for the acts and omissions of these third parties, except as provided by mandatory law.
Donya may disclose your personal data to third parties as required by law enforcement or other government officials in connection with an investigation of fraud, intellectual property infringements, or other activity that is illegal or may expose you or Donya to legal liability. Donya may also disclose your personal data to third parties when Donya a reason to believe that a disclosure is necessary to address potential or actual injury or interference with MoApps’s rights, property, operations, users or others who may be harmed or may suffer loss or damage, or Donya believes that such disclosure is necessary to protect Donya’s rights, combat fraud and/or comply with a judicial proceeding, court order, or legal process served on MoApps. To the extent …
Safeguards
Donya  follows generally accepted industry standards and maintains reasonable safeguards to attempt to ensure the security, integrity and privacy of the information in MoApps’s possession. Only those persons with a need to process your personal data in connection with the fulfillment of their tasks in accordance with the purposes of this Privacy Policy and for the purposes of performing technical maintenance, have access to your personal data in MoApps’s possession. Personal data collected by Donya is stored in secure operating environments that are not available to the public. To prevent unauthorized on-line access to personal data, Donya maintains personal data behind a firewall-protected server. However, no system can be 100% secure and there …
Other
Please be aware of the open nature of certain social networking and other open features of the Services Donya may make available to you. You may choose to disclose data about yourself in the course of contributing user generated content to the Services. Any data that you disclose in any of these forums, blogs, chats or the like is public information, and there is no expectation of privacy or confidentiality. Donya is not responsible for any personal data you choose to make public in any of these forums.
If you are under 15 years of age or a minor in your country of residence, please ask your legal guardian’s permission to use or access the Services. Donya takes children’s privacy seriously, and encourages parents and/or guardians to play an active rol…
Donys  may store and/or transfer your personal data to its affiliates and partners in and outside of EU/EEA member states and the United States in accordance with mandatory legislation and this Privacy Policy. Donya may disclose your personal data to third parties in connection with a corporate merger, consolidation, restructuring, the sale of substantially all of MoApps’s stock and/or assets or other corporate change, including, without limitation, during the course of any due diligence process provided, however, that this Privacy Policy shall continue to govern such personal data.
Donya regularly reviews its compliance with this Privacy Policy. If Donya receives a formal written complaint from you, it is MoApps’s policy to attempt to contact you directly to address any of your concerns. Donya will cooperate with the appropriate governmental authorities, including data protection authorities, to resolve any complaints regarding the collection, use, transfer or disclosure of personal data that cannot be amicably resolved between you and MoApps.
3rd party services
We use 3rd party services in our apps. These services collect usage data in compliance with their Privacy Policies. The services are described below.
Advertising
3rd party ad serving systems allow user data to be utilized for advertising communication purposes displayed in the form of banners and other advertisements on Donya apps, possibly based on user interests.
Admob
We use Admob by Google as the main ad server. Please see Admob Privacy Policy – https://www.google.com/intl/en/policies/privacy/
Analytics 
3rd party analytics services allow us to monitor and analyze app usage, better understand your audience and user behavior.
Flurry
We use Plesk to collect, monitor and analyze log data, including frequency of use, length of time spent in the app, in order to improve functionality and user-friendliness of our apps. Please see Flurry Privacy Policy – https://www.plesk.com/plesk-free-
Google Analytics
Google Analytics is an analysis service provided by Google Inc. Google utilizes the collected data to track and examine the use of Donya Apps, to prepare reports on user activities and share them with other Google services. Google may use the data to contextualize and personalize the ads of its own advertising network. (http://www.google.com/intl/en/policies/privacy/)
Children’s Online Privacy Protection Act Compliance
We are in compliance with the requirements of COPPA, we do not collect any personal information from anyone under 13 years of age. Our products and services are all directed to people who are at least 13 years old or older.
Contact Us
info@donya.com.tn
www.donya.com.tn
+447594966051 WhtsApp
+971588117248
 Engineer HOUSSAINI MAOUIA
Founder and Chairman of the Board

 </p>
</p>
<p>
Contact Us

</p>
<p>
<li>
www.donya.com.tn

</li> 
<li>
+447594966051 whatsApp
</li> 
<li>
00971588117248
</li> 
<li>
 Engineer HOUSSAINI MAOUIA

</li> 
<li>
Founder and Chairman of the Board
</li> 
</p>



""";