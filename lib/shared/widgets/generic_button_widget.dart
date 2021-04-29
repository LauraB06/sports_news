import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum ButtonVariant { light, dark, outlineDark, outlineLight }

class GenericButton extends StatelessWidget {
  const GenericButton({
    Key key,
    this.title,
    this.onPressed,
    this.active = true,
    this.variant = ButtonVariant.dark,
    this.isLoading = false,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final bool active;
  final ButtonVariant variant;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Material(
              color: variant == ButtonVariant.dark ||
                      variant == ButtonVariant.outlineDark
                  ? const Color(0xFF010A53)
                  : Colors.white,
              borderRadius: BorderRadius.circular(5),
              child: InkWell(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: variant == ButtonVariant.outlineDark ||
                            variant == ButtonVariant.outlineLight
                        ? Border.all(
                            color: variant == ButtonVariant.outlineLight
                                ? const Color(0xFF010A53)
                                : Colors.white,
                          )
                        : null,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  child: Align(
                    child: !isLoading ? Text(
                      title,
                      style: GoogleFonts.roboto(
                        color: variant == ButtonVariant.light ||
                                variant == ButtonVariant.outlineLight
                            ? const Color(0xFF010A53)
                            : Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ) : const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2),),
                  ),
                ),
                onTap: onPressed,
              ),
            ),
          ),
        )
      ],
    );
  }
}
