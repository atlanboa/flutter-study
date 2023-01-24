import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_completion/resources/auth_methods.dart';
import 'package:instagram_completion/responsive/respoonsive_layout_screen.dart';
import 'package:instagram_completion/screens/sign_up_screen.dart';
import 'package:instagram_completion/utils/colors.dart';
import 'package:instagram_completion/widgets/text_field_input.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    setState(() {
      isLoading = false;
    });
    if (res != 'success') {
      if (!mounted) return;
      showSnackBar(res, context);
    } else {
      if (!mounted) return;
      showSnackBar(res, context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            );
          },
        ),
      );
    }
  }

  void navigatorToSignUp() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const SignUpScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.25),
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64.0,
              ),
              SizedBox(height: size.height * 0.05),
              TextFieldInput(
                hintText: 'Enter Your Email',
                controller: _emailController,
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: size.height * 0.02),
              TextFieldInput(
                hintText: 'Enter Your Password',
                controller: _passwordController,
                textInputType: TextInputType.text,
                isPassword: true,
              ),
              SizedBox(height: size.height * 0.02),
              SizedBox(
                width: double.infinity,
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: loginUser,
                        child: const Text('Login'),
                      ),
              ),
              SizedBox(height: size.height * 0.02),
              Flexible(child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: navigatorToSignUp,
                    child: const Text('Sign Up'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
