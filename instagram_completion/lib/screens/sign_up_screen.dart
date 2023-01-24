import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_completion/resources/auth_methods.dart';
import 'package:instagram_completion/screens/login_screen.dart';
import 'package:instagram_completion/utils/colors.dart';
import 'package:instagram_completion/utils/utils.dart';
import 'package:instagram_completion/widgets/text_field_input.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/respoonsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );
    setState(() {
      isLoading = false;
    });
    if (res != 'success') {
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
    } else {
      if (!mounted) return;
      showSnackBar(res, context);
    }
  }

  void navigatorToLogin() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const LoginScreen();
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
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64.0,
              ),
              SizedBox(height: size.height * 0.05),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64.0,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64.0,
                          backgroundImage:
                              NetworkImage("https://picsum.photos/200"),
                        ),
                  Positioned(
                    bottom: -10.0,
                    left: 80.0,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              TextFieldInput(
                hintText: 'Enter Your Username',
                controller: _usernameController,
                textInputType: TextInputType.text,
              ),
              SizedBox(height: size.height * 0.02),
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
              TextFieldInput(
                hintText: 'Enter Your Bio',
                controller: _bioController,
                textInputType: TextInputType.text,
              ),
              SizedBox(height: size.height * 0.02),
              SizedBox(
                width: double.infinity,
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: signUpUser,
                        child: const Text('Sign Up'),
                      ),
              ),
              SizedBox(height: size.height * 0.02),
              Flexible(child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Do you have an account?'),
                  TextButton(
                    onPressed: navigatorToLogin,
                    child: const Text('Login'),
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
