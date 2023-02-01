import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shop_spp/Provider/review_cart_provider.dart';
import 'package:shop_spp/Services/firebase_service.dart';

import '../Models/product_model.dart';
import '../widget/prodct_bottom_sheet.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen(
      {Key? key, this.category, this.product, this.productId})
      : super(key: key);
  final String? category;
  final Product? product;
  final String? productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final FirebaseService _service = FirebaseService();
  int? pageNumber = 0;
  final store = GetStorage();
  ScrollController? _scrollController;
  bool _isScrollDown = false;
  bool _showAppBar = true;
  String? _selectedSize;
  // ignore: unused_field
  String? _address;

  @override
  void initState() {
    getSize();
    getDeliveryAddress();
    _scrollController = ScrollController();
    _scrollController!.addListener(() {
      if (_scrollController!.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!_isScrollDown) {
          setState(() {
            _isScrollDown = true;
            _showAppBar = false;
          });
        }
      }
      if (_scrollController!.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_isScrollDown) {
          setState(() {
            _isScrollDown = false;
            _showAppBar = true;
          });
        }
      }
    });

    super.initState();
  }

  getSize() {
    if (widget.product!.sizeList != null) {
      setState(() {
        _selectedSize = widget.product!.sizeList![0];
      });
    }
  }

  Widget _sizedBox({double? height, double? width}) {
    return SizedBox(
      height: height ?? 0,
      width: width ?? 0,
    );
  }

  Widget _divider() {
    return Divider(
      color: Colors.grey.shade400,
      thickness: 1,
    );
  }

  getDeliveryAddress() {
    String? address = store.read('address');
    if (address != null) {
      setState(() {
        _address = address;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _showAppBar
          ? AppBar(
              elevation: 0,
              title: Text(
                widget.product!.productName!,
                style: const TextStyle(color: Colors.black, fontSize: 24),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.grey),
              actions: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.black26,
                  child: Icon(
                    IconlyLight.buy,
                    color: Colors.white,
                  ),
                ),
                _sizedBox(width: 10),
              ],
            )
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 290.0,
                width: double.infinity,
                child: Carousel(
                    dotColor: Colors.blue,
                    dotSize: 4.0,
                    dotSpacing: 15.0,
                    indicatorBgPadding: 5.0,
                    boxFit: BoxFit.cover,
                    autoplay: true,
                    animationCurve: Curves.fastOutSlowIn,
                    animationDuration: const Duration(milliseconds: 1000),
                    showIndicator: true,
                    dotBgColor: Colors.transparent,
                    dotVerticalPadding: 8.0,
                    dotPosition: DotPosition.bottomRight,
                    images: [
                      Hero(
                        tag: widget.product!.imageUrl![0],
                        child: PageView(
                          children: widget.product!.imageUrl!.map((e) {
                            return CachedNetworkImage(
                              imageUrl: e,
                            );
                          }).toList(),
                        ),
                      )
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ' Rs. ${widget.product!.salesPrice != null ? _service.formatedNumber(widget.product!.salesPrice!) : _service.formatedNumber(widget.product!.regularPrice!)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                              fontSize: 16),
                        ),
                        Row(
                          children: [
                            IconButton(
                                splashRadius: 20,
                                onPressed: () {},
                                icon: const Icon(
                                  IconlyLight.heart,
                                  size: 18,
                                  color: Colors.grey,
                                )),
                            IconButton(
                                splashRadius: 20,
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.share,
                                  size: 18,
                                  color: Colors.grey,
                                ))
                          ],
                        )
                      ],
                    ),
                    if (widget.product!.salesPrice != null)
                      Row(
                        children: [
                          Text(
                            'Rs. ${_service.formatedNumber(widget.product!.regularPrice)}',
                            style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey),
                          ),
                          _sizedBox(width: 10),
                          const Text('Discount'),
                          _sizedBox(width: 10),
                          Text(
                              '${(((widget.product!.regularPrice! - widget.product!.salesPrice!) / widget.product!.regularPrice!) * 100).toStringAsFixed(0)}%')
                        ],
                      ),
                    _sizedBox(height: 10),
                    Text(widget.product!.productName!),
                    Row(
                      children: [
                        Icon(
                          IconlyBold.star,
                          color: Theme.of(context).primaryColor,
                          size: 14,
                        ),
                        Icon(
                          IconlyBold.star,
                          color: Theme.of(context).primaryColor,
                          size: 14,
                        ),
                        Icon(
                          IconlyBold.star,
                          color: Theme.of(context).primaryColor,
                          size: 14,
                        ),
                        Icon(
                          IconlyBold.star,
                          color: Theme.of(context).primaryColor,
                          size: 14,
                        ),
                        Icon(
                          IconlyBold.star,
                          color: Theme.of(context).primaryColor,
                          size: 14,
                        ),
                        _sizedBox(width: 4),
                        const Text(
                          '(5)',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    _sizedBox(height: 10),
                    Text(
                      widget.product!.description!,
                      style: const TextStyle(fontSize: 14),
                    ),
                    if (widget.product!.sizeList != null &&
                        widget.product!.sizeList!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sizedBox(height: 10),
                          const Text('Variations',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14)),
                          SizedBox(
                            height: 40,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: widget.product!.sizeList!.map((e) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: OutlinedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                      _selectedSize == e
                                          ? Theme.of(context).primaryColor
                                          : Colors.white,
                                    )),
                                    onPressed: () {
                                      setState(() {
                                        _selectedSize = e;
                                      });
                                    },
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                          color: _selectedSize == null
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 10),
                    const AddCart(),
                    _divider(),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ProductBottomSheet(
                                product: widget.product,
                              );
                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Specifications',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            Icon(IconlyLight.arrowRight2, size: 14),
                          ],
                        ),
                      ),
                    ),
                    _divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Rating & Reviews (10)',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          'View all..',
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      ],
                    ),
                    _sizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Vishal Mart - 11 Feb 2022',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(IconlyBold.star,
                                size: 12,
                                color: Theme.of(context).primaryColor),
                            Icon(IconlyBold.star,
                                size: 12,
                                color: Theme.of(context).primaryColor),
                            Icon(IconlyBold.star,
                                size: 12,
                                color: Theme.of(context).primaryColor),
                            Icon(IconlyLight.star,
                                size: 12,
                                color: Theme.of(context).primaryColor),
                            Icon(IconlyLight.star,
                                size: 12,
                                color: Theme.of(context).primaryColor),
                          ],
                        ),
                      ],
                    ),
                    const Text('Nice product good Quality\n On time delivery'),
                    _sizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Mega Mart - 11 Feb 2022',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(IconlyBold.star,
                                size: 12,
                                color: Theme.of(context).primaryColor),
                            Icon(IconlyBold.star,
                                size: 12,
                                color: Theme.of(context).primaryColor),
                            Icon(IconlyBold.star,
                                size: 12,
                                color: Theme.of(context).primaryColor),
                            Icon(IconlyBold.star,
                                size: 12,
                                color: Theme.of(context).primaryColor),
                            Icon(IconlyLight.star,
                                size: 12,
                                color: Theme.of(context).primaryColor),
                          ],
                        ),
                      ],
                    ),
                    const Text('Good product good Quality\n On time delivery'),
                    _sizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Furnitre - 10 Feb 2022',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(IconlyBold.star,
                                size: 12,
                                color: Theme.of(context).primaryColor),
                            Icon(IconlyBold.star,
                                size: 12,
                                color: Theme.of(context).primaryColor),
                            Icon(IconlyBold.star,
                                size: 12,
                                color: Theme.of(context).primaryColor),
                            Icon(IconlyLight.star,
                                size: 12,
                                color: Theme.of(context).primaryColor),
                            Icon(IconlyLight.star,
                                size: 12,
                                color: Theme.of(context).primaryColor),
                          ],
                        ),
                      ],
                    ),
                    const Text(
                        'Best product Quality will be good\n On time delivery'),
                    _sizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Vishal Mart - 11 Feb 2022',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(IconlyBold.star,
                                size: 12,
                                color: Theme.of(context).primaryColor),
                            Icon(IconlyBold.star,
                                size: 12,
                                color: Theme.of(context).primaryColor),
                            Icon(IconlyBold.star,
                                size: 12,
                                color: Theme.of(context).primaryColor),
                            Icon(IconlyLight.star,
                                size: 12,
                                color: Theme.of(context).primaryColor),
                            Icon(IconlyLight.star,
                                size: 12,
                                color: Theme.of(context).primaryColor),
                          ],
                        ),
                      ],
                    ),
                    const Text('Good product good Quality\n On time delivery'),
                    _sizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Vishal Mart - 11 Feb 2022',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(IconlyBold.star,
                                size: 12,
                                color: Theme.of(context).primaryColor),
                            Icon(IconlyBold.star,
                                size: 12,
                                color: Theme.of(context).primaryColor),
                            Icon(IconlyBold.star,
                                size: 12,
                                color: Theme.of(context).primaryColor),
                            Icon(IconlyLight.star,
                                size: 12,
                                color: Theme.of(context).primaryColor),
                            Icon(IconlyLight.star,
                                size: 12,
                                color: Theme.of(context).primaryColor),
                          ],
                        ),
                      ],
                    ),
                    const Text('Good product good Quality\n On time delivery'),
                    _sizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddCart extends StatefulWidget {
  
  
  const AddCart({Key? key,})
      : super(key: key);

  @override
  State<AddCart> createState() => _AddCartState();
}

