import 'package:snapflix/Constants/app_colors.dart';
import 'package:snapflix/Custom%20Widgets/custom_user_section.dart';
import 'package:snapflix/Screens/Home/widgets/featured_content_list.dart';
import 'package:snapflix/Screens/Home/widgets/recommend_creators.dart';
import 'package:snapflix/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Size get preferredSize => const Size.fromHeight(160);
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<UserProvider>(context, listen: true).getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        toolbarHeight: preferredSize.height,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.lightWhite,
        //User Section
        title: customUserSection(context),
      ),
      body: VStack([
        // featured Content
        const FeaturedContent(),

        // Creators
        "Recommended Creators"
            .text
            .bold
            .maxFontSize(19)
            .minFontSize(17)
            .color(AppColors.whiteColor)
            .make()
            .pOnly(top: 30, left: 10),
        const RecommendedCreators().pOnly(top: 20, bottom: 10),
      ]).scrollVertical(),
    );
  }
}
