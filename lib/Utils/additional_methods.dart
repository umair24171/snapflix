import 'package:snapflix/Constants/app_colors.dart';

import 'package:get/get.dart';

showSnackBar(String title, String message) {
  Get.snackbar(title, message, backgroundColor: AppColors.pinkColor);
}
