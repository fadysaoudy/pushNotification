// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:push_notification/screens/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late SharedPreferences prefs;

  final _formKey = GlobalKey<FormBuilderState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _loginFocusNode = FocusNode();

  bool _emailNameError = false;
  bool _passwordNameError = false;
  bool _value = false;

  @override
  void initState() {
    super.initState();

    retrieve();
    _emailFocusNode.requestFocus();
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
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: ListView(
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
                    EmailTextField(
                        emailFocusNode: _emailFocusNode,
                        emailController: _emailController),
                    const SizedBox(height: 20),
                    PasswordTextField(
                        loginFocusNode: _loginFocusNode,
                        passwordFocusNode: _passwordFocusNode,
                        emailNameError: _emailNameError,
                        pass_valid: pass_valid,
                        passwordController: _passwordController),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Checkbox(
                          value: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                            });
                            if (value!) {
                              save();
                            }
                          },
                          activeColor: Colors.green,
                        ),
                        MaterialButton(
                          focusNode: _loginFocusNode,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  save() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("email", _emailController.text.toString());
    prefs.setString("password", _passwordController.text.toString());
  }

  retrieve() async {
    prefs = await SharedPreferences.getInstance();
    _emailController.text = prefs.getString("email") ?? '';
    _passwordController.text = prefs.getString("password") ?? '';
  }

  delete() async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove("email");
    _emailController.text = '';
    prefs.remove("password");
    _passwordController.text = '';
  }
}
