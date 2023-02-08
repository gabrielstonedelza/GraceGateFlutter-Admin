import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:gracegatechapel/admin/views/register.dart';
import 'package:gracegatechapel/views/edituser.dart';
import 'package:http/http.dart' as http;
import '../../constants/app_colors.dart';
import '../../controllers/userController.dart';

class Members extends StatefulWidget {
  const Members({Key? key}) : super(key: key);

  @override
  State<Members> createState() => _MembersState();
}

class _MembersState extends State<Members> {
  var items;
  UserController controller = Get.find();


  deleteUser(String id)async{
    final url = "https://havenslearningcenter.xyz/delete_user/$id";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink);

    if(response.statusCode == 204){
      Get.snackbar(
          "Success", "member was deleted",
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: primaryColor,
          duration: const Duration(seconds: 5)
      );
    }
    else{
      if (kDebugMode) {
        print(response.body);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Members (${controller.allUsers.length})"),
        actions: [
          IconButton(
            icon:const Icon(Icons.add_circle_rounded,size: 30,),
            onPressed: (){
              Get.to(()=> const Registration());
            },
          )
        ],
      ),
      body:GetBuilder<UserController>(builder:(controller){
        return ListView.builder(
            itemCount: controller.allUsers != null ? controller.allUsers.length : 0,
            itemBuilder: (context,i){
              items = controller.allUsers[i];
              return Column(
                children: [
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8),
                    child: Card(
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      // shadowColor: Colors.pink,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 1),
                        child: ListTile(
                            leading: GestureDetector(
                              onTap:(){
                                Get.to(()=> EditMember(id:controller.allUsers[i]['id'].toString(),username:controller.allUsers[i]['username'],fullName:controller.allUsers[i]['full_name'],email:controller.allUsers[i]['email'],phone:controller.allUsers[i]['phone_number']));
                              },
                                child: const Icon(Icons.mode_edit_outline)
                            ),
                            title: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 15.0,top: 10),
                                child: Text(items['username'],style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),),
                              ),
                            ),
                            subtitle : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(items['full_name'],style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black)),
                                Padding(
                                  padding: const EdgeInsets.only(top:8.0,bottom:8),
                                  child: Text(items['email']),
                                ),
                                Text(items['phone_number']),
                              ],
                            ),
                          trailing: IconButton(
                              onPressed: () {
                                Get.defaultDialog(
                                    buttonColor: primaryColor,
                                    title: "Confirm Delete",
                                    middleText: "Are you sure you want to remove ${controller.allUsers[i]['username']}?",
                                    content: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: RawMaterialButton(
                                              shape: const StadiumBorder(),
                                              fillColor: Colors.red,
                                              onPressed: (){
                                                deleteUser(controller.allUsers[i]['id'].toString());
                                                Get.back();
                                              }, child: const Text("Yes",style: TextStyle(color: Colors.white),)),
                                        ),
                                        const SizedBox(width:10),
                                        Expanded(
                                          child: RawMaterialButton(
                                              shape: const StadiumBorder(),
                                              fillColor: primaryColor,
                                              onPressed: (){Get.back();},
                                              child: const Text("Cancel",style: TextStyle(color: Colors.white),)),
                                        ),
                                      ],
                                    ),
                                  //   cancel: RawMaterialButton(
                                  //       shape: const StadiumBorder(),
                                  //       fillColor: primaryColor,
                                  //       onPressed: (){Get.back();},
                                  //       child: const Text("Cancel",style: TextStyle(color: Colors.white),)),
                                  // confirm: RawMaterialButton(
                                  //     shape: const StadiumBorder(),
                                  //     fillColor: Colors.red,
                                  //     onPressed: (){
                                  //       deleteUser(controller.allUsers[i]['id'].toString());
                                  //       Get.back();
                                  //     }, child: const Text("Yes",style: TextStyle(color: Colors.white),)),
                                );
                              },
                              icon:Image.asset("assets/images/cancel.png",width:40,height:40,fit: BoxFit.cover,)
                          ),

                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,)
                ],
              );
            }
        );
      })
    );
  }
}
