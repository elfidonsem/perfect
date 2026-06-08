import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:perfect/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:perfect/features/auth/presentation/bloc/auth_state.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AuthCheckConnectionState) {
          Text("Erreur!");
        }
        if (state is AuthLoadingState) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (state is AuthAuthenticatedState) {
          context.push("/homePage");
        }
        if (state is AuthUnauthenticatedState) {
          context.push("/loginWithGoogle");
        }
        return Scaffold(
          body: Center(
            child: TextButton(
              onPressed: () {
                context.push("/loginWithGoogle");
              },
              child: Text("Aller dans login"),
            ),
          ),
        );
      },
    );
  }
}
