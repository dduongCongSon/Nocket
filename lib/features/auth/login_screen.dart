import 'package:flutter/material.dart';
import 'package:locket/constants/paths.dart';
import 'package:locket/constants/placeholders.dart';
import 'package:locket/providers/user_provider.dart';
import 'package:locket/features/auth/home_screen.dart';
import 'package:locket/features/auth/signup_screen.dart';
import 'package:locket/utils/colors.dart';
import 'package:locket/utils/global_variable.dart';
import 'package:locket/utils/utils.dart';
import 'package:locket/common_widgets/app_drawer.dart';
import 'package:locket/common_widgets/text_field_input.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    await Provider.of<UserProvider>(context, listen: false).loginUser(
      context,
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    if (Provider.of<UserProvider>(context, listen: false).userLoginResponse != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      if (context.mounted) {
        // showSnackBar(context, "Invalid email or password");
        showFullScreenErrorWithOpacity(
            context, "Invalid email or password, Please try again!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackGroundColorDark,
      drawer: const AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          // Wrap with SingleChildScrollView
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
            ),
            child: Container(
              padding: MediaQuery.of(context).size.width > webScreenSize
                  ? EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 3)
                  : const EdgeInsets.symmetric(horizontal: 32),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                // Center content vertically
                children: [
                  Image.asset(
                    mobileLogo,
                    height: 64,
                  ),
                  const SizedBox(height: 64),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0), // Add margin here
                    child: TextFieldInput(
                      hintText: emailPlaceholder,
                      textInputType: TextInputType.emailAddress,
                      textEditingController: _emailController,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0), // Add margin here
                    child: TextFieldInput(
                      hintText: passwordPlaceholder,
                      textInputType: TextInputType.text,
                      textEditingController: _passwordController,
                      isPass: true,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0), // Add margin here
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ),
                          ),
                          child: const Text(
                            forgotPassword,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: loginUser,
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 16.0), // Add margin here
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        color: primaryColor,
                      ),
                      child: !_isLoading
                          ? const Text(
                              login,
                              style: TextStyle(
                                color: mobileBackGroundColorDark,
                                backgroundColor: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const CircularProgressIndicator(
                              color: primaryColor,
                            ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(notHaveAnAccount,
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        ),
                        child: const Text(
                          signUpHere,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
