import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:snapflix/Utils/bottom_navigation.dart";
import "package:snapflix/auth/Login/loginPage.dart";
import "package:snapflix/firebase_methods/call_methods.dart";
import "package:snapflix/firebase_options.dart";
import "package:snapflix/providers/bottom_navigation.dart";
import "package:snapflix/providers/group_provider.dart";
import "package:snapflix/providers/search_provider.dart";
// import "package:snapflix/providers/stripe_controller.dart";
import "package:snapflix/providers/user_provider.dart";
import "package:flutter/material.dart";
// import "package:flutter_stripe/flutter_stripe.dart";
import 'package:get/get.dart';
import "package:provider/provider.dart";
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

 
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
  ZegoUIKit().initLog().then((value) => runApp(MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => UserProvider()),
            ChangeNotifierProvider(
                create: (context) => BottomNavigationProvider()),
            ChangeNotifierProvider(create: (context) => SearchProvider()),
            ChangeNotifierProvider(create: (context) => GroupProvider()),
            ChangeNotifierProvider(create: (context) => CallUtile()),
            // ChangeNotifierProvider(create: (context) => PaymentController()),
          ],
          child: MyApp(
            navigatorKey: navigatorKey,
          ))));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: widget.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.pink),
      home: FirebaseAuth.instance.currentUser == null
          ? const LoginPage()
          : BottomNavigationBarSet(),
    );
  }
}
