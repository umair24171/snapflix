import 'package:snapflix/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:velocity_x/velocity_x.dart';

Widget customTextField(
    {String? hintTitle,
    String? lableTitle,
    Color? labelColor,
    Color? hintColor,
    Color? boxColor,
    Color? borderColor,
    IconButton? suffixIconButton,
    TextEditingController? textController,
    MultiValidator? validator}) {
  return TextFormField(
    controller: textController,
    decoration: InputDecoration(
        labelText: lableTitle,
        hintText: hintTitle,
        suffixIcon: suffixIconButton,
        labelStyle: TextStyle(
          color: labelColor,
          fontSize: 13,
        ),
        border: InputBorder.none,
        hintStyle: TextStyle(color: hintColor)),
    style: const TextStyle(
      fontSize: 12,
      color: AppColors.lightText,
    ),
    validator:
        validator ?? RequiredValidator(errorText: "this field is required"),
  )
      .pOnly(left: 10, right: 5, top: 5, bottom: 0)
      .box
      .color(boxColor!)
      .rounded
      .border(color: borderColor!)
      .make()
      .pOnly(top: 20, left: 20, right: 20);
}
