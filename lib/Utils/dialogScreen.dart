// ignore: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogScreen extends StatefulWidget {
  const DialogScreen({super.key});

  @override
  State<DialogScreen> createState() => _DialogScreenState();
}

class _DialogScreenState extends State<DialogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white12,
          centerTitle: true,
          title: const Text("payment"),
          leading: IconButton(onPressed: () {}, icon:const  Icon(Icons.arrow_back)),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Container(
                  height: 350,
                  width: 350,
                  decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const CircleAvatar(
                        radius: 38,
                        backgroundImage: AssetImage("assets/tick.jpg"),
                      ),
                      //Image.asset("assets/tick.jpg"),
                     const  SizedBox(
                        height: 20,
                      ),
                     const  Text(
                        "Payment Successful!",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            "Once you've decided on the fonts you want ",
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                    letterSpacing: .5,
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w100)),
                          ),
                        ),
                      ),
                     const  SizedBox(
                        height: 4,
                      ),
                      Text(
                        "in your published app, flutter App",
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                letterSpacing: .5,
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.w100)),
                      ),

                     const SizedBox(
                        height: 60,
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent,
                              fixedSize: const Size(265, 47)),
                          child: const Text(
                            "Go to Home",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  )),
            ),
          ],
        ));
  }
}
