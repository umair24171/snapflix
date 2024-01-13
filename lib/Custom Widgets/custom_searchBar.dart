import 'package:snapflix/Constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

Widget customSearchBar(
    Function() onTap, void Function(String)? onFieldSubmitted) {
  return TextFormField(
    onChanged: onFieldSubmitted,
    decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Search anything...",
        hintStyle: const TextStyle(color: AppColors.lightText, fontSize: 14),
        suffixIcon: IconButton(
                onPressed: onTap,
                icon: const Icon(Icons.search,
                    color: AppColors.whiteColor, size: 24))
            .box
            .color(AppColors.pinkColor)
            .padding(const EdgeInsets.symmetric(
              vertical: 6,
            ))
            .roundedFull
            .make()),
    style: const TextStyle(color: AppColors.whiteColor),
  )
      .pOnly(left: 10, right: 5)
      .box
      .color(AppColors.transparentColor)
      .rounded
      .border(color: AppColors.lightWhite)
      .make()
      .pOnly(top: 10, bottom: 20);
}
