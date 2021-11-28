import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TextFieldType { email, password, username, confirm }

class ModernTextField extends StatefulWidget {
  const ModernTextField({
    Key? key,
    required this.textFieldType,
    this.keyboardType = TextInputType.name,
    this.inputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.controller,
    this.validator,
    this.focusNode,
    this.isEnabled = true,
  }) : super(key: key);

  final TextFieldType textFieldType;
  final TextInputType keyboardType;

  final bool isEnabled;

  final FocusNode? focusNode;

  final void Function(BuildContext context)? onFieldSubmitted;

  final TextInputAction inputAction;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  State<ModernTextField> createState() => _ModernTextFieldState();
}

class _ModernTextFieldState extends State<ModernTextField> {
  bool activateValidator = false;

  bool textChanged = false;

  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.black,
            ),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 16.w, bottom: 10.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.grey[200]),
        child: Focus(
          skipTraversal: true,
          onFocusChange: (value) {
            if (textChanged && !activateValidator) {
              setState(() {
                activateValidator = true;
              });
            }
          },
          child: TextFormField(
            focusNode: widget.focusNode,
            keyboardType: widget.keyboardType,
            onChanged: (value) {
              textChanged = true;
            },
            onFieldSubmitted: (value) {
              if (widget.onFieldSubmitted != null) {
                FocusScope.of(context).unfocus();
                widget.onFieldSubmitted!(context);
              }
            },
            validator: widget.validator,
            controller: widget.controller,
            cursorColor: Colors.grey,
            textInputAction: widget.inputAction,
            obscureText: (() {
              if ((widget.textFieldType == TextFieldType.password) ||
                  (TextFieldType.confirm == widget.textFieldType)) {
                return isObscure;
              }
              return false;
            }()),
            autovalidateMode: activateValidator
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            decoration: InputDecoration(
              enabled: widget.isEnabled,
              errorMaxLines: 2,
              suffixIcon: (() {
                Widget visibilityIcon = IconButton(
                  splashRadius: 1.r,
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: Icon(
                    isObscure ? Icons.visibility_off : Icons.visibility,
                  ),
                );
                switch (widget.textFieldType) {
                  case TextFieldType.email:
                    return const Icon(Icons.email);
                  case TextFieldType.username:
                    return const Icon(Icons.person);
                  case TextFieldType.password:
                    return visibilityIcon;
                  case TextFieldType.confirm:
                    return visibilityIcon;
                  default:
                }
              }()),
              focusColor: Colors.red,
              labelText: (() {
                switch (widget.textFieldType) {
                  case TextFieldType.email:
                    return 'Email';
                  case TextFieldType.username:
                    return 'Username';
                  case TextFieldType.password:
                    return 'Password';
                  case TextFieldType.confirm:
                    return 'Confirm';

                  default:
                }
              }()),
              border: InputBorder.none,
              floatingLabelStyle: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              labelStyle: const TextStyle(
                  color: Colors.black38, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
