class Validators {
  static String passwordValidator(String value) {
    if (value == '') {
      return 'Por favor, digite uma senha!';
    }
    return null;
  }

  static String emailValidator(String value) {
    if (value == '') {
      return 'Por favor, digite um e-mail!';
    }
    if (value.isNotEmpty && (!value.contains('@') || !value.contains('.'))) {
      return 'Por favor, insira um e-mail válido!';
    }

    return null;
  }

  static String dateValidator(String value) {
    return value.length < '##/##/####'.length
        ? 'Por favor insira uma data válida! (Formato: ##/##/####)'
        : null;
  }
}
