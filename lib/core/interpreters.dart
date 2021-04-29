class Interpreters {
  static String timeDelta(DateTime instant) {
    final Duration timeDelta = DateTime.now().difference(instant);

    const String compl = 'atrás';

    if (timeDelta.inSeconds < 60) {
      return '${timeDelta.inSeconds} segundos $compl';
    } else if (timeDelta.inMinutes < 60) {
      return '${timeDelta.inMinutes} minutos $compl';
    } else if (timeDelta.inHours < 24) {
      return '${timeDelta.inHours} horas $compl';
    } else if (timeDelta.inDays < 30) {
      return '${timeDelta.inDays} dias $compl';
    } else {
      return '${(timeDelta.inDays / 30).floor()} mêses $compl';
    }
  }
}
