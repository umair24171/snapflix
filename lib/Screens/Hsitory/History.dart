// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("History"),
          backgroundColor: Colors.white12,
          leading: IconButton(
              onPressed: () {
                //  Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: const Column(
          children: [
             SizedBox(
              height: 22,
            ),
             Padding(
              padding:  EdgeInsets.only(right: 200),
              child: Text(
                "Pay out History",
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
             SizedBox(
              height: 22,
            ),

            paddings(),
            SizedBox(height: 10),
            paddings(),
            SizedBox(height: 10),
            paddings(),
            SizedBox(height: 10),
            paddings(),

           
          ],
        ));
  }
}

// ignore: camel_case_types
class paddings extends StatelessWidget {
  const paddings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 17, right: 17),
      child: Container(
          height: 110,
          width: 360,
          decoration: BoxDecoration(
              color: Colors.white12, borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 14, right: 14, top: 15, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Octor-16-31",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text("11-03-2023",
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(color: Colors.grey)))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Direct Deposit",
                      style: GoogleFonts.roboto(
                          textStyle: const TextStyle(color: Colors.grey)),
                    ),
                    Container(
                      height: 29,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                        child: Text(
                          'Paid',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
