import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:news_app/features/presentation/pages/main_page.dart';
import 'package:news_app/locator.dart';

import 'auth_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot){
        if(snapshot.hasData){
          locator<AuthBloc>().add(GetCurrentUserEvent());
          return MainPage();
        }else{
          return AuthPage();
        }
      }),
    );
  }
}
