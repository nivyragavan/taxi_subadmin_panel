import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taxi_subadmin_panel/constant/style.dart';
import 'package:taxi_subadmin_panel/widget/custom_text.dart';

import '../../model/in_progress_rides_model.dart';
import '../../service/api_service.dart';
import '../../widget/sidebar_widget.dart';
import '../authentication_page.dart';

class RidesInProgressPage extends StatefulWidget {
  const RidesInProgressPage({Key? key}) : super(key: key);

  static const String id = "rides_in_progress_page";

  @override
  State<RidesInProgressPage> createState() => _RidesInProgressPageState();
}

class _RidesInProgressPageState extends State<RidesInProgressPage> {
  InProgressRidesModel? inProgressRidesModel;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    inProgressRidesModel = await ApiService().inProgressRides();
    if (inProgressRidesModel != null) {
      setState(() {
        isLoading = true;
      });
      setState(() {
        inProgressRidesModel = inProgressRidesModel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        backgroundColor: light,
        appBar: AppBar(
        title: const Text(
        'Sub Admin Panel',
        style: TextStyle(color: Colors.black),
    ),
          backgroundColor: yellow,
    actions: [
    IconButton(
    onPressed: () {
    Get.offAll(AuthenticationPage());
    },
    icon: const Icon(Icons.logout,color: Colors.black,))
    ],
    ),
    sideBar: SideBarWidget().sidebarMenus(RidesInProgressPage.id),
    body:Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Rides In Progress',
              size: 20,
              weight: FontWeight.bold,
              color: blue,
            ),
            const SizedBox(height: 20),
            Expanded(
                child: ListView(
              children: [buildRidesInProgressTable()],
            )),
          ],
        ),
      ),
    )
    );
  }

  buildRidesInProgressTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: active.withOpacity(.4), width: .5),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 6),
                  color: lightGrey.withOpacity(.1),
                  blurRadius: 12)
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.only(bottom: 30),
          child: isLoading == false
              ? Center(
                  child: CircularProgressIndicator(
                    color: blue,
                  ),
                )
              : inProgressRidesModel!.body!.progressRides!.isEmpty
                  ? Center(child: Image.asset('assets/images/nodatafound.png'))
                  : Card(
                      child: DataTable2(
                          columnSpacing: 5,
                          horizontalMargin: 12,
                          minWidth: 1000,
                          columns: [
                            DataColumn(
                              label: Text('S:No',
                                  style: TextStyle(fontSize: 15, color: blue)),
                            ),
                            DataColumn(
                              label: Text('Name',
                                  style: TextStyle(fontSize: 15, color: blue)),
                            ),
                            DataColumn(
                              label: Text('Contact',
                                  style: TextStyle(fontSize: 15, color: blue)),
                            ),
                            DataColumn(
                              label: Text('Pickup Location',
                                  style: TextStyle(fontSize: 15, color: blue)),
                            ),
                            DataColumn(
                              label: Text('Drop Location',
                                  style: TextStyle(fontSize: 15, color: blue)),
                            ),
                            DataColumn(
                              label: Text('Package',
                                  style: TextStyle(fontSize: 15, color: blue)),
                            ),
                            DataColumn(
                              label: Text('Rental Hour',
                                  style: TextStyle(fontSize: 15, color: blue)),
                            ),
                            DataColumn(
                              label: Text('Cab Type',
                                  style: TextStyle(fontSize: 15, color: blue)),
                            ),
                            DataColumn(
                              label: Text('Pickup Date',
                                  style: TextStyle(fontSize: 15, color: blue)),
                            ),
                            DataColumn(
                              label: Text('Drop Date',
                                  style: TextStyle(fontSize: 15, color: blue)),
                            ),
                          ],
                          rows: List.generate(
                              inProgressRidesModel!.body!.progressRides!.length,
                              (index) {
                                var e = inProgressRidesModel!.body!.progressRides![index];
                            return DataRow(cells: [
                              DataCell(Text('${index + 1}')),
                              DataCell(Text('${e.name}')),
                              DataCell(Text('${e.phonenumber}')),
                              DataCell(Text('${e.pickupLocation}')),
                              DataCell(Text('${e.dropLocation}')),
                              DataCell(Text('${e.package}')),
                              DataCell(Text('${e.rentalhour}')),
                              DataCell(Text('${e.cab}')),
                              DataCell(Text(DateFormat('dd-MM-yyyy').format(e.pickupDate!))),
                              DataCell(Text(DateFormat('dd-MM-yyyy').format(e.pickupDate!))),
                            ]);
                          })),
                    )),
    );
  }
}
