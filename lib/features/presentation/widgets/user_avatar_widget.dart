import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/colors/app_colors.dart';
import 'package:news_app/features/presentation/blocs/auth_bloc/auth_bloc.dart';

class UserAvatarWidget extends StatelessWidget {
  const UserAvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          final email = state.user!.email!;
          return CircleAvatar(
            radius: 20,
            backgroundColor: AvatarColorHelper.getColor(email),
            child: Text(
              email.substring(0, 1).toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
