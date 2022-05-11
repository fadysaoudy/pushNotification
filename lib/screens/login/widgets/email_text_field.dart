import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key? key,
    required FocusNode emailFocusNode,
    required TextEditingController emailController,
  })  : _emailFocusNode = emailFocusNode,
        _emailController = emailController,
        super(key: key);

  final FocusNode _emailFocusNode;
  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      focusNode: _emailFocusNode,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.email(errorText: 'Invalid email'),
      ]),
      autovalidateMode: AutovalidateMode.disabled,
      name: "Email",
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              gapPadding: 10, borderRadius: BorderRadius.circular(10)),
          hintStyle: const TextStyle(color: Colors.blueGrey),
          hintText: "User@gmail.com",
          label: const Text("Email"),
          prefixIcon: const Icon(Icons.email_outlined)),
    );
  }
}
