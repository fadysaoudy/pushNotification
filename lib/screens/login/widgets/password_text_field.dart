import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    Key? key,
    required FocusNode passwordFocusNode,
    required bool emailNameError,
    required this.pass_valid,
    required TextEditingController passwordController,
    required FocusNode loginFocusNode,
  })  : _passwordFocusNode = passwordFocusNode,
        _emailNameError = emailNameError,
        _passwordController = passwordController,
        _loginFocusNode = loginFocusNode,
        super(key: key);
  final FocusNode _loginFocusNode;
  final FocusNode _passwordFocusNode;
  final bool _emailNameError;
  final RegExp pass_valid;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      enabled: true,
      focusNode: _passwordFocusNode,
      onSubmitted: (value) {
        if (!_emailNameError) {
          FocusScope.of(context).requestFocus(_passwordFocusNode);
        }
        FocusScope.of(context).requestFocus(_loginFocusNode);
      },
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(),
          (val) {
            if (val!.isEmpty) {
              return 'required';
            }
            if (val.length < 8) {
              return 'Min length 8 characters';
            }

            if (pass_valid.hasMatch(val) == false) {
              return 'weak password please use A a . 1';
            }
            return null;
          }
        ],
      ),
      autovalidateMode: AutovalidateMode.disabled,
      name: "Password",
      controller: _passwordController,
      keyboardType: TextInputType.text,
      obscureText: true,
      obscuringCharacter: '*',
      decoration: InputDecoration(
          border: OutlineInputBorder(
              gapPadding: 10, borderRadius: BorderRadius.circular(10)),
          hintStyle: const TextStyle(color: Colors.blueGrey),
          hintText: "******",
          label: const Text("Password"),
          prefixIcon: const Icon(Icons.password)),
    );
  }
}
