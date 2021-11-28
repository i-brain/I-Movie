import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:i_movie/bloc/login/login_cubit.dart';
import 'package:i_movie/presentation/core/const.dart';
import 'package:i_movie/data/models/user.dart';
import 'package:i_movie/presentation/core/dialogs.dart';
import 'package:i_movie/presentation/core/locator.dart';
import 'package:i_movie/presentation/widgets/modern_text_field.dart';

class LogInPage extends StatelessWidget {
  LogInPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: BlocBuilder<LoginCubit, LoginState>(
                  buildWhen: (previous, current) {
                    if (current is LoginSuccess) {
                      Navigator.pushNamed(context, homeRouteName);
                    }

                    if (current is LoginError) {
                      Dialogs.showErrorDialog(context, current.errorMessage);
                    }
                    return true;
                  },
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Log in',
                          style: TextStyle(
                              fontSize: 45.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 45.h,
                        ),
                        ModernTextField(
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
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          textFieldType: TextFieldType.email,
                          isEnabled: state is! LoginLoading,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        ModernTextField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field is required!';
                            }
                            if (value.length < 6) {
                              return 'Should be at least 6 characters!';
                            }

                            return null;
                          },
                          onFieldSubmitted: onLoginPressed,
                          textFieldType: TextFieldType.password,
                          controller: passwordController,
                          inputAction: TextInputAction.done,
                          isEnabled: state is! LoginLoading,
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Ink(
                          height: 60.h,
                          decoration: BoxDecoration(
                            color: state is LoginLoading
                                ? Colors.black45
                                : Colors.black,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: InkWell(
                            splashColor: Colors.grey,
                            borderRadius: BorderRadius.circular(16.r),
                            onTap: state is LoginLoading
                                ? null
                                : () => onLoginPressed(context),
                            child: Center(
                              child: state is LoginLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'Log In',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                      ),
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
                            const Text('Don\'t have an account?'),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, 'signUp');
                              },
                              child: const Text('Sign Up'),
                            )
                          ],
                        )
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

  void onLoginPressed([BuildContext? context]) async {
    if (_formKey.currentState!.validate()) {
      await BlocProvider.of<LoginCubit>(context!).login(
        User(
            username: 'username',
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
