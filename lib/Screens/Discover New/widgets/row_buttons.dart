import 'package:snapflix/Custom%20Widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class RowButtons extends StatefulWidget {
  RowButtons({
    super.key,
    required this.all,
    required this.politic,
    required this.support,
    required this.educate,
    required this.songs,
    required this.gangster,
  });
  bool all;
  bool politic;
  bool support;
  bool educate;
  bool songs;
  bool gangster;
  @override
  State<RowButtons> createState() => _RowButtonsState();
}

class _RowButtonsState extends State<RowButtons> {
  @override
  Widget build(BuildContext context) {
    var buttonHeight = MediaQuery.of(context).size.height * 0.05;
    var buttonWidth = MediaQuery.of(context).size.width * 0.22;
    return HStack([
      GestureDetector(
          onTap: () {
            setState(() {
              widget.all = true;
              widget.politic = false;
              widget.support = false;
              widget.educate = false;
              widget.songs = false;
              widget.gangster = false;
            });
          },
          child:
              customRowButtons("All", buttonHeight, buttonWidth, widget.all)),
      GestureDetector(
          onTap: () {
            setState(() {
              widget.all = false;
              widget.politic = true;
              widget.support = false;
              widget.educate = false;
              widget.songs = false;
              widget.gangster = false;
            });
          },
          child: customRowButtons(
              "Politics", buttonHeight, buttonWidth, widget.politic)),
      GestureDetector(
          onTap: () {
            setState(() {
              widget.all = false;
              widget.politic = false;
              widget.support = true;
              widget.educate = false;
              widget.songs = false;
              widget.gangster = false;
            });
          },
          child: customRowButtons(
              "Sports", buttonHeight, buttonWidth, widget.support)),
      GestureDetector(
          onTap: () {
            setState(() {
              widget.all = false;
              widget.politic = false;
              widget.support = false;
              widget.educate = true;
              widget.songs = false;
              widget.gangster = false;
            });
          },
          child: customRowButtons(
              "Education", buttonHeight, buttonWidth, widget.educate)),
      GestureDetector(
          onTap: () {
            setState(() {
              widget.all = false;
              widget.politic = false;
              widget.support = false;
              widget.educate = false;
              widget.songs = true;
              widget.gangster = false;
            });
          },
          child: customRowButtons(
              "Songs", buttonHeight, buttonWidth, widget.songs)),
      GestureDetector(
          onTap: () {
            setState(() {
              widget.all = false;
              widget.politic = false;
              widget.support = false;
              widget.educate = false;
              widget.songs = false;
              widget.gangster = true;
            });
          },
          child: customRowButtons(
              "Gangster", buttonHeight, buttonWidth, widget.gangster))
    ]).scrollHorizontal();
  }
}
