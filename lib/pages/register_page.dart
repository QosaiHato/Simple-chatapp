import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/custom_textfield.dart';
import 'package:chat_app/components/my_Button.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  RegisterPage({super.key, required this.onTap});
  final void Function()? onTap;
  void Register(BuildContext context) {
    final _auth = AuthService();
    if (_passwordController != _confirmPasswordController) {
      try {
        _auth.signUpWithEmailPassword(
            _emailController.text, _passwordController.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("Password don't match!!! "),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
          child: Column(
        children: [
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            "Let's create an account for you",
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary, fontSize: 16),
          ),
          const SizedBox(
            height: 25,
          ),
          CustomTextfield(
            hintText: "Email",
            isPassword: false,
            controller: _emailController,
          ),
          const SizedBox(
            height: 25,
          ),
          CustomTextfield(
            hintText: "Password",
            isPassword: true,
            controller: _passwordController,
          ),
          const SizedBox(
            height: 25,
          ),
          CustomTextfield(
            hintText: "Confirm password",
            isPassword: true,
            controller: _confirmPasswordController,
          ),
          const SizedBox(
            height: 25,
          ),
          MyButton(
            title: "Register",
            onTap: () {
              Register(context);
            },
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              Text(
                "you are a member?",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "  Login here",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
              )
            ],
          )
        ],
      )),
    );
  }
}
