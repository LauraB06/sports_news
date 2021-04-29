import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_news/modules/login_module/blocs/login_bloc.dart';
import 'package:sports_news/modules/login_module/pages/login_sign_in.page.dart';
import 'package:sports_news/modules/login_module/pages/login_sign_up.page.dart';
import 'package:sports_news/modules/login_module/shared/not_have_account_signup_widget.dart';
import 'package:sports_news/shared/widgets/generic_button_widget.dart';

class LoginInitialPage extends StatelessWidget {
  const LoginInitialPage({
    Key key,
    @required this.bloc,
  }) : super(key: key);

  final LoginBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF010A53),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                      width: MediaQuery.of(context).size.width * 0.6,
                    ),
                    child: Image.asset('assets/sports_news_logo.png'),
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                GenericButton(
                  title: 'Entrar com facebook',
                  onPressed: _doSignInWithFacebook,
                  variant: ButtonVariant.outlineLight,
                ),
                GenericButton(
                  title: 'Entrar com e-mail',
                  variant: ButtonVariant.outlineDark,
                  onPressed: () => _doSignInWithEmail(context),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 32),
                  child: NotHaveAccountSignup(onTap: () => _doSignUp(context)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _doSignUp(BuildContext ctx) {
    Navigator.of(ctx).push<LoginSignUpPage>(
      MaterialPageRoute<LoginSignUpPage>(
        builder: (BuildContext _) => LoginSignUpPage(
          bloc: BlocProvider.of<LoginBloc>(ctx),
        ),
      ),
    );
  }

  void _doSignInWithEmail(BuildContext context) {
    Navigator.of(context).push<LoginSignInPage>(
      MaterialPageRoute<LoginSignInPage>(
        builder: (BuildContext _) => LoginSignInPage(bloc: bloc),
      ),
    );
  }

  void _doSignInWithFacebook() {
    // TODO
  }
}
