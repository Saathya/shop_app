import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../../Models/product_model.dart';
import '../../Models/vendor_model.dart';
import '../product_details.dart';

class HomeProductByShops extends StatelessWidget {
  final Vendor? vendor;
  final String? vendorID;
  const HomeProductByShops({
    Key? key,
    this.vendor,
    this.vendorID,
  }) : super(key: key);

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
          title: Text(
            '${vendor!.businessName}',
            style: const TextStyle(
                letterSpacing: 2, fontSize: 24, color: Colors.black),
          ),
        ),
      ),
      body: FirestoreQueryBuilder<Product>(
        query: productQuery(seller: vendorID),
        builder: (context, snapshot, _) {
          // ...

          return GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              physics: const ScrollPhysics(),
              itemCount: snapshot.docs.length,
              itemBuilder: (context, index) {
                if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                  snapshot.fetchMore();
                }
                var productIndex = snapshot.docs[index];

                Product product = productIndex.data();
                String productID = productIndex.id;
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 500),
                          pageBuilder: (context, _, ___) {
                           return ProductDetailsScreen(
                              product: product,
                              productId: productID,
                            );
                          }),
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
                          child: Hero(
                            tag: product.imageUrl![0],
                            child: CachedNetworkImage(
                              imageUrl: product.imageUrl![0],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16 / 4,
                          ),
                          child: Text(product.productName!,
                              style: const TextStyle(color: Color(0xFFACACAC))),
                        ),
                        Text("${product.salesPrice}"),
                      ],
                    ),
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                // childAspectRatio: 1 / .95,
                mainAxisSpacing: 5,
                crossAxisSpacing: 10,
              ));
        },
      ),
    );
  }
}
