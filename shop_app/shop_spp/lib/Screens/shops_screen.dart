import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:shop_spp/Screens/shops_product/home_productby_shop.dart';

import '../Models/vendor_model.dart';

class ShopsScreen extends StatelessWidget {
  static const String id = 'shops-screen';

  const ShopsScreen({
    Key? key,
    this.category,
    this.uid,
  }) : super(key: key);
  final String? category;
  final String? uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Colors.grey.shade100,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
            ),
          ],
          elevation: 0.0,
          centerTitle: true,
          title: const Text(
            'Shops',
            style:
                TextStyle(letterSpacing: 2, fontSize: 24, color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  image: const DecorationImage(
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1609081219090-a6d81d3085bf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1326&q=80"),
                      fit: BoxFit.cover)),
              child: Container(
                decoration: BoxDecoration(
                    gradient:
                        LinearGradient(begin: Alignment.bottomRight, colors: [
                  Colors.black.withOpacity(.8),
                  Colors.black.withOpacity(.2),
                ])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "New Shops",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: Text(
                          "Shop Now",
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0, left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  " Recommended Shops",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 20),
                ),
              ),
            ),
            FirestoreQueryBuilder<Vendor>(
              query: vendorQuery(category: category, vendorId: uid),
              builder: (context, snapshot, _) {
                // ...

                return GridView.builder(
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 20),
                    physics: const ScrollPhysics(),
                    itemCount: snapshot.docs.length,
                    itemBuilder: (context, index) {
                      if (snapshot.hasMore &&
                          index + 1 == snapshot.docs.length) {
                        snapshot.fetchMore();
                      }
                      var vendorIndex = snapshot.docs[index];
                      Vendor vendor = vendorIndex.data();
                      String vendorId = vendorIndex.id;
                      return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HomeProductByShops(
                                          vendor: vendor,
                                          vendorID: vendorId,
                                        )),
                              );
                            },
                            child: Card(
                              color: Colors.transparent,
                              elevation: 0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: vendor.logo!,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16 / 4,
                                    ),
                                    child: Text(vendor.businessName!,
                                        style: const TextStyle(
                                            color: Color(0xFFACACAC))),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      // childAspectRatio: .25,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
