import 'package:flutter/material.dart';
import 'package:tour_and_travel/core/colors.dart';

class DottedDivider extends StatelessWidget {
  final double height;
  final double dashWidth;

  const DottedDivider({
    super.key,
    this.height = 1.0,
    this.dashWidth = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              child: Container(
                height: height,
                color: AppColors.gray,
              ),
            );
          }),
        );
      },
    );
  }
}
