import 'package:chitmaymay/basic_player.dart';
import 'package:chitmaymay/screen/launch/launch_screen.dart';
import 'package:chitmaymay/service/init_service.dart';
import 'package:chitmaymay/service/translation_service.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'controller/language_controller.dart';
import 'screen/home/bottom_nav/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  initService.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  runApp(GetMaterialApp(
    routes: {
      //For Deep Link
      '/profile': (BuildContext context) =>
          const HomeScreen(selectedIndex: 0, isDeepLink: true)
    },
    locale: AppTranslations.locale,
    fallbackLocale: AppTranslations.fallbackLocale,
    debugShowCheckedModeBanner: false,
    translations: AppTranslations(),
    theme: ThemeData(
      primarySwatch: Colors.deepPurple,
    ),
    title: 'Better player demo',
    home: const MyApp(),
    initialBinding: InitialBinding(),
  ));
}

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LanguageController(), permanent: true);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => init());
  }

  void init() async {
    await initService.initializeData();
    if (initService.getUserId == 0) {
      Future.delayed(const Duration(seconds: 3), () {
        Get.off(() => LaunchScreen());
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const HomeScreen(selectedIndex: 0, isDeepLink: false)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDarkPurple,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: Image.asset("assets/home_icon/cmm_logo.gif"),
          ),
          const Spacer(),
          CustomText(text: 'powered_by'.tr, textStyle: kTextStyleWhite(14)),
          SizedBox(
            height: spaceBase,
          )
        ],
      )),
    );
  }
}
