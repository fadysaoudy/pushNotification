// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var options = ["Option 1", "Option 2", "Option 3"];
  final RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  bool _emailNameError = false;
  bool _passwordNameError = false;
  @override

  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("data"),
      ),
      body: ListView(
        children: [
          SizedBox(
            width: width,
            height: height * 0.2,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilder(
              autoFocusOnValidationFailure: true,
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  FormBuilderTextField(
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
                            gapPadding: 10,
                            borderRadius: BorderRadius.circular(10)),
                        hintStyle: const TextStyle(color: Colors.blueGrey),
                        hintText: "User@gmail.com",
                        label: const Text("Email"),
                        prefixIcon: const Icon(Icons.email_outlined)),
                  ),
                  const SizedBox(height: 20),
                  FormBuilderTextField(
                    enabled: true,
                    focusNode: _passwordFocusNode,
                    onSubmitted: (value) {
                      if (!_emailNameError) {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      }
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
                            gapPadding: 10,
                            borderRadius: BorderRadius.circular(10)),
                        hintStyle: const TextStyle(color: Colors.blueGrey),
                        hintText: "******",
                        label: const Text("Password"),
                        prefixIcon: const Icon(Icons.password)),
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                    color: Theme.of(context).colorScheme.secondary,
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate()) {
                        print(_emailController.text);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
