import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:setlife/app/constants/app_colors.dart';

class CheckBoxWidget extends StatelessWidget {
  const CheckBoxWidget({
    super.key,
    this.onChanged,
    this.value,
    required this.title,
    this.onTap,
    this.crossAxisAlignment,
    this.width,
  });
  final void Function(bool?)? onChanged;
  final bool? value;
  final String title;
  final void Function()? onTap;
  final CrossAxisAlignment? crossAxisAlignment;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        children: [
          Checkbox(
            onChanged: onChanged,
            value: true,
            activeColor: AppColors.purple_700,
          ),
          InkWell(
            onTap: () {},
            child: SizedBox(
              width: width ?? Get.width * 0.8,
              child: Text(title,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 14,
                    // color: AppColors.purpleColor,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
