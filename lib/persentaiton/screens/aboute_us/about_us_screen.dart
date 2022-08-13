import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
class AboutUsScreen extends StatefulWidget {
  final int stayus;

  AboutUsScreen(this.stayus);
  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title:   Text(
            'من نحن'.tr(),

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


const kHtmlAr = """
<p>
دنيا ديجيتال شركة ذات مسولية محدودة
راس مالها 100 الف دينار تونسي
المعرف الجباْئي
1730967/V/A/N/000
46 نهج جعفر رواد تونس 2083
تطبيق دنيا ملك  ( شركة دنيا ديجتال ) وهي شركة تونسية برأس مال قدره 100.000 دينار  تونسي وهو  تطبيق فريد من نوعة يجمع  كل الخدمات  التي تحتاجها لتسهيل حياتك اليومية فهو يسهل للمستهلك الوصول للشركات التي تخدمة في حياتة اليومية وايضا من الجانب الاخر تسهل للشركات الوصول لطالب الخدمه الذي يوفر لها الوقت والجهد  كما يسهل التطبيق أيضا العمليات التجارية بخلق مساحة للإعلانات ويجمع بين صاحب الخدمه والباحث عنها في شتى المجالات.
تطبيق دنيا يوفر لك ايضا ميزة المزادات ليمكنكم من المشاركة و يتيح لك الفرصه لبيع أغراضك بطريقه المزاد ويخلق حاله من التنافس للحصول عليها مما يوفر لك اكبر قدر من الفائده في بيع اغراضك وايضا يوفر للمزايد فرصة لشراء الاغراض باقل من سعرها في المزادات فهي تمثل لك فرصه في الشراء .
كما يوفر لك تطبيق دنيا ميزه الوصول إلى المهن الحرة  التي تحتاج لها في مختلف الأوقات لمنزلك ولسيارتك ولحياتك اليوميه وايضا من الجهه المقابله يوفر لك عميل بسهوله فائقه فهو يجمع بين طرفي المعامله بكل سهوله ويخلق المنافسة.
تطبق دنيا هو اول تطبيق في العالم يتيح لك المحافظه على اسرارك البنكيه فهو يعتمد على شركات الاتصالات مما يجعل لك مجال في الحفاظ على خصوصياتك البنكيه فنحن نضع خيار الدفع بالبطاقه البنكيه كخيار اخير في طرق الدفع  يتعامل التطبيق مع مختلف شركات الإتصال و بذلك يسهل عليكم عمليات الدفع ويجعلها أكثر آمان من خلال التعامل بالرصيد.
دنيا يوفر لك الوصول لكل ما تحتاجه بأقل التكاليف وأقل وقت وانسب طرق. 
فانت مع تطبيق دنيا  تحتاجه في كل الدنيا فانت بمجرد سفرك في اي دوله فقط يتم تغير الدوله لتتمتع بكل المميزات الموجوده بهذة الدوله
فانت في تطبيق دينا يكون في يدك كل الدنيا
المؤسس ورئيس مجلس الادارة المهندس معاوية بن محمد الحسيني




</p>
""";


const kHtmlEn = """

<p>
Donia Digital Limited Liability Company
Its capital is 100 thousand Tunisian dinars
tax identifier
1730967 / V / A / N / 000
46 Jaafar Street, Rowad Tunis 2083
Donia Malak (Dunia Digital Company), a Tunisian company with a defense capital of 100,000 Tunisian dinars, and it is a unique application that brings together all the services you need to facilitate your daily life. It also facilitates the application of commercial goods by creating a space for advertisements and brings together the service owner and the searcher in various fields.
Provides provides you a chance to get items in the purchase auction.
The Dunya application also provides you with the advantage of accessing the free professions that you need at all times for your home, your car and your daily life, and also from the opposite side, it provides you with a customer with great ease that combines the two sides of the transaction with ease and creates it.
It makes us trade that makes you maintain your banking privacy. We put the option to pay by bank card as the last option in the payment methods. It deals with various communication companies, and thus it facilitates the last of the payment methods to deal with various companies and makes them more while dealing with the balance.
Dunia provides you with everything you need at the lowest costs, the least time, and the most appropriate way.
You are with a minimum application that you need in the whole world. You are locked in any country, only the country is changed
You are in our application that will be in your hand the whole world
Founder and Chairman of the Board, 
Engineer Maouia houssaini




</p>
""";



const kHtmlFR = """

<p>
Donia Digital Société à Responsabilité Limitée
Son capital est de 100 mille dinars tunisiens
identifiant fiscal
1730967/V/A/N/000
46 Rue Jaafar, Rowad Tunis 2083
Donia Malak (Dunia Digital Company), une société tunisienne au capital défense de 100 000 dinars tunisiens, et c'est une application unique qui regroupe tous les services dont vous avez besoin pour faciliter votre quotidien. Elle facilite également l'application de biens commerciaux en créant un espace pour les annonces et réunit le propriétaire du service et le chercheur dans divers domaines.
Fournit vous offre une chance d'obtenir des objets dans l'enchère d'achat.
L'application Dunya vous offre également l'avantage d'accéder à tout moment aux métiers gratuits dont vous avez besoin pour votre maison, votre voiture et votre quotidien, et aussi de l'autre côté, elle vous offre une clientèle d'une grande facilité qui allie la deux côtés de la transaction avec facilité et la crée.
Cela nous fait du commerce qui vous permet de préserver votre confidentialité bancaire. Nous mettons l'option de paiement par carte bancaire en dernière option dans les modes de paiement. Il traite avec diverses sociétés de communication, et facilite ainsi le dernier des modes de paiement à traiter. diverses entreprises et les rend plus tout en traitant de l'équilibre.
Dunia vous fournit tout ce dont vous avez besoin au moindre coût, en un minimum de temps et de la manière la plus appropriée.
Vous êtes avec une application minimale dont vous avez besoin dans le monde entier. Vous êtes bloqué dans n'importe quel pays, seul le pays est modifié
Vous êtes dans notre application qui sera entre vos mains le monde entier
Fondateur et président du conseil d'administration, ingénieur Maouia houssaini




</p>



""";

