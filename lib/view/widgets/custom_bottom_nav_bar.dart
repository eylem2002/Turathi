import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:turathi/view/view_layer.dart';


class NavigationDestination {
  final IconData icon;
  final int index;

  NavigationDestination({
    required this.index,
    required this.icon,
  });
}

class NavigationBar extends StatelessWidget {
  final Color backgroundColor;

  final double elevation;
  final int selectedIndex;
  final Function(int) onDestinationSelected;
  final List<NavigationDestination> destinations;

  final double iconSize;

  const NavigationBar({
    super.key,
    required this.backgroundColor,

    required this.elevation,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {

    

    return BottomNavigationBar(
      
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: backgroundColor,
      type: BottomNavigationBarType.fixed,
      elevation: elevation,
      selectedItemColor: Colors.white,
      currentIndex: selectedIndex,
      items: destinations.map((destination) {
        return BottomNavigationBarItem(
          icon: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: selectedIndex == destination.index
                    ? Color(0xff6E232F)
                    : Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Icon(
              destination.icon,
              color: selectedIndex == destination.index
                  ? Colors.white
                  : Color(0xff6E232F),
                     size: iconSize, 
            ),
          ),
          label: '',
        );
      }).toList(),
      
      // selectedLabelStyle: labelStyle,
      onTap: onDestinationSelected,
    );
  }
}

class CustomeBottomNavBar extends StatelessWidget {
  const CustomeBottomNavBar({Key? key});

  @override
  Widget build(BuildContext context) {
    
    final controller = Get.put(NavigationController());
    return Scaffold(

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Obx(
          () => NavigationBar(
            backgroundColor: Color(0xffF0F2F6),

            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) {
              return controller.selectedIndex.value = index;
            },
            destinations: [
              NavigationDestination(
                icon: Icons.map_outlined,
                index: 0,
              ),
              NavigationDestination(icon: Icons.people_outline_sharp, index: 1),
              NavigationDestination(icon: Icons.home_rounded, index: 2),
              NavigationDestination(icon: Icons.favorite_outline, index: 3),
              NavigationDestination(icon: Icons.person_outline, index: 4),
            ],

              iconSize: LayoutManager.widthNHeight0(context, 1)*0.064, 
          ),
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  
  final Rx<int> selectedIndex = 2.obs; 
  final screens = [LocationPage(),CommunityScreen(),HomeScreen(),FavoriteScreen(),ProfileScreen()];
}
