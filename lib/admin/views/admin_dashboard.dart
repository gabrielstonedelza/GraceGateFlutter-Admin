import 'package:animate_do/animate_do.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gracegatechapel/constants/app_colors.dart';
import 'package:gracegatechapel/controllers/announcements_controller.dart';

import '../../controllers/devotion_controller.dart';
import '../../views/announcements.dart';
import '../../views/devotions.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  DevotionController dController = Get.find();
  AnnouncementController aController = Get.find();
  var items;
  var announceItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: backgroundColor,

      appBar: AppBar(
        title: const Text("Today"),
        elevation: 0,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left:15.0,top:15,bottom:12.0,right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Morning Devotion"),
                TextButton(onPressed: (){
                  Get.to(() => const Devotions());
                },child: const Text("View All"),),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GetBuilder<DevotionController>(builder: (controller){
              return SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: ListView.builder(
                  itemCount: controller.currentDevotion != null ? controller.currentDevotion.length : 0,
                  itemBuilder: (context,index){
                    items = controller.currentDevotion[index];
                    return SlideInUp(
                      animate: true,
                      child: Card(
                        color: secondaryColor,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top:8.0,bottom:8.0),
                                  child: Text(items['title'],style:const TextStyle(fontWeight:FontWeight.bold,fontSize: 20,color: Colors.white)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top:8.0,bottom:10),
                                  child: Text(items['message'],style:const TextStyle(fontWeight:FontWeight.bold,fontSize: 16,color: Colors.white)),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(items['quotations'],style:const TextStyle(fontWeight:FontWeight.bold,fontSize: 13,color: Colors.white)),
                                    Text(items['date_created'].toString().split("T").first,style:const TextStyle(fontWeight:FontWeight.bold,fontSize: 13,color: Colors.white)),
                                  ],
                                ),
                              ],
                            ),
                          )
                      ),
                    );
                  },
                ),
              );
            },),
          ),
          Padding(
            padding: const EdgeInsets.only(left:15.0,top:15,bottom:12.0,right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Announcements"),
                TextButton(onPressed: (){
                  Get.to(() => const Announcements());
                },child: const Text("View All"),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GetBuilder<AnnouncementController>(builder: (aController){
              return SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: ListView.builder(
                  itemCount: aController.currentAnnouncement != null ? aController.currentAnnouncement.length : 0,
                  itemBuilder: (context,index){
                    announceItems = aController.currentAnnouncement[index];
                    return SlideInUp(
                      animate: true,
                      child: Card(
                          color: secondaryColor,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top:8.0,bottom:8.0),
                                  child: Text(announceItems['title'],style:const TextStyle(fontWeight:FontWeight.bold,fontSize: 20,color: Colors.white)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top:8.0,bottom:10),
                                  child: Text(announceItems['message'],style:const TextStyle(fontWeight:FontWeight.bold,fontSize: 16,color: Colors.white)),
                                ),
                                Text(announceItems['date_added'].toString().split("T").first,style:const TextStyle(fontWeight:FontWeight.bold,fontSize: 13,color: Colors.white)),
                              ],
                            ),
                          )
                      ),
                    );
                  },
                ),
              );
            },),
          ),

        ],
      )
    );
  }
}
