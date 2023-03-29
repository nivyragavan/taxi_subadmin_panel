// import 'package:flutter/material.dart';
// import 'package:flutter_admin_scaffold/admin_scaffold.dart';
// import 'package:get/get.dart';
// import 'package:taxi_subadmin_panel/constant/style.dart';
// import 'package:taxi_subadmin_panel/view/authentication_page.dart';
// import 'package:taxi_subadmin_panel/view/dashboard_page.dart';
// import 'package:taxi_subadmin_panel/view/manual_booking_page.dart';
// import 'package:taxi_subadmin_panel/view/profile_page.dart';
// import 'package:taxi_subadmin_panel/view/rides/rides_booked_page.dart';
// import 'package:taxi_subadmin_panel/view/rides/rides_cancelled_page.dart';
// import 'package:taxi_subadmin_panel/view/rides/rides_completed_page.dart';
// import 'package:taxi_subadmin_panel/view/rides/rides_in_progress_page.dart';
// import 'package:taxi_subadmin_panel/view/rides/scheduled_rides_page.dart';
//
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   static const String id = "home_page";
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   Widget selectedPage = const DashboardPage();
//
//   currentPage(item) {
//     switch (item.route) {
//       case DashboardPage.id:
//         setState(() {
//           selectedPage = const DashboardPage();
//         });
//         break;
//       case ProfilePage.id:
//         setState(() {
//           selectedPage = const ProfilePage();
//         });
//         break;
//       case ManualBookingPage.id:
//         setState(() {
//           selectedPage = const ManualBookingPage();
//         });
//         break;
//       case RidesBookedPage.id:
//         setState(() {
//           selectedPage = const RidesBookedPage();
//         });
//         break;
//       case RidesInProgressPage.id:
//         setState(() {
//           selectedPage = const RidesInProgressPage();
//         });
//         break;
//       case CompletedRidesPage.id:
//         setState(() {
//           selectedPage = const CompletedRidesPage();
//         });
//         break;
//       case CancelledRidesPage.id:
//         setState(() {
//           selectedPage = const CancelledRidesPage();
//         });
//         break;
//       case ScheduledRidesPage.id:
//         setState(() {
//           selectedPage = const ScheduledRidesPage();
//         });
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AdminScaffold(
//       backgroundColor: light,
//       appBar: AppBar(
//         title: const Text(
//           'Sub Admin Panel',
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: lightGreen,
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Get.offAll(AuthenticationPage());
//               },
//               icon: const Icon(Icons.logout,color: Colors.black,))
//         ],
//       ),
//       sideBar:
//       body: SizedBox(
//           width: Get.width,
//           height: Get.height,
//           child: selectedPage),
//     );
//   }
// }
