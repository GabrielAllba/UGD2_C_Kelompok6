import 'package:flutter/material.dart';
import 'package:ugd2_c_kelompok6/screens/home.dart';
import 'package:ugd2_c_kelompok6/screens/pemesanan.dart';
import 'package:ugd2_c_kelompok6/screens/profile.dart';
import 'package:ugd2_c_kelompok6/screens/profile_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      
      builder: (context, orientation, screenType){
         Device.orientation == Orientation.portrait
        ? Container(
        width: 100.w,
        height: 20.5.h,
      )

      : Container(
        width: 100.w,
        height: 12.5.h,
      );

      Device.screenType == ScreenType.tablet
        ? Container(
      width: 100.w,
      height: 20.5.h,
      )

      : Container(
        width: 100.w,
        height: 12.5.h,
      );
      
      Widget activePage = const HomeScreen();

      if (_selectedPageIndex == 0) {
        activePage = const HomeScreen();
      } else if (_selectedPageIndex == 1) {
        activePage = const Pemesanan();
      } else if (_selectedPageIndex == 2) {
        activePage = const Profile();
      }

      return Scaffold(
        body: activePage,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPageIndex,
          onTap: _selectPage,
          fixedColor: Theme.of(context).primaryColor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined),
              label: 'Pemesanan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_add_outlined),
              label: 'Profile',
            ),
          ],
        ),
      );
      }
    );
  }
}