class _AddCartState extends State<AddCart> {
  @override
  Widget build(BuildContext context) {
    // ReviewCartProvider reviewCartProvider =
    //     Provider.of<ReviewCartProvider>(context);
    return Container(
      padding: const EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            // ignore: sized_box_for_whitespace
            child: Container(
              height: 60,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                    primary: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                 
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Add to Cart",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.shopping_bag_outlined),
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}



                    // _divider(),
                    // Row(
                    //   children: [
                    //     const Expanded(
                    //       flex: 2,
                    //       child: Text(
                    //         'Delivery',
                    //         style: TextStyle(color: Colors.grey, fontSize: 14),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       flex: 3,
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           InkWell(
                    //             onTap: () {},
                    //             child: Row(
                    //               mainAxisSize: MainAxisSize.min,
                    //               children: [
                    //                 Flexible(
                    //                   child: Text(
                    //                       _address ??
                    //                           'Delivery address not set...',
                    //                       maxLines: 1,
                    //                       overflow: TextOverflow.ellipsis,
                    //                       style: const TextStyle(
                    //                           color: Colors.grey,
                    //                           fontSize: 14)),
                    //                 ),
                    //                 const Icon(IconlyLight.location,
                    //                     size: 16, color: Colors.deepPurple),
                    //               ],
                    //             ),
                    //           ),
                    //           _sizedBox(height: 5),
                    //           const Text('Home Delivery within 3-4 days',
                    //               style: TextStyle(
                    //                   color: Colors.black, fontSize: 14)),
                    //           Text(
                    //               'Delivery Charge : ${widget.product!.chargeShipping! ? 'Rs.${widget.product!.shippingCharge!}' : 'Free'}',
                    //               style: const TextStyle(
                    //                   color: Colors.grey, fontSize: 14))
                    //         ],
                    //       ),
                    //     )
                    //   ],
                    // ),