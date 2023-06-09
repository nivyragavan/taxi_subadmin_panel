import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:taxi_subadmin_panel/constant/style.dart';
import 'package:taxi_subadmin_panel/view/dashboard_page.dart';
import 'package:taxi_subadmin_panel/view/manual_booking_page.dart';
import 'package:taxi_subadmin_panel/view/profile_page.dart';
import 'package:taxi_subadmin_panel/view/rides/rides_booked_page.dart';
import 'package:taxi_subadmin_panel/view/rides/rides_cancelled_page.dart';
import 'package:taxi_subadmin_panel/view/rides/rides_completed_page.dart';
import 'package:taxi_subadmin_panel/view/rides/rides_in_progress_page.dart';
import 'package:taxi_subadmin_panel/view/rides/scheduled_rides_page.dart';

class SideBarWidget {
  sidebarMenus(selectedRoute) {
    return SideBar(
      backgroundColor: yellow,
      iconColor: black,
      activeIconColor: grey,
      textStyle:  TextStyle(
        color: black,
        fontSize: 15,
      ),
      activeTextStyle: TextStyle(
        color: grey,
        fontSize: 15,
      ),
      activeBackgroundColor: blue,
      borderColor: Colors.grey,
      items: const [
        AdminMenuItem(
          title: 'Dashboard',
          route: DashboardPage.id,
          icon: Icons.dashboard,
        ),
        AdminMenuItem(
          title: 'Profile',
          route: ProfilePage.id,
          icon: Icons.account_circle_outlined,
        ),
        AdminMenuItem(
          title: 'Manual Booking',
          route: ManualBookingPage.id,
          icon: Icons.add,
        ),
        AdminMenuItem(title: 'Rides', icon: Icons.drive_eta, children: [
          AdminMenuItem(
            title: 'Booked Rides',
            route: RidesBookedPage.id,
            icon: Icons.schedule_rounded,
          ),
          AdminMenuItem(
            title: 'Rides In Progress',
            route: RidesInProgressPage.id,
            icon: Icons.loop_rounded,
          ),
          AdminMenuItem(
            title: 'Completed Rides',
            route: CompletedRidesPage.id,
            icon: Icons.check_circle_outlined,
          ),
          AdminMenuItem(
            title: 'Cancelled Rides',
            route: CancelledRidesPage.id,
            icon: Icons.cancel_outlined,
          ),
          AdminMenuItem(
            title: 'Scheduled Rides',
            route: ScheduledRidesPage.id,
            icon: Icons.history_toggle_off,
          ),
        ]),
      ],
      footer: Container(
          width: double.infinity,
          height: 100,
          color: yellow,
          child: Image.asset('assets/icons/logo.png',
          )),
      selectedRoute: selectedRoute,
      onSelected: (item) {
        Get.toNamed(item.route!);
      },
    );
  }
}
