import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:shop_spp/Screens/product_details.dart';

import '../Models/product_model.dart';



class HomeProduct extends StatelessWidget {
  final String? category;

  const HomeProduct({
    Key? key,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder<Product>(
      query: productQuery(category: category),
      builder: (context, snapshot, _) {
        // ...

        return Column(mainAxisSize: MainAxisSize.min, children: [
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
                    "Electronic Gadget",
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
             padding:  EdgeInsets.only(top:20.0,left:20),
             child:  Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Product Highlights",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 20),
                ),
              ),
           ),

          Padding(
            padding: const EdgeInsets.only(
              
              left: 20,
              right: 20,
            ),
            
             child: GridView.builder(
                shrinkWrap: true,
                 padding: const EdgeInsets.only(top:6),
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
                            transitionDuration:
                                const Duration(milliseconds: 500),
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
                )),
          ),
        ]);
      },
    );
  }
}
