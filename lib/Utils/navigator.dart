import 'package:flutter/material.dart';

  navPush(context, var home) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => home));
  }

  navReplace(context, var home) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => home));
  }

  navPop(context) {
    Navigator.pop(context);
  }

