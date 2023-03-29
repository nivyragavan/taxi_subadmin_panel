import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_subadmin_panel/constant/style.dart';
import 'package:taxi_subadmin_panel/view/dashboard_page.dart';
import 'package:taxi_subadmin_panel/view/home_page.dart';
import 'package:taxi_subadmin_panel/widget/custom_text.dart';

import '../service/api_service.dart';

class AuthenticationPage extends StatefulWidget {
  AuthenticationPage({Key? key}) : super(key: key);

  static const String id = "authentication_page";

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final formKey = GlobalKey<FormState>();

  final email = TextEditingController();

  final password = TextEditingController();

  final box = GetStorage();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Image.asset('assets/icons/logo.png', width: 150),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text("Login",
                        style: GoogleFonts.roboto(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: green)),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CustomText(
                      text: "Welcome back to the sub-admin panel.",
                      color: black,
                      size: 17,
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      labelText: "Email",
                      labelStyle: TextStyle(color: green),
                      hintText: "abc@domain.com",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: green),
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onSaved: (value) {
                    email.text = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty
                    ) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      labelText: "Password",
                      labelStyle: TextStyle(color: green),
                      hintText: "123",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: green),
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onSaved: (value) {
                    password.text = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid password';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () async {
                    if(formKey.currentState!.validate()){
                      if (isLoading) return;
                      setState(() {
                        isLoading = true;
                      });
                      await Future.delayed(const Duration(seconds: 5));
                      setState(() {
                        isLoading = false;
                      });
                      var data = await ApiService().subAdminLogin(email.text, password.text);
                      if(data['statusCode'] == 1){
                        box.write('subadminId', data["body"]["subadminId"]);
                        debugPrint('======${data["body"]["subadminId"]}');
                        Fluttertoast.showToast(msg: 'LoggedIn Successfully');
                        Get.offAll(const DashboardPage());
                      } else{
                        Fluttertoast.showToast(msg: '${data["message"]}');
                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [green, dark]),
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child:isLoading
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 24,
                        ),
                        Text(
                          'Please Wait',
                          style: TextStyle(
                              fontSize: 17, color: Colors.white),
                        )
                      ],
                    )
                        : const CustomText(
                      text: "Login",
                      color: Colors.white,
                      size: 20,
                      weight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
