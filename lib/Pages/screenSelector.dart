import 'package:address_app/Pages/addressMap.dart';
import 'package:address_app/Pages/addresses.dart';
import 'package:address_app/Pages/contactUs.dart';
import 'package:address_app/wallet.dart';
import 'package:flutter/material.dart';
import 'package:address_app/services/getcurrentloc.dart';

class Screenless extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: ScreenSelector());
  }
}

class ScreenSelector extends StatefulWidget {
  @override
  _ScreenSelectorState createState() => _ScreenSelectorState();
}

class _ScreenSelectorState extends State<ScreenSelector> {
  AddressMap a4 = new AddressMap();
  Functions function = new Functions();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("App Task 4"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                child: Text("Contact us"),
                color: Colors.amber,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ContactUs()));
                },
              ),
              FlatButton(
                child: Text("Wallet Transactions"),
                color: Colors.amber,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Wallet()));
                },
              ),
              FlatButton(
                child: Text("Manage Address"),
                color: Colors.amber,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Address()));
                  //function.getAddress(a4.a1.r, a4.a1.t);
                },
              ),
            ],
          ),
        ));
  }
}
