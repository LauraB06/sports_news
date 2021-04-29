import 'package:catcher/catcher.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_news/modules/login_module/blocs/login_bloc_events.dart';
import 'package:sports_news/modules/login_module/blocs/login_bloc_states.dart';
import 'package:sports_news/shared/services/login_service.dart';

class LoginBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  LoginBloc({@required this.loginService}) : super(LoginBlocStateInitial());

  final LoginService loginService;

  @override
  void onEvent(LoginBlocEvent event) {
    print('[LoginBloc] event: $event');
    super.onEvent(event);
  }

  @override
  Stream<LoginBlocState> mapEventToState(LoginBlocEvent event) async* {
    yield LoginBlocStateLoading();
    switch (event.runtimeType) {
      case LoginBlocEventSignUp:
        final LoginBlocEventSignUp convertedEvent =
            event as LoginBlocEventSignUp;
        try {
          final bool success = await loginService.signUp(
            name: convertedEvent.name,
            email: convertedEvent.email,
            password: convertedEvent.password,
          );

          yield success
              ? LoginBlocStateSuccess()
              : LoginBlocStateError(errorCode: 'GenericError');
        } catch (e) {
          if (e is DioError) {
            print('${e.response.data}');
            Catcher.reportCheckedError(
              e.response.data['errors'][0]['message'] ?? e.response.statusCode,
              null,
            );
            yield LoginBlocStateError(errorCode: e.message);
          } else {
            rethrow;
          }
        }
        break;

      case LoginBlocEventLoginWithCredentials:
        final LoginBlocEventLoginWithCredentials convertedEvent =
            event as LoginBlocEventLoginWithCredentials;

        try {
          final bool success = await loginService.signIn(
            email: convertedEvent.email,
            password: convertedEvent.password,
          );

          yield success
              ? LoginBlocStateSuccess()
              : LoginBlocStateError(errorCode: 'GenericError');
        } catch (e) {
          if (e is DioError) {
            Catcher.reportCheckedError(e.message, null);
            yield LoginBlocStateError(errorCode: e.message);
          } else {
            rethrow;
          }
        }
    }
  }
}
