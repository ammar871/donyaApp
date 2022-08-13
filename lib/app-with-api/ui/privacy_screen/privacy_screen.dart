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

              widget.stayus== 0 ?kHtmlAr:widget.stayus==2 ?kHtmlFR :kHtmlEn,

              textStyle: TextStyle(fontSize: 14, color:Colors.black),

            ),
          ),
        ));
  }
}


const kHtmlAr ="""
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
<p>تونس 02 / 06 / 2023</p><li>نقوم باستخدام العديد من الأدوات لحماية المعلومات الشخصية الخاصة بك من الوصول غير المصرح به والإفصاح لكنه نظرًا لأنه لا يمكنك معرفة أي شئ مميز، لذا فإننا لا نقدم أي ضمانات. </li>




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

<p>This privacy policy how we handle your personal information. We collect,use,and share personal information to help the DONYA website (Donya) work and to keep it safe (details below).In formal terms,donya classifieds –LLC DONYA DIGITAL  046 Street JAAFAR RAOUED 2083 TUNIS registered in Tunis with number 1730967/V ,acting itself and through its subsidiaries , is the data controller of your personal information </p>
<p>Collection </p>

<p>Information posted on Donya is obviously publicly available. Our servers are located in Tunis .Donya will hold and transmit your information in a safe, confidential and secure environment. If you choose to provide us with personal information, you are consenting to the transfer and storage of that information on our servers in TUNIS. </p>
<p>We collect and store the following personal information:</p>



<ul>
<li>*Email address, physical contact information </li>
<li>*Statistics on page views, traffic to and from DONYA and ad data. </li>
<li>*Other information, including users IP address and device information.</li>
<li>*Google analytics data such as age, gender and interests based on display advertising (e.g., Remarketing, google display network impression reporting, the double click campaign manager integration, or google analytics demographics and interest reporting) </li>
<li>*Visitors can opt-out of google analytics for display advertising and customize google display network ads using the ads settings or by downloading and installing google analytics opt-out browser add-on.* </li>
<li>All credit /debit cards details and personally identifiable information will NOT be stored, rented or leased to any third parties. </li>
</ul>
<p>Use </p>
<p>We use user’s personal collected information to:</p>
<ul>
<li>*Provide our services.</li>
<li>*Resolve disputes and troubleshoot problems</li>
<li>*Encourage safe trading and enforce our policies</li>
<li>*Customize user s experience, measure interest in our services, and inform users about services and updates.</li>
<li>*Communicate marketing and promotional offers to you </li>
<li>*Do other things for users as described when we collect the information.</li>
</ul>
<p>Disclosure</p>
<p>We don t sell or rent your personal information to third parties for their marketing purposes without your explicit consent. We may disclose personal information to respond to legal requirements, enforce our policies, respond to claims that a posting or other contact violates others rights, or protect anyone s rights property, or safety(for example, if you submit false contact details or impersonate another person, we may pass your personal information to any aggrieved third party, their agent or to any law enforcement agency).We may also share personal information with service providers who help with our business operations.</p>

<p>Using information from Donya</p>

<p>You may use personal information gathered from Donya only to follow up with another user about specific </p>
<p>Posting, not to send spam or collect personal information from someone who has not agreed to that.</p>
<p>Marketing</p>
<p>If you do not wish to receive marketing communication from us, you can simply email us at any time.</p>

<li>Remarketing with google Analytics </li>
<li>DONYA uses Remarketing with google analytics to advertise online.</li>
<li>Third party vendors, including google, show Donya ads on sites across the internet.. 
</li>
<p>General  </p>
<li>If we our corporate affiliates are involved in a merger or acquisition, we may share personal information with another company, and this other company shall be entitled to share your personal information with other companies but at all time otherwise respecting your personal information in accordance with this policy.. </li>
<li>Donya policies may be change or updated occasionally to meet the requirement and standards .therefore users are encouraged to frequently visit these sections in order to be updated about the changes on the website modification will be effective on the day they are posted.</li>
<p>Security </p>
<li>We use many tools to protect your personal information against unauthorized access and disclosure, but as you probably know nothing s perfect, so we make no guarantees.. </li>
<p>Tunis 02/06/2023</p>



""";



