import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/custom_textfield.dart';
import 'package:chat_app/components/my_Button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginPage({super.key, required this.onTap});
  final void Function()? onTap;
  void Login(BuildContext context) async {
    final authService = AuthService();
    try {
      await authService.signInWithEmailPassword(
          _emailController.text, _passwordController.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
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
            "Welcome back, you've been missed!",
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
            hintText: "Pasword",
            isPassword: true,
            controller: _passwordController,
          ),
          const SizedBox(
            height: 25,
          ),
          MyButton(
            title: "Login",
            onTap: () {
              Login(context);
            },
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              Text(
                "Not a member?",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "  register now",
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
