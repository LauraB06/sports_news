import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sports_news/modules/login_module/blocs/login_bloc.dart';
import 'package:sports_news/modules/login_module/blocs/login_bloc_events.dart';
import 'package:sports_news/modules/login_module/blocs/login_bloc_states.dart';
import 'package:sports_news/modules/login_module/pages/login_sign_up.page.dart';
import 'package:sports_news/modules/login_module/shared/not_have_account_signup_widget.dart';
import 'package:sports_news/shared/widgets/generic_button_widget.dart';
import 'package:sports_news/shared/widgets/generic_input_widget.dart';
import 'package:sports_news/shared/widgets/solid_app_bar_widget.dart';
import 'package:sports_news/core/validators.dart';

class LoginSignInPage extends StatelessWidget {
  LoginSignInPage({
    Key key,
    @required this.bloc,
  }) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SolidAppBar(
        title: 'Entrar com e-mail',
        onCancel: () => Navigator.of(context).pop(),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraint) =>
              SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: BlocBuilder<LoginBloc, LoginBlocState>(
                cubit: bloc,
                builder: (BuildContext context, LoginBlocState state) {
                  final bool isLoading = state is LoginBlocStateLoading;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SvgPicture.asset('assets/noun_login.svg'),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            GenericInput(
                              title: 'E-mail',
                              controller: _emailController,
                              enabled: !isLoading,
                              inputType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validator: Validators.emailValidator,
                            ),
                            const SizedBox(height: 26),
                            GenericInput(
                              title: 'Senha',
                              controller: _passwordController,
                              enabled: !isLoading,
                              textInputAction: TextInputAction.done,
                              inputType: TextInputType.text,
                              onFieldSubmitted: (String _) => _login(),
                              obscure: true,
                              validator: Validators.passwordValidator,
                            ),
                            const SizedBox(height: 32),
                            GenericButton(
                              title: 'Login',
                              isLoading: isLoading,
                              onPressed: _login,
                              variant: ButtonVariant.dark,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          // GenericButton(
                          //   title: 'Entrar com facebook',
                          //   variant: ButtonVariant.outlineLight,
                          //   onPressed: _loginWithFacebook,
                          // ),
                          const SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 32),
                            child: NotHaveAccountSignup(
                              onTap: () => _doSignUp(context),
                              whiteBackground: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _loginWithFacebook() {
    // TODO
  }

  void _doSignUp(BuildContext context) {
    Navigator.of(context).push<LoginSignUpPage>(
      MaterialPageRoute<LoginSignUpPage>(
        builder: (BuildContext _) => LoginSignUpPage(bloc: bloc),
      ),
    );
  }

  void _login() {
    if (_formKey.currentState.validate()) {
      bloc.add(
        LoginBlocEventLoginWithCredentials(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }
}