const kHtmlFR = """

<p>Cette politique de confidentialité explique comment nous traitons vos informations personnelles. Nous collectons, utilisons et partageons des informations personnelles pour aider le site Web de DONYA (Donya) à fonctionner et à le garder en sécurité (détails ci-dessous). /V, agissant lui-même et par l'intermédiaire de ses filiales, est le responsable du traitement de vos informations personnelles</p>
<p>Le recueil
 </p>

<p>Les informations publiées sur Donya sont évidemment accessibles au public. Nos serveurs sont situés à Tunis .Donya conservera et transmettra vos informations dans un environnement sûr, confidentiel et sécurisé. Si vous choisissez de nous fournir des informations personnelles, vous consentez au transfert et au stockage de ces informations sur nos serveurs à TUNIS. Nous collectons et stockons les informations </p>
<p>personnelles suivantes :</p>
<ul>
<li>*Adresse e-mail, coordonnées physiques</li>
<li>* Statistiques sur les pages vues, le trafic vers et depuis DONYA et les données publicitaires.</li>
<li>*Autres informations, y compris l'adresse IP des utilisateurs et les informations sur l'appareil.</li>
<li> *Données Google Analytics telles que l'âge, le sexe et les centres d'intérêt basés sur la publicité display (par exemple, le remarketing, les rapports d'impression sur le Réseau Display de Google, l'intégration du gestionnaire de campagne double-clic ou les rapports sur les données démographiques et les centres d'intérêt de Google Analytics)</li>
<li>* Les visiteurs peuvent désactiver Google Analytics pour la publicité display et personnaliser les annonces du réseau Google Display à l'aide des paramètres des annonces ou en téléchargeant et en installant le module complémentaire de navigateur pour la désactivation de Google Analytics. *</li>
<li>Tous les détails des cartes de crédit / débit et les informations personnellement identifiables ne seront PAS stockés, loués ou loués à des tiers.</li>
</ul>
<p>Utilisation </p>
<p>Nous utilisons les informations personnelles collectées de l'utilisateur pour :</p>
<ul>
<li>*Fournir nos services.</li>
<li>* Résoudre les litiges et résoudre les problèmes</li>
<li>* Encouragez le trading en toute sécurité et appliquez nos politiques </li>
<li>* Personnalisez l'expérience de l'utilisateur, mesurez l'intérêt pour nos services et informez les utilisateurs des services et des mises à jour.  </li>
<li>* Vous communiquer des offres marketing et promotionnelles </li>
<li>* Faites d'autres choses pour les utilisateurs comme décrit lorsque nous recueillons les informations. </li>
</ul>
<p>Divulgation</p>
<P>Nous ne vendons ni ne louons vos informations personnelles à des tiers à des fins de marketing sans votre consentement explicite. Nous pouvons divulguer des informations personnelles pour répondre aux exigences légales, appliquer nos politiques, répondre aux réclamations selon lesquelles une publication ou un autre contact viole les droits d'autrui, ou protéger les droits, la propriété ou la sécurité de quiconque (par exemple, si vous soumettez de fausses coordonnées ou usurpez l'identité d'un autre personne, nous pouvons transmettre vos informations personnelles à tout tiers lésé, à son agent ou à tout organisme chargé de l'application de la loi). Nous pouvons également partager des informations personnelles avec des prestataires de services qui nous aident dans nos opérations commerciales.</P>
<p>Utilisation des informations de Donya
</p>
<p>Vous pouvez utiliser les informations personnelles recueillies auprès de Donya uniquement pour assurer le suivi avec un autre utilisateur à propos de</p>
<p>Publier, ne pas envoyer de spam ou collecter des informations personnelles auprès de quelqu'un qui n'a pas donné son accord.</p>
<p>Commercialisation</p>
<p>Si vous ne souhaitez pas recevoir de communications marketing de notre part, vous pouvez simplement nous envoyer un e-mail à tout moment.</p>
<li>Remarketing avec Google Analytics
 </li>
 <li>DONYA utilise le Remarketing avec Google Analytics pour faire de la publicité en ligne.</li>
<li>Des fournisseurs tiers, y compris Google, diffusent des publicités Donya sur des sites sur Internet.</li>
<p>Général  </p>
<li> Si nous, nos sociétés affiliées, sommes impliqués dans une fusion ou une acquisition, nous pouvons partager des informations personnelles avec une autre société, et cette autre société aura le droit de partager vos informations personnelles avec d'autres sociétés, mais à tout moment en respectant vos informations personnelles conformément à ce politique.</li>

<li>Les politiques de Donya peuvent être modifiées ou mises à jour occasionnellement pour répondre aux exigences et aux normes. Par conséquent, les utilisateurs sont encouragés à visiter fréquemment ces sections afin d'être informés des modifications apportées au site Web. La modification entrera en vigueur le jour de leur publication
</li>
<p>Sécurité </p>
<li>Nous utilisons de nombreux outils pour protéger vos informations personnelles contre l'accès et la divulgation non autorisés, mais comme vous savez probablement que rien n'est parfait, nous ne donnons aucune garantie.
</li>
<p>Tunisie 02/06/2023</p>



""";