import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  int? idUser;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void getIdUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      idUser = pref.getInt('id')!;
    });
  }

  @override
  void initState() {
    super.initState();
    getIdUser();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
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
        activePage = Pemesanan(id_user: idUser!);
      } else if (_selectedPageIndex == 2) {
        activePage = Profile(
          id: idUser!,
        );
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
    });
  }
}
