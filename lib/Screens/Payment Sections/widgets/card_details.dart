import 'package:snapflix/Utils/dialogScreen.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class CardDetails extends StatefulWidget {
  const CardDetails({super.key});

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController accountcontroller = TextEditingController();
  TextEditingController cvccontroller = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _dateController = TextEditingController();

  DateTime selectedDate = DateTime.now(); // Default date - current date

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = "${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Payment"),
        backgroundColor: Colors.white12,
        leading: IconButton(
            onPressed: () {
              //  Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                    height: 559,
                    width: 355,
                    decoration: const BoxDecoration(color: Colors.white12),
                    child: Column(
                      children: [
                        texttitle('Card Holder'),
                        Padding(
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          child: TextFormField(
                              controller: namecontroller,
                              validator: RequiredValidator(
                                  errorText: "name is required"),
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "Name",
                                hintStyle: TextStyle(color: Color(0xff8D8D8D)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white12),
                                ),
                              )),
                        ),
                        texttitle('Credit/Debit Card Number'),
                        Padding(
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          child: TextFormField(
                              controller: accountcontroller,
                              validator: RequiredValidator(
                                  errorText: "card no is required"),
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "Account Number",
                                hintStyle: TextStyle(color: Color(0xff8D8D8D)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white12),
                                ),
                              )),
                        ),
                        texttitle('Expiration Date'),

                        Padding(
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          child: TextFormField(
                            controller: _dateController,
                            validator: RequiredValidator(
                                errorText: "please select date"),
                            decoration: InputDecoration(
                              hintText: 'Select Date',
                              hintStyle: const TextStyle(color: Colors.white12),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white12)),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white12)),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _selectDate(context);
                                },
                                icon: const Icon(Icons.calendar_today),
                              ),
                            ),
                            readOnly: true,
                          ),
                        ),
                        // Other payment fields or buttons can be added here
                        texttitle('CVC'),
                        Padding(
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          child: TextFormField(
                              controller: cvccontroller,
                              validator: RequiredValidator(
                                  errorText: "Please enter CVC no"),
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "Three Digit Number",
                                hintStyle: TextStyle(color: Color(0xff8D8D8D)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white12),
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.pinkAccent),
                              minimumSize: MaterialStateProperty.all<Size>(
                                  const Size(300, 48)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const DialogScreen())));
                              if (_formKey.currentState!.validate()) {
                                // Validations passed, perform further actions here
                                // For example, you can call a login function
                              }
                            },
                            child: const Text('Update Payment Method'))
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding texttitle(String text) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                        letterSpacing: .5,
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.w100)),
              ),
            )));
  }
}
