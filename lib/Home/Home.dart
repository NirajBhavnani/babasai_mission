import 'package:babasai_mission/Authentication/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:babasai_mission/Config/config.dart';
import '../Widgets/loadingWidget.dart';

// import 'package:e_shop/Store/cart.dart';
// import 'package:e_shop/Store/product_page.dart';
// import 'package:e_shop/Counters/cartitemcounter.dart';
// import '../Widgets/myDrawer.dart';
// import '../Widgets/searchBox.dart';
// import '../Models/item.dart';

double width;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              'Babasai Mission',
              style: TextStyle(fontSize: 25.0, color: Colors.white)
          ),
          centerTitle: true,
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.logout, color: Colors.white,),
                  onPressed: (){
                    Babasai.auth.signOut().then((c){
                      Route route = MaterialPageRoute(builder: (c) => AuthenticScreen());
                      Navigator.pushReplacement(context, route);
                    });
                  },
                  tooltip: 'Log Out',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



// // Widget sourceInfo(ItemModel model, BuildContext context,
// //     {Color background, removeCartFunction}) {
// //   return InkWell();
// }



Widget card({Color primaryColor = Colors.redAccent, String imgPath}) {
  return Container();
}



void checkItemInCart(String productID, BuildContext context)
{
}