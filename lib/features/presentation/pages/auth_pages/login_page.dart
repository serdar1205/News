import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/colors/app_colors.dart';
import 'package:news_app/core/constants/strings/app_strings.dart';
import 'package:news_app/features/domain/usecases/auth_usecases/sign_in_with_email_usecase.dart';
import 'package:news_app/features/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:news_app/features/presentation/widgets/k_textfield.dart';
import 'package:news_app/features/presentation/widgets/main_button.dart';
import '../../widgets/dialog_widget.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;

  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isSubmitted = false;

  bool validate() {
    bool isValid = formKey.currentState?.validate() ?? false;

    if (!isSubmitted) {
      setState(() {
        isSubmitted = true;
      });
    }
    return isValid;
  }

  Future signIn() async {
    if (validate()) {
      context.read<AuthBloc>().add(SignInEvent(AuthParams(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          )));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text(
                      AppStrings.welcome,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: KTextField(
                      controller: _emailController,
                      hintText: AppStrings.email,
                      isSubmitted: isSubmitted,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: KTextField(
                      controller: _passwordController,
                      obscureText: true,
                      hintText: AppStrings.password,
                      isSubmitted: isSubmitted,
                    ),
                  ),
                  //sign in button
                  const SizedBox(
                    height: 20,
                  ),
                  BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
                    if (state is Authenticated) {
                    } else if (state is AuthFailure) {
                      dialogWidget(context, state.error);

                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.of(context).pop();
                      });
                    }
                  }, builder: (context, state) {
                    return MainButton(
                      buttonTile: AppStrings.signIn,
                      onPressed: signIn,
                      isLoading: state is AuthLoading,
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          AppStrings.notMember,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: widget.showRegisterPage,
                          child: Text(
                            AppStrings.registration,
                            style: TextStyle(color: AppColors.mainbuttonColor2),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
