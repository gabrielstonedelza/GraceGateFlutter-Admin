import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gracegatechapel/views/admin_bottomnavigationbar.dart';
import 'package:http/http.dart' as http;
import '../constants/app_colors.dart';
import '../controllers/userController.dart';

class EditMember extends StatefulWidget {
  final id;
  final username;
  final fullName;
  final email;
  final phone;
  const EditMember({Key? key,required this.id,required this.username,required this.fullName,required this.email,required this.phone}) : super(key: key);

  @override
  State<EditMember> createState() => _EditMemberState(id:this.id,username:this.username,fullName:this.fullName,email:this.email,phone:this.phone);
}

class _EditMemberState extends State<EditMember> {
  final id;
  final username;
  final fullName;
  final email;
  final phone;
  _EditMemberState({required this.id,required this.username,required this.fullName,required this.email,required this.phone});

  UserController userController = Get.find();

  final storage = GetStorage();
  late String uToken = "";

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _usernameController;
  late final TextEditingController _fullNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;

  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _fullNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();

  updateProfileDetails() async {
    const updateUrl = "https://havenslearningcenter.xyz/update_username/";
    final myUrl = Uri.parse(updateUrl);
    http.Response response = await http.put(
      myUrl,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $uToken"
      },
      body: {
        "username": _usernameController.text.trim(),
        "email": _emailController.text.trim(),
        "full_name": _fullNameController.text.trim(),
        "phone_number": _phoneController.text.trim()
      },
    );
    if (response.statusCode == 200) {
      Get.snackbar("Hurray 😀", "Your profile was updated",
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: primaryColor,
          colorText: defaultTextColor1);
      Get.offAll(const AdminBottomNavigationBar());

    } else {
      Get.snackbar("Sorry 😢", response.body,
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: defaultTextColor1);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (storage.read("userToken") != null) {
      uToken = storage.read("userToken");
    }

    _usernameController = TextEditingController(text:username);
    _fullNameController = TextEditingController(text:fullName);
    _phoneController = TextEditingController(text: phone);
    _emailController = TextEditingController(text: email);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _usernameController.dispose();
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit $username's details")
      ),
      body: ListView(
        children: [
          const SizedBox(height:20),
          Padding(
            padding: const EdgeInsets.only(left: 18.0,right: 18),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _usernameController,
                    focusNode: _usernameFocusNode,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.person,
                          color: defaultTextColor2,
                        ),
                        labelText:
                        "Username",
                        labelStyle:
                        const TextStyle(
                            color:
                            muted),
                        focusColor:
                        muted,
                        fillColor:
                        muted,
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color:
                                muted,
                                width:
                                2),
                            borderRadius:
                            BorderRadius.circular(
                                12)),
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(12))),
                    // cursorColor: Colors.black,
                    // style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter username";
                      }
                      else{
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _fullNameController,
                    focusNode: _fullNameFocusNode,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.person,
                            color: defaultTextColor2,
                          ),
                          labelText:
                          "Full Name",
                          labelStyle:
                          const TextStyle(
                              color:
                              muted),
                          focusColor:
                          muted,
                          fillColor:
                          muted,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color:
                                  muted,
                                  width:
                                  2),
                              borderRadius:
                              BorderRadius.circular(
                                  12)),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(12))),
                    cursorColor: defaultTextColor2,
                    style: const TextStyle(color: defaultTextColor2),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter full name";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            FontAwesomeIcons.envelope,
                            color: defaultTextColor2,
                          ),
                          labelText:
                          "Email",
                          labelStyle:
                          const TextStyle(
                              color:
                              muted),
                          focusColor:
                          muted,
                          fillColor:
                          muted,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color:
                                  muted,
                                  width:
                                  2),
                              borderRadius:
                              BorderRadius.circular(
                                  12)),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(12))),
                    cursorColor: defaultTextColor2,
                    style: const TextStyle(color: defaultTextColor2),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter your email address";
                      }
                      else{
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _phoneController,
                    focusNode: _phoneNumberFocusNode,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            FontAwesomeIcons.phone,
                            color: defaultTextColor2,
                          ),
                          labelText:
                          "Phone Number",
                          labelStyle:
                          const TextStyle(
                              color:
                              muted),
                          focusColor:
                          muted,
                          fillColor:
                          muted,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color:
                                  muted,
                                  width:
                                  2),
                              borderRadius:
                              BorderRadius.circular(
                                  12)),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(12))),
                    cursorColor: defaultTextColor2,
                    style: const TextStyle(color: defaultTextColor2),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter correct phone number ";
                      }
                      if(value.length < 10){
                        return "Enter correct phone number";
                      }
                      else{
                        return null;
                      }
                    },
                  ),

                ],
              ),
            ),
          ),
          const SizedBox(height:20),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: RawMaterialButton(onPressed: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
              // updateProfileDetails();
            },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                ),
                elevation: 8,
                fillColor: primaryColor,
                splashColor: splashColor,
              child: const Text("Update",style:TextStyle(fontWeight: FontWeight.bold,fontSize:20,color:defaultTextColor1))
            ),
          )
        ],
      )
    );
  }
}
