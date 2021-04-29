import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Wallet Transactions"),
          backgroundColor: Color(0xff480f18),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeightBox(MediaQuery.of(context).size.height * 0.02),
            ListTile(
              leading: Image.asset("resources/wallet.jpeg"),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                          text: 'Door',
                          style: TextStyle(color: Colors.orange,fontSize: 34),
                          children: <TextSpan>[
                        TextSpan(
                            text: 'Bell',
                            style: TextStyle(color: Colors.white,fontSize: 34))
                      ])),
                  HeightBox(MediaQuery.of(context).size.height * 0.02)
                ],
              ),
              subtitle: "₹ 0".text.size(28).make(),
              onTap: () {},
            ),
            HeightBox(MediaQuery.of(context).size.height * 0.02),
            Divider(
                thickness: 1,
                color: Colors.black
            )
          ],
        ));
  }
}
