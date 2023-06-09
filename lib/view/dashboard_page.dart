import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:taxi_subadmin_panel/constant/responsiveness.dart';
import 'package:taxi_subadmin_panel/constant/style.dart';
import 'package:taxi_subadmin_panel/model/rides_count_model.dart';
import 'package:taxi_subadmin_panel/service/api_service.dart';
import 'package:taxi_subadmin_panel/widget/custom_text.dart';
import 'package:taxi_subadmin_panel/widget/info_card_small.dart';
import 'package:taxi_subadmin_panel/widget/sidebar_widget.dart';
import 'package:taxi_subadmin_panel/widget/userinfo.dart';

import '../widget/info_card.dart';
import 'authentication_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  static const String id = "dashboard_page";

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  final List<DriverChartData> driverChartData = [
    DriverChartData('Mon', 20),
    DriverChartData('Tues', 30),
    DriverChartData('Wed', 10),
    DriverChartData('Thurs', 40),
    DriverChartData('Fri', 20),
    DriverChartData('Sat', 50),
    DriverChartData('Sun', 60)
  ];


  RidesCountModel? ridesCountModel;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    ridesCountModel = await ApiService().ridesCount();
    if(ridesCountModel != null){
      setState(() {
        isLoading = true;
      });
      setState(() {
        ridesCountModel = ridesCountModel;
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
      sideBar: SideBarWidget().sidebarMenus(DashboardPage.id),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Dashboard',
                size: 20,
                weight: FontWeight.bold,
                color: blue,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    if (ResponsiveWidget.isLargeScreen(context))
                      buildOverviewCardsLargeScreen(context)
                    else
                      buildOverviewCardsSmallScreen(context),
                    if (!ResponsiveWidget.isSmallScreen(context))
                      buildDriverSectionLarge(context)
                    else
                      buildDriverSectionSmall(context)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildOverviewCardsLargeScreen(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        // isLoading == false ? Container() :
        InfoCard(
          title: "Booked Rides",
          // value: "${ridesCountModel!.body!.bookedRides}",
          onTap: () {},
          topColor: active,
          value: '10',
        ),
        SizedBox(
          width: _width / 64,
        ),
        // isLoading == false ? Container() :
        InfoCard(
          title: "Scheduled Rides",
          // value: "${ridesCountModel!.body!.scheduledCount}",
          onTap: () {},
          topColor: Colors.orange,
          value: '10',
        ),
        SizedBox(
          width: _width / 64,
        ),
        // isLoading == false ? Container() :
        InfoCard(
          title: "Completed Rides",
          // value: "${ridesCountModel!.body!.completedCount}",
          topColor: Colors.lightGreen,
          onTap: () {},
          value: '10',
        ),
        SizedBox(
          width: _width / 64,
        ),
        // isLoading == false ? Container() :
        InfoCard(
          title: "Cancelled Rides",
          // value: "${ridesCountModel!.body!.cancelledCount}",
          topColor: Colors.redAccent,
          onTap: () {},
          value: '10',
        ),
      ],
    );
  }

  buildOverviewCardsSmallScreen(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 400,
      child: Column(
        children: [
          // isLoading == false ? Container() :
          InfoCardSmall(
            title: "Booked Rides",
            // value: "${ridesCountModel!.body!.bookedRides}",
            onTap: () {},
            value: '10',
          ),
          SizedBox(
            height: _width / 64,
          ),
          // isLoading == false ? Container() :
          InfoCardSmall(
            title: "Scheduled Rides",
            // value: "${ridesCountModel!.body!.scheduledCount}",
            onTap: () {},
            isActive: true,
            value: '10',
          ),
          SizedBox(
            height: _width / 64,
          ),
          // isLoading == false ? Container() :
          InfoCardSmall(
            title: "Completed Rides",
            // value: "${ridesCountModel!.body!.completedCount}",
            onTap: () {},
            value: '10',
          ),
          SizedBox(
            height: _width / 64,
          ),
          // isLoading == false ? Container() :
          InfoCardSmall(
            title: "Cancelled Rides",
            // value: "${ridesCountModel!.body!.cancelledCount}",
            onTap: () {},
            value: '10',
          ),
        ],
      ),
    );
  }

   buildDriverSectionLarge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        border: Border.all(color: lightGrey, width: .5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  text: "Driver Chart",
                  size: 20,
                  weight: FontWeight.bold,
                  color: dark,
                ),
                Container(
                    width: 600,
                    height: 200,
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      palette: [yellow],
                      series: [
                        StackedColumnSeries(
                            dataSource: driverChartData,
                            xValueMapper: (DriverChartData ch, _) => ch.x,
                            yValueMapper: (DriverChartData ch, _) => ch.y)
                      ],
                    )),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 120,
            color: lightGrey,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: const [
                    UserInfo(
                      title: "Today\'s drivers",
                      count: "2",
                    ),
                    UserInfo(
                      title: "Last 7 days",
                      count: "10",
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: const [
                    UserInfo(
                      title: "Last 30 days",
                      count: "50",
                    ),
                    UserInfo(
                      title: "Last 12 months",
                      count: "1300",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDriverSectionSmall(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        border: Border.all(color: lightGrey, width: .5),
      ),
      child: Column(
        children: [
          Container(
            height: 260,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  text: "Driver Chart",
                  size: 20,
                  weight: FontWeight.bold,
                  color: dark,
                ),
                Container(
                    width: 600,
                    height: 200,
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      palette: [blue],
                      series: [
                        StackedColumnSeries(
                            dataSource: driverChartData,
                            xValueMapper: (DriverChartData ch, _) => ch.x,
                            yValueMapper: (DriverChartData ch, _) => ch.y)
                      ],
                    )),
              ],
            ),
          ),
          Container(
            width: 120,
            height: 1,
            color: lightGrey,
          ),
          Container(
            height: 260,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: const [
                    UserInfo(
                      title: "Today\'s drivers",
                      count: "2",
                    ),
                    UserInfo(
                      title: "Last 7 days",
                      count: "10",
                    ),
                  ],
                ),
                Row(
                  children: const [
                    UserInfo(
                      title: "Last 30 days",
                      count: "50",
                    ),
                    UserInfo(
                      title: "Last 12 months",
                      count: "1300",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DriverChartData {
  final String x;
  final int y;

  DriverChartData(this.x, this.y);
}