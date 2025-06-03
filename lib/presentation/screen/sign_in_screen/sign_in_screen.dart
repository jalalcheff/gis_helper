import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gis_helper/constants/style_constants.dart';
import 'package:gis_helper/presentation/cubit/transformer_number_cubit/transformer_number_cubit.dart';
import 'package:gis_helper/presentation/cubit/user_accountdata_cubit/user_accountdata_cubit.dart';
import 'package:gis_helper/presentation/screen/main_screen/collection_screen.dart';
import 'package:lottie/lottie.dart';

import '../../../di/dependency_injection.dart';
import '../../cubit/all_transfomers_cubit/all_transformers_cubit.dart';
import '../../cubit/feeders_number_cubit/feeders_number_cubit.dart';
import '../../cubit/sign_in_cubit/sign_in_cubit.dart';
import '../../cubit/transformer_number_of_each_sector_cubit/transformer_number_of_each_sector_cubit.dart';
import '../home_screen/home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  StyleConstants styleConstants = StyleConstants();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool areAllFieldsValid = false;
  bool signInClicked = false;

  @override
  void initState() {
    super.initState();
    //context.read<SignInCubit>().emitSignInInitial();
    emailController.addListener(_updateFieldsValidity);
    passwordController.addListener(_updateFieldsValidity);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _updateFieldsValidity() {
    final isValid = emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    if (areAllFieldsValid != isValid) {
      setState(() {
        areAllFieldsValid = isValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<SignInCubit, SignInState>(
            builder: (context, state) {
              switch (state) {
                case SignInInitial() :
              // No need to call _build_sign_in_screen() here, it's returned below
                  break;
                case SignInLoading() :
                  return  Center(
                    child: Center(child: Lottie.asset("images/lottie.json")),
                  );
                case SignInSuccess():
                  {
                    // Use addPostFrameCallback to navigate after the build is complete
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                       Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) =>
                            BlocProvider(
                              create: (context) => locator<UserAccountdataCubit>(),
                              child: CollectionScreen(),
                            )));
                    });
                    print("success in sign in ${state.message}");
                    // Return a placeholder or loading indicator while navigating
                    return _buildSignInScreen();;
                  }
                case SignInError():
                  {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("خطا في تسجيل الدخول"))
                      );
                    });
                    // Return the sign in screen after showing the error
                    return _buildSignInScreen();
                  }
              }
              // Default case for SignInInitial or other states that should show the form
              return _buildSignInScreen();
            }
        )
    );
  }

  SingleChildScrollView _buildSignInScreen() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsetsDirectional.all(styleConstants.extraLargeDp),
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("images/sign_in_icon.png", height: 320),
            SizedBox(height: styleConstants.largeDp,),
            _textFormField(
                "البريد الالكتروني", emailController, "ادخل البريد الالكتروني"),
            SizedBox(height: styleConstants.extraLargeDp,),
            _textFormField(
                "كلمة المرور", passwordController, "ادخل كلمة المرور"),
            // Expanded(child: Container()),
            SizedBox(height: styleConstants.extraLargeDp,),
            BlocProvider(
              create: (context) => locator<SignInCubit>(),
              child: _signInButton(),
            ),
            SizedBox(height: styleConstants.extraLargeDp,),
          ],
        ),
      ),
    );
  }

  Column _textFormField(String label, TextEditingController controller,
      String hint) {
    return Column(
      children: [
        Align(
            alignment: Alignment.topRight,
            child: Text(label,
                style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.black))),
        TextField(
          textDirection: TextDirection.rtl,
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(styleConstants.extraLargeDp),
              borderSide: BorderSide(
                  color: Color(styleConstants.colorLightGrey),
                  width: styleConstants.smallDp),
            ),
            hintText: hint,
            hintStyle: Theme
                .of(context)
                .textTheme
                .titleMedium
                ?.copyWith(
                color: Color(styleConstants.colorBlack).withOpacity(0.35)),
            hintTextDirection: TextDirection.rtl,
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(styleConstants.extraLargeDp),
              borderSide: BorderSide(
                  color: Color(styleConstants.colorLightGrey),
                  width: styleConstants.smallDp),
            ),
          ),
        ),
      ],
    );
  }

  MaterialButton _signInButton() {
    return MaterialButton(
      onPressed: !areAllFieldsValid
          ? () {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("الرجاء ملء جميع الحقول"))
        );
      }
          : () {
        context.read<SignInCubit>().emitSignIn(
            emailController.text, passwordController.text);
        // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      },
      color: areAllFieldsValid
          ? Color(styleConstants.colorBlack)
          : Colors.grey[600],
      minWidth: MediaQuery
          .of(context)
          .size
          .width,
      padding: EdgeInsets.symmetric(
          vertical: styleConstants.extraLargeDp),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              styleConstants.extraLargeDp)),
      child: Text(
        "تسجل الدخول",
        style: Theme
            .of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: Color(styleConstants.colorWhite)),
      ),
    );
  }
}
