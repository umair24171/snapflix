import "package:snapflix/Constants/app_colors.dart";
import 'package:snapflix/Screens/Payment%20Sections/widgets/address.dart';
import "package:flutter/material.dart";
import "package:form_field_validator/form_field_validator.dart";
import "package:google_fonts/google_fonts.dart";

class TextFormDetails extends StatefulWidget {
  const TextFormDetails({super.key});

  @override
  State<TextFormDetails> createState() => _TextFormDetailsState();
}

class _TextFormDetailsState extends State<TextFormDetails> {
  TextEditingController nameController = TextEditingController();
  TextEditingController banknameController = TextEditingController();
  TextEditingController raountingController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  bool isselected = false;
  bool? isChecked = false;
  String? gender;
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 17, right: 17),
                child: Container(
                    height: 130,
                    width: 360,
                    decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 14, right: 14, top: 15, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "W9 status",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Container(
                                height: 29,
                                width: 90,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Center(
                                  child: Text(
                                    'Accepted',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  "Once you've decided on the fonts you want Once you've decided on ",
                                  style: GoogleFonts.roboto(
                                      textStyle:
                                          const TextStyle(color: Colors.grey)),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 17, right: 17),
                child: Container(
                    height: 480,
                    width: 360,
                    decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 14, right: 14, top: 15, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "W9 status",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Center(
                                  child: Text(
                                    'Update',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  "Once you've decided on the fonts you want Once you've decided on ",
                                  style: GoogleFonts.roboto(
                                      textStyle:
                                          const TextStyle(color: Colors.grey)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            height: 350,
                            width: 280,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white12),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                texttitles(
                                    "Name(as show on your tax income\n return)"),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  child: TextFormField(
                                      controller: nameController,
                                      // validator: (value) {
                                      //   if (value!.isEmpty) {
                                      //     return 'Please Enter CVC Number';
                                      //   }
                                      // },
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                        hintText: "Please Enter Your Name",
                                        hintStyle:
                                            TextStyle(color: Color(0xff8D8D8D)),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white12),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white12),
                                        ),
                                      )),
                                ),
                                texttitles("Mailing Address"),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  child: TextFormField(
                                      controller: nameController,
                                      // validator: (value) {
                                      //   if (value!.isEmpty) {
                                      //     return 'Please Enter CVC Number';
                                      //   }
                                      // },
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                        hintText: "Please Enter Your Email",
                                        hintStyle:
                                            TextStyle(color: Color(0xff8D8D8D)),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white12),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white12),
                                        ),
                                      )),
                                ),
                                texttitles("SSNorEIN"),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  child: TextFormField(
                                      controller: nameController,
                                      // validator: (value) {
                                      //   if (value!.isEmpty) {
                                      //     return 'Please Enter CVC Number';
                                      //   }
                                      // },
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                        hintText: "SS Nor EIN",
                                        hintStyle:
                                            TextStyle(color: Color(0xff8D8D8D)),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white12),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white12),
                                        ),
                                      )),
                                ),
                              ],
                            )),
                      ],
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 17, right: 17),
                child: Container(
                    height: 430,
                    width: 350,
                    decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(14)),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Payment Information",
                          style: TextStyle(
                              color: Colors.white,
                              //fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Checkbox(
                                fillColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return AppColors.pinkColor;
                                  }
                                  return AppColors.pinkColor;
                                }),
                                value: isChecked,
                                activeColor: AppColors.pinkColor,
                                // tristate: true,
                                onChanged: (newBool) {
                                  setState(() {
                                    isChecked = newBool;
                                  });
                                }),
                            // const SizedBox(width: 1),
                            RichText(
                                text: const TextSpan(
                                    text:
                                        "Certainly! Here is an example of displaying\ngeneric  company that deals with company\nHere is an example of ",
                                    style: TextStyle(color: Colors.grey),
                                    children: [
                                  TextSpan(
                                      text:
                                          "(click the view of the\npayout calender)",
                                      style:
                                          TextStyle(color: Colors.pinkAccent))
                                ]))
                          ],
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Row(
                          children: [
                            Checkbox(
                                fillColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return AppColors.pinkColor;
                                  }
                                  return AppColors.pinkColor;
                                }),
                                value: isChecked,
                                activeColor: AppColors.pinkColor,
                                // tristate: true,
                                onChanged: (newBool) {
                                  setState(() {
                                    isChecked = newBool;
                                  });
                                }),
                            const SizedBox(width: 1),
                            const Text(
                              "Use const with the constructor to improve \nUse const with the constructor ",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Row(
                          children: [
                            Checkbox(
                                fillColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return AppColors.pinkColor;
                                  }
                                  return AppColors.pinkColor;
                                }),
                                value: isChecked,
                                activeColor: AppColors.pinkColor,
                                // tristate: true,
                                onChanged: (newBool) {
                                  setState(() {
                                    isChecked = newBool;
                                  });
                                }),
                            //const SizedBox(width: 15),
                            const Text(
                              "Use const with the constructor to improve \nUse const with the constructor to improve\nCertainly! Here is an example of displaying\nCertainly! Here is an example of  ",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Row(
                          children: [
                            Checkbox(
                                fillColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return AppColors.pinkColor;
                                  }
                                  return AppColors.pinkColor;
                                }),
                                value: isChecked,
                                activeColor: AppColors.pinkColor,
                                // tristate: true,
                                onChanged: (newBool) {
                                  setState(() {
                                    isChecked = newBool;
                                  });
                                }),
                            //  const SizedBox(width: 15),
                            const Padding(
                              padding: EdgeInsets.only(),
                              child: Text(
                                "Use const with the constructor to improve \nUse const with the constructor const with\nUse const with the constructor to improve\nconst with the",
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Row(
                          children: [
                            Checkbox(
                                fillColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return AppColors.pinkColor;
                                  }
                                  return AppColors.pinkColor;
                                }),
                                value: isChecked,
                                activeColor: AppColors.pinkColor,
                                // tristate: true,
                                onChanged: (newBool) {
                                  setState(() {
                                    isChecked = newBool;
                                  });
                                }),
                            const Padding(
                              padding: EdgeInsets.only(),
                              child: Text(
                                "Use const with the constructor to improve \nUse const with the constructor const with\nUse const with the constructor to improve\nconst with the",
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          ],
                        )
                      ],
                    )),
              ),
              const SizedBox(
                height: 14,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 17, right: 17),
                child: Container(
                    height: 950,
                    width: 350,
                    decoration: BoxDecoration(
                        color: AppColors.lightWhite,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 130, top: 25),
                          child: Text("Payout Method",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22)),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          height: 55,
                          width: 300,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.lightWhite,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    activeColor: AppColors.pinkColor,
                                    value: 'Male',
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Direct Deposit',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    fillColor:
                                        MaterialStateProperty.resolveWith<
                                            Color>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.disabled)) {
                                        return Colors.orange.withOpacity(.32);
                                      }
                                      return Colors.white;
                                    }),
                                    activeColor: AppColors.pinkColor,
                                    value: 'Female',
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Check',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 80, top: 20),
                          child: Text("US Bank accounts only",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Radio(
                                  activeColor: AppColors.pinkColor,
                                  value: 'Male',
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value;
                                    });
                                  },
                                ),
                                const Text(
                                  'Checking',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  fillColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.disabled)) {
                                      return Colors.orange.withOpacity(.32);
                                    }
                                    return Colors.white;
                                  }),
                                  activeColor: AppColors.pinkColor,
                                  value: 'Female',
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value;
                                    });
                                  },
                                ),
                                const Text(
                                  'Savings',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(
                            thickness: 1, color: AppColors.lightWhite),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Radio(
                                  activeColor: AppColors.pinkColor,
                                  value: 'Male',
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value;
                                    });
                                  },
                                ),
                                const Text(
                                  'Personal',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  fillColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.disabled)) {
                                      return Colors.orange.withOpacity(.32);
                                    }
                                    return Colors.white;
                                  }),
                                  activeColor: AppColors.pinkColor,
                                  value: 'Female',
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value;
                                    });
                                  },
                                ),
                                const Text(
                                  'Business',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                        texttitles('Name'),
                        Padding(
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          child: TextFormField(
                              controller: banknameController,
                              validator: RequiredValidator(
                                  errorText: "name is required"),
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "Bank Name",
                                hintStyle: TextStyle(color: Color(0xff8D8D8D)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white12),
                                ),
                              )),
                        ),
                        texttitles('Rounting Number'),
                        Padding(
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          child: TextFormField(
                              controller: raountingController,
                              validator: RequiredValidator(
                                  errorText: "routing name is required"),
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "Bank Name",
                                hintStyle: TextStyle(color: Color(0xff8D8D8D)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white12),
                                ),
                              )),
                        ),
                        texttitles('Account Number'),
                        Padding(
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          child: TextFormField(
                              controller: accountController,
                              validator: RequiredValidator(
                                  errorText: "account no is required"),
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "123456789",
                                hintStyle: TextStyle(color: Color(0xff8D8D8D)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white12),
                                ),
                              )),
                        ),
                        texttitles('Confirm Account Number'),
                        Padding(
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          child: TextFormField(
                              controller: confirmController,
                              validator: RequiredValidator(
                                  errorText: "this field is required"),
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "12345678",
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
                          height: 24,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 40),
                              child: Checkbox(
                                  fillColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.disabled)) {
                                      return AppColors.pinkColor;
                                    }
                                    return AppColors.pinkColor;
                                  }),
                                  value: isChecked,
                                  activeColor: AppColors.pinkColor,
                                  // tristate: true,
                                  onChanged: (newBool) {
                                    setState(() {
                                      isChecked = newBool;
                                    });
                                  }),
                            ),
                            Text(
                                'Lorem Ipsum is simply dummy text of the\nprinting and typesetting industry. Lorem\nIpsum is simply dummy text of the\nprinting and typesetting industry ',
                                style: GoogleFonts.roboto(color: Colors.grey))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.pinkColor,
                              fixedSize: const Size(270, 50),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Address()));
                            },
                            child: const Text('Update payment information'))
                      ],
                    )),
              ),
            ],
          ),
        ));
  }

  Padding texttitles(String text) {
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
