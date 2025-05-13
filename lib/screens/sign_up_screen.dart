import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:note_app1/controllers/sign_up_controller.dart';
import 'package:note_app1/screens/widget/custom_button.dart';
import 'package:note_app1/screens/widget/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                Text(
                  'Create an Account',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Please fill in the details to sign up',
                  style: TextStyle(fontSize: 16.sp),
                ),
                SizedBox(height: 50.h),

                // Email
                Text("Email"),
                SizedBox(height: 5.h),
                CustomTextField(
                  prefixIcon: Icons.email_outlined,
                  hintText: "Enter your email",
                  validator: controller.validateEmail,
                  onChanged: (value) => controller.email.value = value,
                ),
                SizedBox(height: 20.h),

                // Username
                Text("Username"),
                SizedBox(height: 5.h),
                CustomTextField(
                  prefixIcon: Icons.person_outline,
                  hintText: "Enter your username",
                  validator: controller.validateUsername,
                  onChanged: (value) => controller.username.value = value,
                ),
                SizedBox(height: 20.h),

                // Password
                Text("Password"),
                SizedBox(height: 5.h),
                Obx(
                  () => CustomTextField(
                    prefixIcon: Icons.lock_outline,
                    hintText: "Enter your password",
                    obscureText: controller.obscurePassword.value,
                    suffixIcon:
                        controller.obscurePassword.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                    suffixIconOnPressed: controller.togglePasswordVisibility,
                    validator: controller.validatePassword,
                    onChanged: (value) => controller.password.value = value,
                  ),
                ),
                SizedBox(height: 20.h),

                // Confirm Password
                Text("Confirm Password"),
                SizedBox(height: 5.h),
                Obx(
                  () => CustomTextField(
                    prefixIcon: Icons.lock_outline,
                    hintText: "Confirm your password",
                    obscureText: controller.obscureConfirmPassword.value,
                    suffixIcon:
                        controller.obscureConfirmPassword.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                    suffixIconOnPressed:
                        controller.toggleConfirmPasswordVisibility,
                    validator: controller.validateConfirmPassword,
                    onChanged:
                        (value) => controller.confirmPassword.value = value,
                  ),
                ),

                // Sign Up Button
                SizedBox(height: 30.h),
                Obx(
                  () => CustomButton(
                    text: controller.isLoading.value ? "loading..." : "Sign Up",
                    onPressed:
                        controller.isLoading.value ? null : controller.signUp,
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
