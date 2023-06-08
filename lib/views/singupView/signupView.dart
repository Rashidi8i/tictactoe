// ignore_for_file: body_might_complete_normally_nullable, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tictactoe/controllers/signupController/signupController.dart';
import 'package:tictactoe/res/colors/app_color.dart';
import 'package:tictactoe/res/components/round_button.dart';
import 'package:tictactoe/res/constants/constants.dart';
import 'package:tictactoe/views/login_view/login_view.dart';
// import 'package:tictactoe/views/register/register_view.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final signupController = Get.put(SignupController());
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: Constants.getHeight(context),
        width: Constants.getWidth(context),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('Assets/icons/back_1.jpg'),
                fit: BoxFit.fitHeight)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Signup',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 30,
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'To continue your account',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 20,
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.normal),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                // height: 360.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(12))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: size.height * 0.03),
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            child: TextFormField(
                              controller:
                                  signupController.usernameController.value,
                              focusNode:
                                  signupController.usernameFocusNode.value,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  //Utils.snackBar('Email', 'Enter email');
                                  return 'Enter email';
                                }
                              },
                              decoration: const InputDecoration(
                                  labelText: "Email",
                                  prefixIcon: Icon(Icons.mail)),
                            ),
                          ),
                          SizedBox(height: size.height * 0.03),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            child: Obx(() => TextFormField(
                                  controller:
                                      signupController.passwordController.value,
                                  focusNode:
                                      signupController.passwordFocusNode.value,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      //Utils.snackBar('Email', 'Enter email');
                                      return 'Enter Password';
                                    }
                                  },
                                  decoration: InputDecoration(
                                      labelText: "Password",
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          signupController
                                                  .isPasswordHide.value =
                                              !signupController
                                                  .isPasswordHide.value;
                                        },
                                        icon: Icon(signupController
                                                .isPasswordHide.value
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                      ),
                                      prefixIcon: const Icon(Icons.lock)),
                                  obscureText:
                                      signupController.isPasswordHide.value,
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Container(
                        // alignment: Alignment.centerRight,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        child: Obx(() => RoundButton(
                              loading: signupController.loading.value,
                              title: 'SignUp',
                              onPress: () {
                                signupController.signup();
                              },
                              width: double.infinity,
                            ))),
                    Container(
                      // alignment: Alignment.centerRight,
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: GestureDetector(
                        onTap: () => {
                          Get.to(() => const LoginView(email: ''),
                              transition: Transition.rightToLeftWithFade,
                              duration: const Duration(milliseconds: 450))
                        },
                        child: const Text(
                          "Already Have an Account? login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColor.secondaryTextColor),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
