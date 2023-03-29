import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:taxi_subadmin_panel/constant/responsiveness.dart';
import 'package:taxi_subadmin_panel/constant/style.dart';
import 'package:taxi_subadmin_panel/widget/custom_text.dart';

import '../service/api_service.dart';
import '../widget/sidebar_widget.dart';
import 'authentication_page.dart';

class ManualBookingPage extends StatefulWidget {
  const ManualBookingPage({Key? key}) : super(key: key);

  static const String id = "manual_booking_page";

  static const packageItems = ['Local', 'Rental', 'Outstation', 'Tour Package'];
  static const rentalItems = ['1', '2', '3', '4', '5'];
  static const cabItems = ['Mini', 'Sedan', 'SUV'];

  @override
  State<ManualBookingPage> createState() => _ManualBookingPageState();
}

class _ManualBookingPageState extends State<ManualBookingPage> {
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  final name = TextEditingController();

  final phone = TextEditingController();

  final pickup = TextEditingController();

  final drop = TextEditingController();

  final package = TextEditingController();

  final rental = TextEditingController();

  final cab = TextEditingController();

  final pickupDate = TextEditingController();

  final dropDate = TextEditingController();

  var box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        backgroundColor: light,
        appBar: AppBar(
          title: const Text(
            'Sub Admin Panel',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {
                  Get.offAll(AuthenticationPage());
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ))
          ],
        ),
        sideBar: SideBarWidget().sidebarMenus(ManualBookingPage.id),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomText(
                  text: 'Manual Booking',
                  size: 20,
                  weight: FontWeight.bold,
                  color: green,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      if (ResponsiveWidget.isLargeScreen(context))
                        buildAddBookingLarge()
                      else
                        buildAddBookingSmall(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  buildAddBookingLarge() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add Booking',
            style: TextStyle(
                fontSize: 20, color: green, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: name,
                  cursorColor: green,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "Enter Name",
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: green))),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: phone,
                  cursorColor: green,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "Enter Phone Number",
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: green))),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: pickup,
                  cursorColor: green,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "Enter Pickup Location",
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: green))),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: drop,
                  cursorColor: green,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "Enter Drop Location",
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: green))),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: TypeAheadFormField(
                  textFieldConfiguration: TextFieldConfiguration(
                      cursorColor: green,
                      controller: package,
                      decoration: InputDecoration(
                        hintText: 'Select package',
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: green, width: 2)),
                      )),
                  suggestionsCallback: (pattern) {
                    return ManualBookingPage.packageItems.where((item) =>
                        item.toLowerCase().contains(pattern.toLowerCase()));
                  },
                  onSuggestionSelected: (String val) {
                    package.text = val;
                    print(val);
                  },
                  itemBuilder: (_, String item) {
                    return ListTile(
                      title: Text(item),
                    );
                  },
                  getImmediateSuggestions: true,
                  hideSuggestionsOnKeyboardHide: true,
                  hideOnEmpty: false,
                  noItemsFoundBuilder: (context) => const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('No item found'),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TypeAheadFormField(
                  textFieldConfiguration: TextFieldConfiguration(
                      cursorColor: green,
                      controller: rental,
                      decoration: InputDecoration(
                        hintText: 'Select rental hour (in hours)',
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: green, width: 2)),
                      )),
                  suggestionsCallback: (pattern) {
                    return ManualBookingPage.rentalItems.where((item) =>
                        item.toLowerCase().contains(pattern.toLowerCase()));
                  },
                  onSuggestionSelected: (String val) {
                    rental.text = val;
                    print(val);
                  },
                  itemBuilder: (_, String item) {
                    return ListTile(
                      title: Text(item),
                    );
                  },
                  getImmediateSuggestions: true,
                  hideSuggestionsOnKeyboardHide: true,
                  hideOnEmpty: false,
                  noItemsFoundBuilder: (context) => const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('No item found'),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TypeAheadFormField(
                  textFieldConfiguration: TextFieldConfiguration(
                      cursorColor: green,
                      controller: cab,
                      decoration: InputDecoration(
                        hintText: 'Select cab',
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: green, width: 2)),
                      )),
                  suggestionsCallback: (pattern) {
                    return ManualBookingPage.cabItems.where((item) =>
                        item.toLowerCase().contains(pattern.toLowerCase()));
                  },
                  onSuggestionSelected: (String val) {
                    cab.text = val;
                    print(val);
                  },
                  itemBuilder: (_, String item) {
                    return ListTile(
                      title: Text(item),
                    );
                  },
                  getImmediateSuggestions: true,
                  hideSuggestionsOnKeyboardHide: true,
                  hideOnEmpty: false,
                  noItemsFoundBuilder: (context) => const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('No item found'),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                    controller: pickupDate,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: green, width: 2)),
                        hintText: 'Enter pickup date'),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));
                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          pickupDate.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid pickup date';
                      }
                      return null;
                    }),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                    controller: dropDate,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: green, width: 2)),
                        hintText: 'Enter drop date'),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));
                      if (pickedDate != null) {
                        print(pickedDate);
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(formattedDate);

                        setState(() {
                          dropDate.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid drop date';
                      }
                      return null;
                    }),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: InkWell(
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  if (isLoading) return;
                  setState(() {
                    isLoading = true;
                  });
                  await Future.delayed(const Duration(seconds: 5));
                  setState(() {
                    isLoading = false;
                  });
                  var data = await ApiService().manualBookingAdd(
                      name.text,
                      phone.text,
                      pickup.text,
                      pickupDate.text,
                      drop.text,
                      dropDate.text,
                      cab.text,
                      rental.text,
                      package.text);
                  if (data['statusCode'] == 1) {
                    Fluttertoast.showToast(msg: 'Booked Successfully');
                  } else {
                    Fluttertoast.showToast(msg: '${data["message"]}');
                  }
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [green, dark]),
                    borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
                width: 500,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: isLoading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          Text(
                            'Please Wait',
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          )
                        ],
                      )
                    : const CustomText(
                        text: "Submit",
                        color: Colors.white,
                        size: 20,
                        weight: FontWeight.normal,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildAddBookingSmall() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add Booking',
          style: TextStyle(
              fontSize: 20, color: black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: name,
                cursorColor: green,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    hintText: "Enter Name",
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: green))),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: phone,
                cursorColor: green,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    hintText: "Enter Phone Number",
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: green))),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: pickup,
                cursorColor: green,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    hintText: "Enter Pickup Location",
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: green))),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: drop,
                cursorColor: green,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    hintText: "Enter Drop Location",
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: green))),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                    cursorColor: green,
                    controller: package,
                    decoration: InputDecoration(
                      hintText: 'Select package',
                      contentPadding: const EdgeInsets.all(10),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: green, width: 2)),
                    )),
                suggestionsCallback: (pattern) {
                  return ManualBookingPage.packageItems.where((item) =>
                      item.toLowerCase().contains(pattern.toLowerCase()));
                },
                onSuggestionSelected: (String val) {
                  package.text = val;
                  print(val);
                },
                itemBuilder: (_, String item) {
                  return ListTile(
                    title: Text(item),
                  );
                },
                getImmediateSuggestions: true,
                hideSuggestionsOnKeyboardHide: true,
                hideOnEmpty: false,
                noItemsFoundBuilder: (context) => const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('No item found'),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                    cursorColor: green,
                    controller: rental,
                    decoration: InputDecoration(
                      hintText: 'Select rental hour',
                      contentPadding: const EdgeInsets.all(10),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: green, width: 2)),
                    )),
                suggestionsCallback: (pattern) {
                  return ManualBookingPage.rentalItems.where((item) =>
                      item.toLowerCase().contains(pattern.toLowerCase()));
                },
                onSuggestionSelected: (String val) {
                  rental.text = val;
                  print(val);
                },
                itemBuilder: (_, String item) {
                  return ListTile(
                    title: Text(item),
                  );
                },
                getImmediateSuggestions: true,
                hideSuggestionsOnKeyboardHide: true,
                hideOnEmpty: false,
                noItemsFoundBuilder: (context) => const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('No item found'),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                    cursorColor: green,
                    controller: cab,
                    decoration: InputDecoration(
                      hintText: 'Select cab',
                      contentPadding: const EdgeInsets.all(10),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: green, width: 2)),
                    )),
                suggestionsCallback: (pattern) {
                  return ManualBookingPage.cabItems.where((item) =>
                      item.toLowerCase().contains(pattern.toLowerCase()));
                },
                onSuggestionSelected: (String val) {
                  cab.text = val;
                  print(val);
                },
                itemBuilder: (_, String item) {
                  return ListTile(
                    title: Text(item),
                  );
                },
                getImmediateSuggestions: true,
                hideSuggestionsOnKeyboardHide: true,
                hideOnEmpty: false,
                noItemsFoundBuilder: (context) => const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('No item found'),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                  controller: pickupDate,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: green, width: 2)),
                      hintText: 'Enter pickup date'),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));
                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        pickupDate.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid pickup date';
                    }
                    return null;
                  }),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                  controller: dropDate,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: green, width: 2)),
                      hintText: 'Enter drop date'),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));
                    if (pickedDate != null) {
                      print(pickedDate);
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      print(formattedDate);

                      setState(() {
                        dropDate.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid drop date';
                    }
                    return null;
                  }),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: green, fixedSize: const Size(200, 45)),
            // onPressed: () async {
            //   var data = await APIService().createManualBooking(
            //       name.text,
            //       phone.text,
            //       pickup.text,
            //       drop.text,
            //       package.text,
            //       rental.text,
            //       cab.text,
            //       pickupDate.text,
            //       dropDate.text);
            //   if (data['success'] == true) {
            //     box.write("token", data["token"]);
            //     print('success');
            //   } else {
            //     print('failed');
            //     return null;
            //   }
            // },
            onPressed: () {},
            child: const Center(
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
