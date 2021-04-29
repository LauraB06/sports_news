import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Masks {
  static MaskTextInputFormatter date() {
    return MaskTextInputFormatter(mask: '##/##/####');
  }
}
