import 'dart:async';
import 'dart:convert';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../admin/views/admin_dashboard.dart';
import '../admin/views/allmembers.dart';
import '../admin/views/checkins.dart';
import '../admin/views/notifications.dart';
import '../admin/views/register.dart';
import '../constants/app_colors.dart';
import '../controllers/announcements_controller.dart';
import '../controllers/checkin_controller.dart';
import '../controllers/devotion_controller.dart';
import '../controllers/events_controller.dart';
import '../controllers/notificationController.dart';
import '../controllers/notifications/localnotification_manager.dart';
import '../controllers/userController.dart';
import 'notifications.dart';


class AdminBottomNavigationBar extends StatefulWidget {
  const AdminBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _AdminBottomNavigationBarState createState() => _AdminBottomNavigationBarState();
}

class _AdminBottomNavigationBarState extends State<AdminBottomNavigationBar> {
  final storage = GetStorage();
  late String username = "";
  late String uToken = "";
  int selectedIndex = 0;
  late PageController pageController;
  bool hasInternet = false;
  late StreamSubscription internetSubscription;
  NotificationController notificationController = Get.find();

  late List allBlockedUsers = [];
  late List blockedUsernames = [];
  late Timer _timer;
  bool isBlocked = false;
  final screens = [
    const Dashboard(),
    const CheckIns(),
    const AdminNotifications(),
    const Members()
  ];

  void onSelectedIndex(int index){
    setState(() {
      selectedIndex = index;
    });
  }
  bool isLoading = true;

  late List allNotifications = [];

  late List yourNotifications = [];

  late List notRead = [];

  late List triggered = [];

  late List unreadNotifications = [];

  late List triggeredNotifications = [];

  late List notifications = [];

  late List allNots = [];

  Future<void> getAllTriggeredNotifications() async {
    const url = "https://havenslearningcenter.xyz/get_triggered_notifications/";
    var myLink = Uri.parse(url);
    final response =
    await http.get(myLink, headers: {"Authorization": "Token $uToken"});
    if (response.statusCode == 200) {
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      triggeredNotifications = json.decode(jsonData);
      triggered.assignAll(triggeredNotifications);
    }
  }

  Future<void> getAllUnReadNotifications() async {
    const url = "https://havenslearningcenter.xyz/get_user_unread_notifications/";
    var myLink = Uri.parse(url);
    final response =
    await http.get(myLink, headers: {"Authorization": "Token $uToken"});
    if (response.statusCode == 200) {
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      yourNotifications = json.decode(jsonData);
      notRead.assignAll(yourNotifications);
    }
  }

  Future<void> getAllNotifications() async {
    const url = "https://havenslearningcenter.xyz/my_notifications/";
    var myLink = Uri.parse(url);
    final response =
    await http.get(myLink, headers: {"Authorization": "Token $uToken"});
    if (response.statusCode == 200) {
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      allNotifications = json.decode(jsonData);
      allNots.assignAll(allNotifications);
    }
  }

  unTriggerNotifications(int id) async {
    final requestUrl = "https://havenslearningcenter.xyz/read_notification/$id/";
    final myLink = Uri.parse(requestUrl);
    final response = await http.put(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      'Accept': 'application/json',
      "Authorization": "Token $uToken"
    }, body: {
      "notification_trigger": "Not Triggered",
    });
    if (response.statusCode == 200) {}
  }

  updateReadNotification(int id) async {
    final requestUrl = "https://havenslearningcenter.xyz/read_notification/$id/";
    final myLink = Uri.parse(requestUrl);
    final response = await http.put(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      'Accept': 'application/json',
      "Authorization": "Token $uToken"
    }, body: {
      "read": "Read",
    });
    if (response.statusCode == 200) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    internetSubscription = InternetConnectionChecker().onStatusChange.listen((status){
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(()=> this.hasInternet = hasInternet);
    });
    if (storage.read("userToken") != null) {
      uToken = storage.read("userToken");
    }
    if (storage.read("username") != null) {
      username = storage.read("username");
    }
    pageController = PageController(initialPage: selectedIndex);

    getAllTriggeredNotifications();

    // _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
    //   getAllTriggeredNotifications();
    //   getAllUnReadNotifications();
    //   for (var i in triggered) {
    //     localNotificationManager.showAllNotification(
    //         i['notification_title'], i['notification_message']);
    //   }
    // });
    //
    // _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
    //   for (var e in triggered) {
    //     unTriggerNotifications(e["id"]);
    //   }
    // });

    localNotificationManager
        .setOnAllNotificationReceive(onReceivedNotification);
    localNotificationManager
        .setOnAllNotificationClick(onNotificationClick);

  }

  onReceivedNotification(ReceiveNotification notification) {}

  onNotificationClick(String payload) {
    Get.to(() => Notifications());
  }

  @override
  void dispose(){
    internetSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child:Scaffold(
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              indicatorColor: Colors.white,
            labelTextStyle:  MaterialStateProperty.all(
              const TextStyle(fontSize:12, fontWeight: FontWeight.bold,color: Colors.white)
            )
          ),
          child: NavigationBar(
            backgroundColor: primaryColor,
            animationDuration: const Duration(seconds: 3),
            selectedIndex: selectedIndex,
            onDestinationSelected: (int index) => setState((){
              selectedIndex = index;
            }),
            height: 60,
            // backgroundColor: Colors.white,
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.home,color: Colors.white,),
                selectedIcon: Icon(Icons.home),
                label: "Home",
              ),
              const NavigationDestination(
                icon: Icon(Icons.access_time_filled,color: Colors.white,),
                selectedIcon: Icon(Icons.access_time_filled),
                label: "Check Ins",
              ),
              GetBuilder<NotificationController>(builder: (controller){
                return NavigationDestination(
                  icon: badges.Badge(
                      position: badges.BadgePosition.topEnd(top: -10, end: -12),
                      showBadge: true,

                      badgeAnimation: const badges.BadgeAnimation.rotation(
                        animationDuration: Duration(seconds: 1),
                        colorChangeAnimationDuration: Duration(seconds: 1),
                        loopAnimation: false,
                        curve: Curves.fastOutSlowIn,
                        colorChangeAnimationCurve: Curves.easeInCubic,
                      ),
                      badgeContent: Text("${notificationController.notRead.length}",style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize:15)),
                      child: const Icon(Icons.notifications,color: Colors.white,)),
                  selectedIcon: const Icon(Icons.notifications),
                  label: "Alerts",
                );
              }),

              const NavigationDestination(
                icon: Icon(Icons.people_alt,color: Colors.white,),
                selectedIcon: Icon(Icons.people_alt),
                label: "Members",
              ),
            ],
          ),
        ),
        body: screens[selectedIndex],
      )
    );
  }
}
