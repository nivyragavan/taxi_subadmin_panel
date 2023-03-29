import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taxi_subadmin_panel/constant/style.dart';
import 'package:taxi_subadmin_panel/widget/custom_text.dart';
import '../../model/scheduled_rides_model.dart';
import '../../service/api_service.dart';
import '../../widget/sidebar_widget.dart';
import '../authentication_page.dart';

class ScheduledRidesPage extends StatefulWidget {
  const ScheduledRidesPage({Key? key}) : super(key: key);

  static const String id = "scheduled_rides_page";

  @override
  State<ScheduledRidesPage> createState() => _ScheduledRidesPageState();
}

class _ScheduledRidesPageState extends State<ScheduledRidesPage> {
  ScheduledRidesModel? scheduledRidesModel;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    scheduledRidesModel = await ApiService().scheduledRides();
    if (scheduledRidesModel != null) {
      setState(() {
        isLoading = true;
      });
      setState(() {
        scheduledRidesModel = scheduledRidesModel;
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
          backgroundColor: Colors.white,
    actions: [
    IconButton(
    onPressed: () {
    Get.offAll(AuthenticationPage());
    },
    icon: const Icon(Icons.logout,color: Colors.black,))
    ],
    ),
    sideBar: SideBarWidget().sidebarMenus(ScheduledRidesPage.id),
    body:Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Scheduled Rides',
              size: 20,
              weight: FontWeight.bold,
              color: green,
            ),
            const SizedBox(height: 20),
            Expanded(
                child: ListView(
                  children: [buildScheduledRidesTable()],
                )),
          ],
        ),
      ),
    )
    );
  }

  buildScheduledRidesTable() {
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
              color: green,
            ),
          )
              : scheduledRidesModel!.body!.scheduledRides!.isEmpty
              ? Center(child: Image.asset('assets/images/nodatafound.png'))
              : Card(
            child: DataTable2(
                columnSpacing: 5,
                horizontalMargin: 12,
                minWidth: 1000,
                columns: [
                  DataColumn(
                    label: Text('S:No',
                        style: TextStyle(fontSize: 15, color: green)),
                  ),
                  DataColumn(
                    label: Text('Name',
                        style: TextStyle(fontSize: 15, color: green)),
                  ),
                  DataColumn(
                    label: Text('Contact',
                        style: TextStyle(fontSize: 15, color: green)),
                  ),
                  DataColumn(
                    label: Text('Pickup Location',
                        style: TextStyle(fontSize: 15, color: green)),
                  ),
                  DataColumn(
                    label: Text('Drop Location',
                        style: TextStyle(fontSize: 15, color: green)),
                  ),
                  DataColumn(
                    label: Text('Package',
                        style: TextStyle(fontSize: 15, color: green)),
                  ),
                  DataColumn(
                    label: Text('Rental Hour',
                        style: TextStyle(fontSize: 15, color: green)),
                  ),
                  DataColumn(
                    label: Text('Cab Type',
                        style: TextStyle(fontSize: 15, color: green)),
                  ),
                  DataColumn(
                    label: Text('Pickup Date',
                        style: TextStyle(fontSize: 15, color: green)),
                  ),
                  DataColumn(
                    label: Text('Drop Date',
                        style: TextStyle(fontSize: 15, color: green)),
                  ),
                ],
                rows: List.generate(
                    scheduledRidesModel!.body!.scheduledRides!.length,
                        (index) {
                      var e = scheduledRidesModel!.body!.scheduledRides![index];
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
