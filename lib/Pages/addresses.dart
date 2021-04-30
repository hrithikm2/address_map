import 'package:address_app/Lists/addressList.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'addressMap.dart';

class Address extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  AddressMap a2 = new AddressMap();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Manage Addresses"),
          backgroundColor: Color(0xff8e3c00),
        ),
        body: Column(
          children: [
            HeightBox(MediaQuery.of(context).size.height * 0.02),
            FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddressMap()));
                },
                child: "+ ADD NEW ADDRESS".text.orange400.make()),
            Expanded(
              child: ListView.separated(
                  itemCount: Addresses.addressType.length + 2,
                  scrollDirection: Axis.vertical,
                  separatorBuilder: (context, index) =>
                      Divider(thickness: 1, color: Colors.black),
                  shrinkWrap: true,
                  //itemExtent: MediaQuery.of(context).size.height * 0.1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0 ||
                        index == Addresses.addressType.length + 1) {
                      return Divider(thickness: 1, color: Colors.black);
                    }
                    return ListTile(
                      leading: Icon(Icons.location_on_outlined,
                          color: Colors.blue, size: 34),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeightBox(MediaQuery.of(context).size.height * 0.02),
                          Addresses.addressType[index - 1].text.make(),
                        ],
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeightBox(MediaQuery.of(context).size.height * 0.02),
                          '${a2.a1.currentAddress}'.text.make(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddressMap()));
                                  },
                                  child: "EDIT".text.orange400.make()),
                              FlatButton(
                                  onPressed: () {},
                                  child: "DELETE".text.orange400.make()),
                            ],
                          )
                        ],
                      ),
                      onTap: () {},
                    );
                  }),
            ),
            Divider(thickness: 1, color: Colors.black)
          ],
        ));
  }
}
