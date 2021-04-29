import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class GenericInput extends StatelessWidget {
  const GenericInput({
    Key key,
    @required this.title,
    this.controller,
    this.inputType = TextInputType.text,
    this.enabled = true,
    this.validator,
    this.onFieldSubmitted,
    this.textInputAction,
    this.obscure = false,
    this.inputFormatters,
  }) : super(key: key);

  final String title;
  final TextEditingController controller;
  final TextInputType inputType;
  final Function(String) onFieldSubmitted;
  final bool enabled;

  final String Function(String) validator;
  final TextInputAction textInputAction;
  final bool obscure;
  final List<TextInputFormatter> inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: GoogleFonts.roboto(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF000634),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: TextFormField(
              keyboardType: inputType,
              enabled: enabled,
              validator: validator,
              controller: controller,
              obscureText: obscure,
              textInputAction: textInputAction,
              onFieldSubmitted: onFieldSubmitted,
              inputFormatters: inputFormatters,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFFF0F0F0),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
