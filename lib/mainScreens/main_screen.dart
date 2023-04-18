import 'package:drivers_ambulance_app/tabPages/home_tab.dart';
import 'package:drivers_ambulance_app/tabPages/profile_tab.dart';
import 'package:drivers_ambulance_app/tabPages/rating_tab.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget
{


  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin
{
  TabController? tabController;
  //this index will refer to the page the user at as there'll be multiple pages in the app
  int selectedindex =0;
//this's the method to be called when user click on a tab from tabBar
  onItemClicked(int index)
  {
    setState(() {
      selectedindex = index;
      tabController!.index = selectedindex;
    });
  }

   // this method will be called first when the user navigate ti main page
  //the method and what's inside of it will be the 1st thing to be implemented
  @override
  void initState() {
    super.initState();
    //number 4 here indicates that there'll be 4 pages
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
     body: TabBarView(
       physics: const NeverScrollableScrollPhysics(),
       controller: tabController,
       children: const [
         HomeTabPage(),
         RatingTabPage(),
         ProfileTabPage(),
       ],
     ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Ratings",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),

        ],
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.redAccent,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontSize: 18),
        showUnselectedLabels: true,
        currentIndex: selectedindex,
        onTap: onItemClicked,
      ),
    );
  }
}
