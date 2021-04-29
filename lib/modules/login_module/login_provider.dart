import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sports_news/core/auth.dart';
import 'package:sports_news/modules/home_module/home_provider.dart';
import 'package:sports_news/modules/home_module/pages/home_page.dart';
import 'package:sports_news/modules/login_module/blocs/login_bloc_states.dart';
import 'package:sports_news/modules/login_module/pages/login_initial.page.dart';
import 'package:sports_news/shared/repositories/heroku/login_repository_heroku.dart';
import 'package:sports_news/shared/services/login_service.dart';

import 'blocs/login_bloc.dart';

class LoginProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (BuildContext context) => LoginBloc(
        loginService: LoginService(
          loginRepository: LoginRepositoryHeroku(
            auth: GetIt.instance.get<Auth>(),
          ),
        ),
      ),
      child: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginBlocState>(
      listener: (BuildContext context, LoginBlocState state) {
        if (state is LoginBlocStateSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute<HomeProvider>(
              builder: (BuildContext _) => HomeProvider(),
            ),
          );
        }
      },
      builder: (BuildContext context, LoginBlocState state) {
        return LoginInitialPage(bloc: context.read<LoginBloc>());
      },
    );
  }
}
