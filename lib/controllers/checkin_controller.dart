import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class CheckInController extends GetxController{
  List checkIns = [];
  List myCheckIns = [];
  bool isLoading = false;

  String checkedInUser = "";
  bool hasCheckIn = false;
  String timeCheckIn = "";
  String dateCheckIn = "";

  Future<void> getCheckInsToday(String token)async{
    try{
      isLoading=true;
      const walletUrl = "https://havenslearningcenter.xyz/check_ins_today/";
      var link = Uri.parse(walletUrl);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $token"
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        checkIns.assignAll(jsonData);
        update();
      }
    }
    catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading = false;
    }
  }

  Future<void> getDetailCheckIn(String pk,String token)async {
    try{
      isLoading = true;
      final walletUrl = "https://havenslearningcenter.xyz/checkin_detail/$pk/";
      var link = Uri.parse(walletUrl);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $token"
      });
      if (response.statusCode == 200) {
        final codeUnits = response.body;
        var jsonData = jsonDecode(codeUnits);
        checkedInUser = jsonData['user'].toString();
        hasCheckIn = jsonData['has_checked_in'];
        timeCheckIn = jsonData['time_checked_in'];
        dateCheckIn = jsonData['date_checked_in'];
        update();
      }
    }
    catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading = false;
    }

  }

  Future<void> getMyCheckIns(String token) async {
    try{
      isLoading=true;
      const walletUrl = "https://havenslearningcenter.xyz/my_check_in/";
      var link = Uri.parse(walletUrl);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $token"
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        myCheckIns.assignAll(jsonData);
        update();
      }
    }
    catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading = false;
    }
  }
}