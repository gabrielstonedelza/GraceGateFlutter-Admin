import 'package:animate_do/animate_do.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:gracegatechapel/views/checkin_detail.dart';

import '../../controllers/checkin_controller.dart';

class CheckIns extends StatefulWidget {
  const CheckIns({Key? key}) : super(key: key);

  @override
  State<CheckIns> createState() => _CheckInsState();
}

class _CheckInsState extends State<CheckIns> {
  var items;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("CheckIns")
        ),
        body: GetBuilder<CheckInController>(builder:(controller){
          return ListView.builder(
              itemCount: controller.checkIns != null ? controller.checkIns.length :0,
              itemBuilder: (context,index){
                items = controller.checkIns[index];
                return Column(
                  children: [
                    const SizedBox(height: 10,),
                    SlideInUp(
                      animate: true,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18,right: 18),
                        child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child:ListTile(
                              onTap: (){
                                Get.to(()=> CheckInDetail(id:controller.checkIns[index]['id'].toString(),user:controller.checkIns[index]['user'].toString(),hasCheckedIn:controller.checkIns[index]['has_checked_in'],timecheckedin:controller.checkIns[index]['time_checked_in'],datecheckedin:controller.checkIns[index]['date_checked_in']));
                              },
                              leading: const CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  foregroundColor: Colors.white,
                                  child: Icon(Icons.assessment)
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(top: 10, bottom: 10.0),
                                child: Text("${items['user']} wants to check in today"),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(items['date_checked_in'].toString().split(".").first),
                              ),
                            )
                        ),
                      ),
                    )
                  ],
                );

              }
          );
        }),
    );
  }
}