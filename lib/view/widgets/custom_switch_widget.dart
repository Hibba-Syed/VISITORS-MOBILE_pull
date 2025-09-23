import 'package:flutter/material.dart';
import '../../resource/constants/app_colors.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double width;
  final double height;
  final String textOn;
  final String textOff;
  final Color colorOn;
  final Color colorOff;
  final Color thumbColor;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.width = 55,
    this.height = 23,
    this.textOn = 'EN',
    this.textOff = 'AR',
    this.colorOn = AppColors.primary,
    this.colorOff = AppColors.primary,
    this.thumbColor = AppColors.white,
  });

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    final isOn = widget.value;

    return InkWell(
      onTap: () {
        widget.onChanged(!isOn);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: isOn ? widget.colorOn : widget.colorOff,
          borderRadius: BorderRadius.circular(widget.height / 2),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Texts
            isOn
                ? Padding(
                  padding:  EdgeInsets.only(right: 10) ,
                  child: Text(widget.textOn,
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                )
                : Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(widget.textOff,
                      style: TextStyle(
                        color: AppColors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ),
            // Thumb
            AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: widget.height - 5,
                height: widget.height - 5,
                decoration: BoxDecoration(
                  color: widget.thumbColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
