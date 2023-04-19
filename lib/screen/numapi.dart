import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class MyNumApi extends StatefulWidget {
  const MyNumApi({super.key});

  @override
  State<MyNumApi> createState() => _MyNumApiState();
}

class _MyNumApiState extends State<MyNumApi> {
  TextEditingController numberField = TextEditingController();
  dynamic data;
  String results = '';
  String factType = '';
  bool notAngry = true;
  Color textBackground = Colors.white;
  // Initial Selected Value
  String dropdownvalue = 'Trivia';

  // List of items in our dropdown menu
  var items = [
    'Trivia',
    'Math',
    'Date',
    'Year',
  ];

  Future numberApi(x, String y) async {
    setState(() {
      y = y.toLowerCase();
    });

    var response = await http.get(Uri.parse('http://numbersapi.com/$x/$y'));

    if (response.statusCode == 200) {
      setState(() {
        if (x == 'random') {
          factType = 'Random';
        } else {
          factType = '${y[0].toUpperCase()}${y.substring(1)}: ';
        }

        results = jsonEncode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // title
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.33,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Text(
                        'Numberology',
                        style: TextStyle(
                          color: Colors.blue.shade900,
                          fontFamily: 'headFone',
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Text(
                        'Exploring the World of Numbers,\nOne Fact at a Time',
                        style: TextStyle(
                          color: Colors.red.shade900,
                          fontFamily: 'bodyFont',
                          fontSize: 18,
                          // fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                    ],
                  ),
                ),
                // textfield and button
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.20,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // number
                          Expanded(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: TextField(
                                  controller: numberField,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Enter a number',
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // type
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    // Initial Value
                                    value: dropdownvalue,
                                    // Down Arrow Icon
                                    icon: const Icon(Icons.arrow_drop_down),
                                    // Array list of items
                                    items: items.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownvalue = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // buttons
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: SizedBox(
                                height: 45,
                                child: ElevatedButton(
                                    style: const ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll(Colors.red),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        notAngry = true;
                                        numberApi('random', '');
                                        textBackground = Colors.green.shade50;
                                      });
                                    },
                                    child: const Text(
                                      'Random',
                                      style: TextStyle(
                                        fontFamily: 'bodyFont',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: SizedBox(
                                height: 45,
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (numberField.text == '') {
                                        setState(() {
                                          notAngry = false;
                                        });
                                      } else if (numberField.text != '') {
                                        setState(() {
                                          notAngry = true;
                                          numberApi(
                                              numberField.text, dropdownvalue);
                                          textBackground = Colors.green.shade50;
                                        });
                                      }
                                    },
                                    child: const Text(
                                      'Get Fact',
                                      style: TextStyle(
                                        fontFamily: 'bodyFont',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // results
                notAngry
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.33,
                        child: Column(
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05),
                            Container(
                              decoration: BoxDecoration(
                                color: textBackground,
                                borderRadius: BorderRadius.circular(
                                  5.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '$factType $results',
                                    style: const TextStyle(
                                      fontFamily: 'bodyFont',
                                      fontSize: 18,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.25,
                              child:
                                  Lottie.asset('assets/animations/angry.json'),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.red.shade100,
                                borderRadius: BorderRadius.circular(
                                  5.0,
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                                child: Text(
                                  'Enter a number and then click \'Get Fact\'',
                                  style: TextStyle(
                                    fontFamily: 'bodyFont',
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
