import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotHaveAccountSignup extends StatelessWidget {
  const NotHaveAccountSignup({
    Key key,
    @required this.onTap,
    this.whiteBackground = false,
  }) : super(key: key);

  final VoidCallback onTap;
  final bool whiteBackground;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Não tenho conta.',
          style: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: whiteBackground ? const Color(0xFF010A53) : Colors.white,
          ),
        ),
        const SizedBox(width: 4),
        InkWell(
          onTap: onTap,
          child: Text(
            'Cadastrar',
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF00B2FF),
            ),
          ),
        ),
      ],
    );
  }
}
