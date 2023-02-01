import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../Services/firebase_service.dart';
import 'banner_widget.dart';

class BrandHighlights extends StatefulWidget {
  const BrandHighlights({Key? key}) : super(key: key);

  @override
  State<BrandHighlights> createState() => _BrandHighlightsState();
}

class _BrandHighlightsState extends State<BrandHighlights> {
  final FirebaseService _service = FirebaseService();
  double _scrollPosition = 0;

  final List _productAds = [];

  @override
  void initState() {
    getproductAd();
    super.initState();
  }

  getproductAd() {
    return _service.productAd.get().then((QuerySnapshot querySnapshot) {
      // ignore: avoid_function_literals_in_foreach_calls
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _productAds.add(doc);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        children: [
          
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
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
          Container(
            height: 179,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade100,
            child: PageView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 4, 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Container(
                                height: 100,
                                color: Colors.deepOrange,
                                child: Center(
                                  child: CachedNetworkImage(
                                    imageUrl: _productAds[index]['image4'],
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    placeholder: (context, url) => GFShimmer(
                                      child: Container(
                                        height: 60,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 4, 8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Container(
                                      height: 60,
                                      color: Colors.red,
                                      child: Center(
                                          child: CachedNetworkImage(
                                        imageUrl: _productAds[index]['image1'],
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        placeholder: (context, url) =>
                                            GFShimmer(
                                          child: Container(
                                            height: 60,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                      )),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(4, 0, 8, 8),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Container(
                                        height: 60,
                                        color: Colors.red,
                                        child: Center(
                                            child: CachedNetworkImage(
                                          imageUrl: _productAds[index]
                                              ['image2'],
                                          fit: BoxFit.cover,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          placeholder: (context, url) =>
                                              GFShimmer(
                                            child: Container(
                                              height: 60,
                                              color: Colors.grey.shade500,
                                            ),
                                          ),
                                        )),
                                      )),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(4, 0, 8, 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            height: 160,
                            color: Colors.transparent,
                            child: Center(
                                child: CachedNetworkImage(
                              imageUrl: _productAds[index]['image3'],
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              placeholder: (context, url) => GFShimmer(
                                child: Container(
                                  height: 230,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            )),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
              itemCount: _productAds.length,
              onPageChanged: (val) {
                setState(() {
                  _scrollPosition = val.toDouble();
                });
              },
            ),
          ),
          DotIndicatorWidget(
            scrollPosition: _scrollPosition,
            dotscount: 2,
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
