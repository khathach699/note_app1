import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:note_app1/screens/widget/button_social_button.dart';
import 'package:note_app1/screens/widget/custom_button.dart';
import 'package:note_app1/screens/widget/custom_text_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.h),
              Text(
                'Welcome to Note App',
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              Text(
                'Please sign in to continue',
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 50.h),
              Text("Email"),
              SizedBox(height: 5.h),
              CustomTextField(
                prefixIcon: Icons.email_outlined,
                hintText: "Enter your email",
              ),
              SizedBox(height: 20.h),
              Text("Password"),
              SizedBox(height: 5.h),
              CustomTextField(
                prefixIcon: Icons.lock_outline,
                hintText: "Enter your password",
                suffixIcon: Icons.visibility_off_outlined,
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (value) {}),
                      Text("Remember me", style: TextStyle(fontSize: 14.sp)),
                    ],
                  ),
                  Spacer(),
                  Text(
                    "Forgot Password?",
                    style: TextStyle(fontSize: 14.sp, color: Colors.blue),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              CustomButton(text: "Sign In"),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey, height: 1.h)),
                    SizedBox(width: 10.w),
                    Text("Or Sign In with"),
                    SizedBox(width: 10.w),
                    Expanded(child: Divider(color: Colors.grey, height: 1.h)),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonSocialCustom(text: "assets/icons/google.png"),
                  SizedBox(width: 10.w),
                  ButtonSocialCustom(text: "assets/icons/facebook.png"),
                ],
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Divider(color: Colors.grey),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  SizedBox(width: 5.w),
                  TextButton(
                    onPressed: () {
                      Get.toNamed('/sign-up');
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
