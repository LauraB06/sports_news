import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SolidAppBar extends AppBar {
  SolidAppBar({
    @required String title,
    String subtitle,
    Color backgroundColor = const Color(0xFF010A53),
    List<Widget> actions,
    VoidCallback onCancel,
  }) : super(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: GoogleFonts.roboto(
                  fontSize: subtitle == null ? 17 : 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              if (subtitle != null)
                Text(
                  subtitle,
                  style: GoogleFonts.roboto(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                )
            ],
          ),
          brightness: Brightness.dark,
          leading: onCancel != null ? IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: onCancel,
          ) : null,
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: backgroundColor,
          actions: actions,
        );
}
