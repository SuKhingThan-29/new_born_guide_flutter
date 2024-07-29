import 'package:chitmaymay/controller/chat_controller.dart';
import 'package:chitmaymay/controller/home_controller.dart';
import 'package:chitmaymay/screen/home/bottom_nav/body/body_screen.dart';
import 'package:chitmaymay/screen/home/bottom_nav/chat/chat_list_screen.dart';
import 'package:chitmaymay/screen/home/bottom_nav/download_video/downloaded_video_screen.dart';
import 'package:chitmaymay/screen/home/bottom_nav/drawer.dart';
import 'package:chitmaymay/screen/home/bottom_nav/setting/setting_screen.dart';
import 'package:chitmaymay/service/notification_service.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../common/tab_item.dart';

class HomeScreen extends StatefulWidget {
  final int selectedIndex;
  final bool isDeepLink;

  const HomeScreen(
      {Key? key, required this.selectedIndex, required this.isDeepLink})
      : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  late bool isDeepLink;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  HomeController homeController = Get.put(HomeController());
  ChatController chatController = Get.put(ChatController());

  late String urlImage = "";

  late List<TabItem> tabs;
  static int selectedIndex = 0;

  @override
  void initState() {
    selectedIndex = widget.selectedIndex;
    isDeepLink = widget.isDeepLink;

    tabs = [
      TabItem(page: Body()),
      TabItem(page: ChatListScreen()),
      TabItem(page: Setting()),
      TabItem(page: const DownloadedVideoScreen()),
    ];
    tabs.asMap().forEach((index, details) {
      details.setIndex(index);
    });
    homeController.onInit();
    super.initState();
    init();
    // Add the observer.
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    // These are the callbacks
    switch (state) {
      case AppLifecycleState.resumed:
        bool isValid = false;
        isValid = await homeController.ayaRefundPaymentVerify();
        if (isValid) {
          showPremiumAyaAlertDialog(context);
        }
        debugPrint('AppLifeCycle home: Resume');
        break;
      case AppLifecycleState.inactive:
        debugPrint('AppLifeCycle: inactive');
        // widget is inactive
        break;
      case AppLifecycleState.paused:
        debugPrint('AppLifeCycle: Pause');
        // widget is paused
        break;
      case AppLifecycleState.detached:
        debugPrint('AppLifeCycle: detached');
        // widget is detached
        break;
    }
  }

  @override
  void dispose() {
    // Remove the observer
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void init() async {
    //ConstantUtils.sendFirebaseAnalyticsEvent('HomeScreen');
    if (isDeepLink) {
      Future.delayed(Duration.zero, () => showPremiumCBAlertDialog(context));
    }
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        notiService.navigatePage(message);
      }
    });
  }

  void showPremiumAyaAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = GetBuilder<HomeController>(
      init: HomeController(),
      builder: (value) {
        return GestureDetector(
          onTap: () async {
            setState(() {
              Navigator.of(context).pop();
            });
          },
          child: Container(
              width: MediaQuery.of(context).size.width / 4,
              height: MediaQuery.of(context).size.height / 16,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: cl1_dark_purple),
              child: const Center(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.white),
                ),
              )),
        );
      },
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      content: SizedBox(
        height: MediaQuery.of(context).size.height / 6,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              width: 50,
              height: 50,
              child: SvgPicture.asset('assets/icon/crown.svg'),
            ),
            const Text(
              'Premium',
              style: TextStyle(color: Colors.black, fontSize: 28),
            ),
            const Text(
              'သုံးစွဲမှုအတွက် ကျေးဇူးတင်ပါသည်။',
              style: TextStyle(color: Colors.black, fontSize: 14),
            )
          ],
        ),
      ),
      actions: [
        Center(
          child: okButton,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showPremiumCBAlertDialog(BuildContext context) async {
    final payment = await homeController.verifyPayment();
    if (payment) {
      isDeepLink = false;
      
      // Create button
      Widget okButton = GetBuilder<HomeController>(
        init: HomeController(),
        builder: (value) {
          return GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                width: MediaQuery.of(context).size.width / 4,
                height: MediaQuery.of(context).size.height / 16,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: cl1_dark_purple),
                child: const Center(
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          );
        },
      );
      // Create AlertDialog
      AlertDialog alert = AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              width: 50,
              height: 50,
              child: SvgPicture.asset('assets/icon/crown.svg'),
            ),
            const Text(
              'Premium',
              style: TextStyle(color: Colors.black, fontSize: 28),
            ),
            const Text(
              'သုံးစွဲမှုအတွက် ကျေးဇူးတင်ပါသည်။',
              style: TextStyle(color: Colors.black, fontSize: 14),
            )
          ],
        ),
        actions: [
          Center(
            child: okButton,
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await tabs[selectedIndex].key.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (selectedIndex != 0) {
            _selectTab(0);
            return false;
          }
        }
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
          key: _key,
          body: IndexedStack(
            index: selectedIndex,
            children: tabs.map((e) => e.page).toList(),
          ),
          drawer: MyDrawer(),
          extendBody:
              true, // Important: to remove background of bottom navigation (making the bar transparent doesn't help)
          bottomNavigationBar: Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: selectedIndex,
                  elevation: 0,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: [
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                            "assets/home_icon/${selectedIndex == 0 ? 'Home_Big.svg' : 'Home_Small.svg'}"),
                        label: ''),
                    BottomNavigationBarItem(
                      label: '',
                      icon: Stack(
                        children: [
                          SvgPicture.asset(
                              "assets/home_icon/${selectedIndex == 1 ? 'Chat_Big.svg' : 'Chat_Small.svg'}"),
                          Positioned(
                            right: 0,
                            child: Obx(() {
                              return chatController.noticount.value != 0
                                  ? Container(
                                      padding: const EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      constraints: const BoxConstraints(
                                        minWidth: 14,
                                        minHeight: 14,
                                      ),
                                      child: Center(
                                        child: CustomText(
                                            text: chatController.noticount.value
                                                .toString(),
                                            isAlignCenter: true,
                                            textStyle: kTextStyleWhite(8)),
                                      ))
                                  : Container();
                            }),
                          )
                        ],
                      ),
                    ),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                            "assets/home_icon/${selectedIndex == 2 ? 'Profile B.svg' : 'Profile S.svg'}"),
                        label: ''),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          "assets/home_icon/${selectedIndex == 3 ? 'Download_Big.svg' : 'Download_Small.svg'}",
                        ),
                        label: '')
                  ],
                  onTap: _selectTab))),
    );
  }

  void _selectTab(int index) {
    FocusManager.instance.primaryFocus!.unfocus();
    if (index == selectedIndex) {
      if (mounted) setState(() {});
      tabs[index].key.currentState?.popUntil((route) => route.isFirst);
    } else {
      if (mounted) setState(() => selectedIndex = index);
    }
  }
}
