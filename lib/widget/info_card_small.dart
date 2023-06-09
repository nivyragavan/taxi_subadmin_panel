import 'package:flutter/material.dart';
import 'package:taxi_subadmin_panel/constant/style.dart';
import 'package:taxi_subadmin_panel/widget/custom_text.dart';


class InfoCardSmall extends StatelessWidget {
  final String? title;
  final String? value;
  final bool isActive;
  final Function? onTap;

  const InfoCardSmall(
      {Key? key, this.title, this.value, this.isActive = false, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: isActive ? active : lightGrey, width: .5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: title,
                  size: 24,
                  weight: FontWeight.w300,
                  color: isActive ? active : dark,
                ),
                CustomText(
                  text: value,
                  size: 24,
                  weight: FontWeight.bold,
                  color: isActive ? active : dark,
                )
              ],
            )),
      ),
    );
  }
}