import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:http/http.dart' as http;
import '../../constants/app_colors.dart';
import '../../controllers/registration_controller.dart';


class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  MyRegistrationController registerData = Get.find();
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _fullNameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _rePasswordController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _homeAddressController;
  late final TextEditingController _digitalAddressController;
  final _formKey = GlobalKey<FormState>();
  bool isObscured = true;
  bool isPosting = false;
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _fullNameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _rePasswordFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _homeAddressFocusNode = FocusNode();
  final FocusNode _digitalAddressFocusNode = FocusNode();

  registerUser() async {
    const loginUrl = "https://havenslearningcenter.xyz/auth/users/";
    final myLogin = Uri.parse(loginUrl);

    http.Response response = await http.post(myLogin,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {"username": _usernameController.text.trim(),"email":_emailController.text.trim(),"full_name":_fullNameController.text.trim(),"phone_number":_phoneNumberController.text.trim(), "password": _passwordController.text.trim(),"re_password":_rePasswordController.text.trim(),"home_address":_homeAddressController.text.trim(),"digital_address":_digitalAddressController.text.trim()});

    if (response.statusCode == 201) {
      setState(() {
        _usernameController.text = "";
        _emailController.text = "";
        _fullNameController.text = "";
        _passwordController.text = "";
        _rePasswordController.text = "";
        _phoneNumberController.text = "";
        _homeAddressController.text = "";
        _digitalAddressController.text = "";
      });
      Get.snackbar(
          "Success", "member registered successfully",
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: primaryColor,
          duration: const Duration(seconds: 5)
      );
    }
    else {
      Get.snackbar(
          "Error 😢", response.body.toString(),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5)
      );
      return;
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _fullNameController = TextEditingController();
    _passwordController = TextEditingController();
    _rePasswordController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _homeAddressController = TextEditingController();
    _digitalAddressController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
              title: const Text("Add new member")
          ),

          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          height: size.height * 0.08,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                              color: Colors.grey[500]?.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                            child: TextFormField(
                              controller: _usernameController,
                              focusNode: _usernameFocusNode,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: defaultTextColor1,
                                  ),
                                  hintText: "Username",
                                  hintStyle: TextStyle(color: defaultTextColor1)),
                              cursorColor: defaultTextColor1,
                              style: const TextStyle(color: defaultTextColor1),
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
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: size.height * 0.08,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                              color: Colors.grey[500]?.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                            child: TextFormField(
                              controller: _emailController,
                              focusNode: _emailFocusNode,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.envelope,
                                    color: defaultTextColor1,
                                  ),
                                  hintText: "Email",
                                  hintStyle: TextStyle(color: defaultTextColor1)),
                              cursorColor: defaultTextColor1,
                              style: const TextStyle(color: defaultTextColor1),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Enter email";
                                }
                                else{
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: size.height * 0.08,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                              color: Colors.grey[500]?.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                            child: TextFormField(
                              controller: _fullNameController,
                              focusNode: _fullNameFocusNode,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: defaultTextColor1,
                                  ),
                                  hintText: "Full Name",
                                  hintStyle: TextStyle(color: defaultTextColor1)),
                              cursorColor: defaultTextColor1,
                              style: const TextStyle(color: defaultTextColor1),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Enter full name";
                                }
                                else{
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: size.height * 0.08,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                              color: Colors.grey[500]?.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                            child: TextFormField(
                              controller: _phoneNumberController,
                              focusNode: _phoneNumberFocusNode,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.phone,
                                    color: defaultTextColor1,
                                  ),
                                  hintText: "Phone Number",
                                  hintStyle: TextStyle(color: defaultTextColor1)),
                              cursorColor: defaultTextColor1,
                              style: const TextStyle(color: defaultTextColor1),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Enter phone number";
                                }
                                if(value.length < 10){
                                  return "Enter a valid phone number";
                                }
                                else{
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: size.height * 0.08,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                              color: Colors.grey[500]?.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                            child: TextFormField(
                              controller: _homeAddressController,
                              focusNode: _homeAddressFocusNode,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.locationPin,
                                    color: defaultTextColor1,
                                  ),
                                  hintText: "Home Address",
                                  hintStyle: TextStyle(color: defaultTextColor1)),
                              cursorColor: defaultTextColor1,
                              style: const TextStyle(color: defaultTextColor1),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Home Address";
                                }
                                if(value.length < 10){
                                  return "Home Address";
                                }
                                else{
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: size.height * 0.08,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                              color: Colors.grey[500]?.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                            child: TextFormField(
                              controller: _digitalAddressController,
                              focusNode: _digitalAddressFocusNode,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.mapLocation,
                                    color: defaultTextColor1,
                                  ),
                                  hintText: "Digital Address",
                                  hintStyle: TextStyle(color: defaultTextColor1)),
                              cursorColor: defaultTextColor1,
                              style: const TextStyle(color: defaultTextColor1),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              // validator: (value){
                              //   if(value!.isEmpty){
                              //     return "Home Address";
                              //   }
                              //   if(value.length < 10){
                              //     return "Home Address";
                              //   }
                              //   else{
                              //     return null;
                              //   }
                              // },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: size.height * 0.08,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                              color: Colors.grey[500]?.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                            child: TextFormField(
                              controller: _passwordController,
                              focusNode: _passwordFocusNode,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: (){
                                      setState(() {
                                        isObscured = !isObscured;
                                      });
                                    },
                                    icon: Icon(isObscured ? Icons.visibility : Icons.visibility_off,color: defaultTextColor1,),
                                  ),
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(
                                    FontAwesomeIcons.lock,
                                    color: defaultTextColor1,
                                  ),
                                  hintText: "Password",
                                  hintStyle: const TextStyle(color: defaultTextColor1)),
                              cursorColor: defaultTextColor1,
                              style: const TextStyle(color: defaultTextColor1),
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.next,
                              obscureText: isObscured,
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Enter password";
                                }
                                else{
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: size.height * 0.08,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                              color: Colors.grey[500]?.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                            child: TextFormField(
                              controller: _rePasswordController,
                              focusNode: _rePasswordFocusNode,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: (){
                                      setState(() {
                                        isObscured = !isObscured;
                                      });
                                    },
                                    icon: Icon(isObscured ? Icons.visibility : Icons.visibility_off,color: defaultTextColor1,),
                                  ),
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(
                                    FontAwesomeIcons.lock,
                                    color: defaultTextColor1,
                                  ),
                                  hintText: "Retype Password",
                                  hintStyle: const TextStyle(color: defaultTextColor1)),
                              cursorColor: defaultTextColor1,
                              style: const TextStyle(color: defaultTextColor1),
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              obscureText: isObscured,
                              validator: (value){
                                if(value!.isEmpty){
                                  return "confirm password";
                                }
                                else{
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 25,),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: primaryColor
                          ),
                          height: size.height * 0.08,
                          width: size.width * 0.8,
                          child: RawMaterialButton(
                            onPressed: () {
                              FocusScopeNode currentFocus = FocusScope.of(context);

                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }

                              if (_formKey.currentState!.validate()) {
                                registerUser();
                              } else {

                                Get.snackbar("Error", "Something went wrong,check form",
                                    colorText: defaultTextColor1,
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red
                                );
                                return;
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            elevation: 8,
                            fillColor: primaryColor,
                            splashColor: splashColor,
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: defaultTextColor1),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
