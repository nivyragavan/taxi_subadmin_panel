import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_subadmin_panel/constant/style.dart';
import 'package:taxi_subadmin_panel/view/authentication_page.dart';
import 'package:taxi_subadmin_panel/view/dashboard_page.dart';
import 'package:taxi_subadmin_panel/view/home_page.dart';
import 'package:taxi_subadmin_panel/view/manual_booking_page.dart';
import 'package:taxi_subadmin_panel/view/profile_page.dart';
import 'package:taxi_subadmin_panel/view/rides/rides_booked_page.dart';
import 'package:taxi_subadmin_panel/view/rides/rides_cancelled_page.dart';
import 'package:taxi_subadmin_panel/view/rides/rides_completed_page.dart';
import 'package:taxi_subadmin_panel/view/rides/rides_in_progress_page.dart';
import 'package:taxi_subadmin_panel/view/rides/scheduled_rides_page.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    var subadminId = box.read('subadminId');
    print(subadminId);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sub Admin Dashboard',
      theme: ThemeData(
        scaffoldBackgroundColor: light,
        textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black),
        primarySwatch: Colors.grey,
      ),
      // initialRoute: AuthenticationPage.id,
      routes:{
        AuthenticationPage.id :(context) => AuthenticationPage(),
        // HomePage.id : (context) =>  const HomePage(),
        DashboardPage.id : (context) => const DashboardPage(),
        ProfilePage.id : (context) => const ProfilePage(),
        ManualBookingPage.id : (context) =>const ManualBookingPage(),
        RidesBookedPage.id : (context) => const RidesBookedPage(),
        RidesInProgressPage.id : (context) => const RidesInProgressPage(),
        CompletedRidesPage.id : (context) => const CompletedRidesPage(),
        CancelledRidesPage.id : (context) => const CancelledRidesPage(),
        ScheduledRidesPage.id : (context) => const ScheduledRidesPage(),
      },
      home:subadminId == null ? AuthenticationPage() : const DashboardPage(),
    );
  }
}
