import 'package:flutter/material.dart';
import 'login.dart';

void main() {
 runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 const MyApp({super.key});


 @override
 Widget build(BuildContext context) {
  
   return MaterialApp(
debugShowCheckedModeBanner: false,
     title: 'Flutter Demo',

     theme: ThemeData(
       
       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
     ),
    home: const Login(),
   );
 }
}


class BottomBarNavigation extends StatefulWidget {
 const BottomBarNavigation({super.key});


 @override
 State<BottomBarNavigation> createState() => _BottomBarNavigationState();
}



class _BottomBarNavigationState extends State<BottomBarNavigation> {
 int _selectedIndex = 0;



 static const List<Widget> _pages = <Widget>[

   Center(child: Text('Home', style: TextStyle(fontSize: 32))),

  //  TodoListPage(),
  //  ProfilePage(),
 ];


 void _onItemTapped(int index) {

   setState(() {

     _selectedIndex = index;
   });
 }


 @override
 Widget build(BuildContext context) {
   return Scaffold(
   
     appBar: AppBar(
       title: const Text('My App'),
     ),

     body: _pages[_selectedIndex],
    
     bottomNavigationBar: BottomNavigationBar(
      
       items: const <BottomNavigationBarItem>[
       
         BottomNavigationBarItem(
           icon: Icon(Icons.home),
           label: 'Home',
         ),

         BottomNavigationBarItem(
           icon: Icon(Icons.list),
           label: 'To-Do List',
         ),
         
         BottomNavigationBarItem(
           icon: Icon(Icons.person),
           label: 'Profile',
         ),
       ],
       
       currentIndex: _selectedIndex,
     
       selectedItemColor: Colors.deepPurple,
       
       onTap: _onItemTapped,
     ),
   );
 }
}

