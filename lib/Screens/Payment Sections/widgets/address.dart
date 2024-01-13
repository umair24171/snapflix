import 'package:country_picker/country_picker.dart';
import 'package:snapflix/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  TextEditingController payableController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController streetaddressController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  String? gender;
  Country? selectedCountry;

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
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 17, right: 17, top: 15),
            child: Container(
                height: 780,
                width: 350,
                decoration: BoxDecoration(
                    color: AppColors.lightWhite,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 130, top: 25),
                      child: Text("Payout Method",
                          style: TextStyle(color: Colors.white, fontSize: 22)),
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
                                    MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.disabled)) {
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
                    texttitles('Payable to :'),
                    Padding(
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      child: TextFormField(
                          controller: payableController,
                          validator:
                              RequiredValidator(errorText: "name is required"),
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
                    texttitles('Street Address'),
                    Padding(
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      child: TextFormField(
                          controller: streetaddressController,
                          validator:
                              RequiredValidator(errorText: "name is required"),
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: "House No. a",
                            hintStyle: TextStyle(color: Color(0xff8D8D8D)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white12),
                            ),
                          )),
                    ),
                    texttitles('Apartment or unit # :(optional)'),
                    Padding(
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      child: TextFormField(
                          controller: apartmentController,
                          validator: RequiredValidator(
                              errorText: "this field is requried"),
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
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 25,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Zip",
                                style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                        letterSpacing: .5,
                                        fontSize: 13,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w100)),
                              ),
                              const SizedBox(
                                width: 80,
                              ),
                              Text(
                                "City",
                                style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                        letterSpacing: .5,
                                        fontSize: 13,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w100)),
                              ),
                              const SizedBox(
                                width: 80,
                              ),
                              Text(
                                "State",
                                style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                        letterSpacing: .5,
                                        fontSize: 13,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w100)),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 60,
                            width: 80,
                            child: TextFormField(
                                controller: zipController,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  hintText: "1234",
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
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            height: 60,
                            width: 80,
                            child: TextFormField(
                                controller: cityController,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  hintText: "1234",
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
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            height: 60,
                            width: 80,
                            child: TextFormField(
                                controller: stateController,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  hintText: "1234",
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
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            // _showCountryPicker(
                            // context); // Show country picker on tap
                          },
                          child: Container(
                            height: 65,
                            width: 300,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors
                                      .lightWhite, // Set the desired border color here
                                  width: 2.0, // Set the border width
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                //  labelText: 'Country',
                                border: OutlineInputBorder(),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  selectedCountry != null
                                      ? Text(selectedCountry!.name)
                                      : Text(
                                          'Select a country',
                                          style: GoogleFonts.roboto(
                                              textStyle: const TextStyle(
                                                  letterSpacing: .5,
                                                  fontSize: 13,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w100)),
                                        ),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.pinkColor,
                          fixedSize: const Size(300, 55),
                        ),
                        onPressed: () {},
                        child: const Text('Update payment information')),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                letterSpacing: .5,
                                fontSize: 13,
                                color: Colors.grey,
                                fontWeight: FontWeight.w100)),
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
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
//   void _showCountryPicker(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Select Country'),
//           content: SizedBox(
//             width: double.maxFinite,
//             child: ListView(
//               shrinkWrap: true,
//               children: countryList.map((Country country) {
//                 return ListTile(
//                   onTap: () {
//                     setState(() {
//                       selectedCountry = country;
//                     });
//                     Navigator.pop(context); // Close the picker dialog
//                   },
//                   leading: CountryPickerUtils.getDefaultFlagImage(country),
//                   title: Text(country.name),
//                 );
//               }).toList(),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
