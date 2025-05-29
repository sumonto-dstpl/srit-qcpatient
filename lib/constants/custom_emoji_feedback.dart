import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomEmojiFeedback extends StatefulWidget {
  final double elementSize;
  final Duration animDuration;
  final Function(int) onChanged;
  final bool showLabel;

  const CustomEmojiFeedback({
    Key? key,
    required this.elementSize,
    required this.animDuration,
    required this.onChanged,
    this.showLabel = false,
  }) : super(key: key);

  @override
  _CustomEmojiFeedbackState createState() => _CustomEmojiFeedbackState();
}

class _CustomEmojiFeedbackState extends State<CustomEmojiFeedback> with SingleTickerProviderStateMixin {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(5, (index) {
        bool isSelected = index == selectedIndex;
        String imagePath = 'assets/emojis/${index + 1}${isSelected ? '' : '-30'}.svg';

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
            widget.onChanged(index + 1); // Emoji ratings from 1 to 5
          },
          child: AnimatedContainer(
            duration: widget.animDuration,
            curve: Curves.easeInOut,
            margin: EdgeInsets.symmetric(horizontal: widget.elementSize * 0.2), // spacing between emojis
            height: isSelected ? widget.elementSize * 1.1 : widget.elementSize,
            width: isSelected ? widget.elementSize * 1.1 : widget.elementSize,
            child: SvgPicture.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
        );
      }),
    );
  }
}
