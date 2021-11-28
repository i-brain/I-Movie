import 'package:flutter/material.dart';

class AccountTextField extends StatefulWidget {
  const AccountTextField({
    Key? key,
    required this.controller,
    this.validator,
    required this.hintText,
    this.textInputAction = TextInputAction.next,
    this.focusNode,
    this.onEditingComplete,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final void Function()? onEditingComplete;
  final String hintText;

  @override
  State<AccountTextField> createState() => _AccountTextFieldState();
}

class _AccountTextFieldState extends State<AccountTextField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.black,
            ),
      ),
      child: TextFormField(
        onEditingComplete: widget.onEditingComplete,
        controller: widget.controller,
        focusNode: widget.focusNode,
        validator: widget.validator,
        textInputAction: widget.textInputAction,
        obscureText: isObscure,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: widget.hintText,
          suffixIcon: IconButton(
            splashRadius: 1,
            onPressed: () {
              setState(() {
                isObscure = !isObscure;
              });
            },
            icon: Icon(
              isObscure ? Icons.visibility_off : Icons.visibility,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
