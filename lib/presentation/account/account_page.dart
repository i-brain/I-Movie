import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_movie/bloc/account/account_cubit.dart';
import 'package:i_movie/data/models/user.dart';
import 'package:i_movie/presentation/account/widgets/account_text_field.dart';
import 'package:i_movie/presentation/account/widgets/logout_button.dart';
import 'package:i_movie/presentation/account/widgets/profile_picture.dart';
import 'package:i_movie/presentation/account/widgets/save_button.dart';
import 'package:i_movie/presentation/core/dialogs.dart';
import 'package:i_movie/presentation/core/locator.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    User currentUser = getIt.get<User>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: SingleChildScrollView(
            child: DefaultTextStyle(
              style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              child: Form(
                key: _formKey,
                child: Focus(
                  child: Column(
                    children: [
                      const Text('Profile'),
                      SizedBox(
                        height: 40.h,
                      ),
                      const ProfilePicture(),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(currentUser.username!),
                      SizedBox(
                        height: 20.h,
                      ),
                      Divider(
                        height: 20.h,
                        thickness: 1,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.person)),
                        controller:
                            TextEditingController(text: currentUser.email),
                        enabled: false,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      AccountTextField(
                        controller: _passwordController,
                        validator: (text) {
                          if (_passwordController.text.length < 6) {
                            return 'Should be at least 6 characters';
                          }
                        },
                        hintText: 'New Password',
                        onEditingComplete: () => _focusNode.requestFocus(),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      AccountTextField(
                        controller: _confirmController,
                        focusNode: _focusNode,
                        validator: (text) {
                          if (text != _passwordController.text) {
                            return 'Passwords doesn\'t match';
                          }
                        },
                        hintText: 'Confirm Password',
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: SaveButton(
                          onTap: () => _onSaveTap(context),
                        ),
                      ),
                      Divider(
                        height: 25.h,
                        thickness: 1,
                      ),
                      const LogoutButton(),
                      BlocListener<AccountCubit, AccountState>(
                        listener: (context, state) {
                          if (state is AccountLoading) {
                            Dialogs.showProgressDialog(context: context);
                          }
                          if (state is AccountSuccess) {
                            _passwordController.clear();
                            _confirmController.clear();
                            Navigator.pop(context);
                            Dialogs.showFlushbar(
                              context: context,
                              message: 'Password changed',
                              color: Colors.black,
                              duration: const Duration(seconds: 2),
                            );
                          }
                          if (state is AccountError) {
                            Navigator.pop(context);

                            Dialogs.showErrorDialog(
                              context,
                              'Couldn\'t change password. Try again later',
                            );
                          }
                        },
                        child: const SizedBox(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onSaveTap(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AccountCubit>().updatePassword(_confirmController.text);
    }
  }
}
