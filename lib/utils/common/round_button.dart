import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: size.width * 0.05,
          left: size.width * 0.05,
          right: size.width * 0.05,
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontSize: size.width * 0.04,
                ),
          ),
        ),
      ),
    );
  }
}
