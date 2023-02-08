import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../constants/app_colors.dart';
import 'package:get/get.dart';

import 'admin_bottomnavigationbar.dart';

class AddDevotion extends StatefulWidget {
  const AddDevotion({Key? key}) : super(key: key);

  @override
  State<AddDevotion> createState() => _AddDevotionState();
}

class _AddDevotionState extends State<AddDevotion> {
  final storage = GetStorage();
  late String uToken = "";

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _quotationsController;
  late final TextEditingController _messageController;

  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _quotationsFocusNode = FocusNode();
  final FocusNode _messageFocusNode = FocusNode();

  bool isPosting = false;

  void _startPosting()async{
    setState(() {
      isPosting = true;
    });
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      isPosting = false;
    });
  }

  addDevotion() async {
    const updateUrl = "https://havenslearningcenter.xyz/add_devotion/";
    final myUrl = Uri.parse(updateUrl);
    http.Response response = await http.post(
      myUrl,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $uToken"
      },
      body: {
        "title": _titleController.text.trim(),
        "quotations": _quotationsController.text.trim(),
        "message": _messageController.text.trim(),
      },
    );
    if (response.statusCode == 201) {
      Get.snackbar("Hurray 😀", "devotion was added",
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: primaryColor,
          colorText: defaultTextColor1);
      Get.offAll(const AdminBottomNavigationBar());

    } else {
      print(response.body);
      Get.snackbar("Sorry 😢", response.body,
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: defaultTextColor1);
    }
  }

  @override
  void initState(){
    super.initState();

    if (storage.read("userToken") != null) {
      uToken = storage.read("userToken");
    }

    _titleController = TextEditingController();
    _quotationsController = TextEditingController();
    _messageController = TextEditingController();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new devotion"),
      ),
      body: ListView(
        children: [
          const SizedBox(height:20),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _titleController,
                    focusNode: _titleFocusNode,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.edit,
                          color: defaultTextColor2,
                        ),
                        labelText:
                        "Title",
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
                        return "Enter title";
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
                    controller: _quotationsController,
                    focusNode: _quotationsFocusNode,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.edit,
                          color: defaultTextColor2,
                        ),
                        labelText:
                        "Quotations",
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
                        return "Enter quotations";
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
                    controller: _messageController,
                    focusNode: _messageFocusNode,
                    maxLines: 7,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.edit,
                          color: defaultTextColor2,
                        ),
                        labelText:
                        "Message",
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
                        return "Enter message";
                      }
                      else{
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(height:20),
                isPosting ? const Center(
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 5,
                    backgroundColor: primaryColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.black
                    ),
                  ),
                ) : RawMaterialButton(onPressed: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    _startPosting();
                  if (_formKey.currentState!.validate()) {
                    addDevotion();
                  }


                    // updateProfileDetails();
                  },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                      ),
                      elevation: 8,
                      fillColor: primaryColor,
                      splashColor: splashColor,
                      child: const Text("Add",style:TextStyle(fontWeight: FontWeight.bold,fontSize:20,color:defaultTextColor1))
                  )
                ],
              )
            ),
          )
        ],
      )
    );
  }
}
