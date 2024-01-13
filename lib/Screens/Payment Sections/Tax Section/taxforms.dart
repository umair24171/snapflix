import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextForms extends StatefulWidget {
  const TextForms({super.key});

  @override
  State<TextForms> createState() => _TextFormsState();
}

class _TextFormsState extends State<TextForms> {
  bool isselected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.search),
            )
          ],
          centerTitle: true,
          backgroundColor: Colors.white12,
          title: const Text('Text Forms'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 60),
              child: Container(
                height: 400,
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "2022",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "You do not not have a 2022 tax",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const Text(
                      "document available for one or",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const Text(
                      "more of the following reason",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      children: [
                        checkbox(),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "your 1099 has not been sent yet",
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                            color: Colors.grey,
                          )),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        checkbox(),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "To did not Submit 20w",
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                            color: Colors.grey,
                          )),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        checkbox(),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "You are not us Citizen",
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                            color: Colors.grey,
                          )),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        checkbox(),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "You were paid less than \$600 in the \n Calender year",
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                            color: Colors.grey,
                          )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  InkWell checkbox() {
    return InkWell(
      onTap: () {
        setState(() {
          isselected = !isselected; // Toggle the selection state
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
            height: 20,
            width: 20,
            decoration: const BoxDecoration(color: Colors.white),
            child: isselected
                ? const Icon(
                    Icons.check,
                    color: Colors.black,
                    size: 20,
                  )
                : Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(color: Colors.pinkAccent),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 20,
                    ))),
      ),
    );
  }
}
