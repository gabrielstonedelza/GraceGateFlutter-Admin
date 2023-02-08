import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import "package:get/get.dart";

import '../constants/app_colors.dart';
import 'admin_bottomnavigationbar.dart';

class CheckInDetail extends StatefulWidget {
  final id;
  final user;
  final hasCheckedIn;
  final timecheckedin;
  final datecheckedin;
  const CheckInDetail({Key? key,required this.id,required this.user,required this.hasCheckedIn,required this.timecheckedin,required this.datecheckedin}) : super(key: key);

  @override
  State<CheckInDetail> createState() => _CheckInDetailState(id:this.id,user:this.user,hasCheckedIn:this.hasCheckedIn,timecheckedin:this.timecheckedin,datecheckedin:this.datecheckedin);
}

class _CheckInDetailState extends State<CheckInDetail> {
  final id;
  final user;
  final hasCheckedIn;
  final timecheckedin;
  final datecheckedin;
  _CheckInDetailState({required this.id,required this.user,required this.hasCheckedIn,required this.timecheckedin,required this.datecheckedin});
  final storage = GetStorage();
  late String username = "";
  late String uToken = "";

  approveCheckIn() async {
    final requestUrl = "https://havenslearningcenter.xyz/approve_check_in/$id/";
    final myLink = Uri.parse(requestUrl);
    final response = await http.put(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      'Accept': 'application/json',
      "Authorization": "Token $uToken"
    }, body: {
      "user": user,
      "has_checked_in": "True",
    });
    if (response.statusCode == 200) {
      Get.snackbar("Congrats", "check in was approved successfully",
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds:5),
          backgroundColor: primaryColor);
      // addToApprovedDeposits();
      Get.offAll(() => const AdminBottomNavigationBar());
    } else {
      Get.snackbar("Approve Error", "something happened. Please try again",
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: primaryColor);
    }
  }
  @override
  void initState(){
    super.initState();
    if (storage.read("userToken") != null) {
      uToken = storage.read("userToken");
    }
    if (storage.read("username") != null) {
      username = storage.read("username");
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Approve check in")
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left:8.0,right:8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: primaryColor
                  ),
                  height: size.height * 0.08,
                  width: size.width * 0.8,
                  child: RawMaterialButton(
                    onPressed: () {
                      approveCheckIn();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                    ),
                    elevation: 8,
                    child: const Text(
                      "Approve",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: defaultTextColor1),
                    ),
                    fillColor: primaryColor,
                    splashColor: splashColor,
                  ),
                ),
              ),
              const SizedBox(width:10),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: primaryColor
                  ),
                  height: size.height * 0.08,
                  width: size.width * 0.8,
                  child: RawMaterialButton(
                    onPressed: () {
                      Get.back();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                    ),
                    elevation: 8,
                    fillColor: Colors.red,
                    splashColor: splashColor,
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: defaultTextColor1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
