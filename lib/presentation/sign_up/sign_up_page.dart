import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:i_movie/bloc/sign_up/sign_up_cubit.dart';
import 'package:i_movie/presentation/core/const.dart';
import 'package:i_movie/data/models/user.dart';
import 'package:i_movie/presentation/core/locator.dart';

import '../widgets/modern_text_field.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: BlocBuilder<SignUpCubit, SignUpState>(
                  buildWhen: (previous, current) {
                    if (current is SignUpSuccess) {
                      Navigator.pushReplacementNamed(context, homeRouteName);
                    }

                    if (current is SignUpError) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(current.errorMessage),
                        ),
                      );
                    }
                    return true;
                  },
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 45.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          'Let\'s create your account',
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.black26,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        ModernTextField(
                          controller: usernameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field is required!';
                            }
                            if (value.length < 3) {
                              return 'Should be at least 3 characters';
                            }
                            return null;
                          },
                          textFieldType: TextFieldType.username,
                          isEnabled: state is! SignUpLoading,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        ModernTextField(
                          keyboardType: TextInputType.emailAddress,
                          textFieldType: TextFieldType.email,
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field is required!';
                            }
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return 'Email is not valid!';
                            }
                            return null;
                          },
                          isEnabled: state is! SignUpLoading,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ModernTextField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'This field is required!';
                                  }
                                  if (value.length < 6) {
                                    return 'Should be at least 6 characters!';
                                  }

                                  return null;
                                },
                                controller: passwordController,
                                textFieldType: TextFieldType.password,
                                onFieldSubmitted: (context) =>
                                    focusNode.requestFocus(),
                                isEnabled: state is! SignUpLoading,
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Expanded(
                              child: ModernTextField(
                                controller: confirmController,
                                focusNode: focusNode,
                                onFieldSubmitted: onSignUpPressed,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'This field is required!';
                                  }
                                  if (passwordController.text !=
                                      confirmController.text) {
                                    return 'Passwords doesn\'t match!';
                                  }
                                  return null;
                                },
                                textFieldType: TextFieldType.confirm,
                                inputAction: TextInputAction.done,
                                isEnabled: state is! SignUpLoading,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Ink(
                          height: 60.h,
                          decoration: BoxDecoration(
                            color: state is SignUpLoading
                                ? Colors.black45
                                : Colors.black,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: InkWell(
                            splashColor: Colors.grey,
                            borderRadius: BorderRadius.circular(16.r),
                            onTap: state is SignUpLoading
                                ? null
                                : () => onSignUpPressed(context),
                            child: Center(
                              child: state is SignUpLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18.sp),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account?'),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, loginRouteName);
                              },
                              child: const Text('Log In'),
                            )
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSignUpPressed([BuildContext? context]) async {
    if (_formKey.currentState!.validate()) {
      await BlocProvider.of<SignUpCubit>(context!).signUp(
        User(
            username: usernameController.text,
            email: emailController.text,
            password: passwordController.text),
      );

      registerCurrentUserSingleton(emailController.text);

      Hive.box('auth').put(
        'lastUser',
        User(
          email: emailController.text,
          password: passwordController.text,
        ),
      );
    }
  }
}
