import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learnly_assessment/models/product_model.dart';
import 'package:learnly_assessment/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool iconPressed = false;

  void updateBookmark() {
    setState(() {
      iconPressed = !iconPressed;
    });

    Fluttertoast.showToast(
      msg: iconPressed ? "Product bookmarked" : "Product removed from bookmarks",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: iconPressed ? Colors.blue : Colors.redAccent,
      textColor: Colors.black,
    );
  }

  void addToCartAndToast() {
    Provider.of<CartProvider>(context, listen: false).addProductToCart(widget.product);
    Fluttertoast.showToast(
      msg: "Product added to cart",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.yellow,
      textColor: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: [
            // Product Image
            Expanded(
              child: Center(
                child: FadeInImage(
                  fit: BoxFit.cover,
                  //height: 122,
                  //width: 120,
                  placeholder: const AssetImage('assets/loading.gif'),
                  image: NetworkImage(widget.product.image ?? 'https://storage.googleapis.com/cms-storage-bucket/64d67700f8293a9dc827.svg'),
                ),
              ),
            ),
            // Product deets
            Container(
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF202024),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product title
                    Text(
                      widget.product.title ?? 'error',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Product price
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.nairaSign,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(width: 2),
                        // Product price
                        Text(
                          '${widget.product.price}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Product rating
                    Row(
                      children: [
                        // Icon & rating
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow, size: 18),
                            SizedBox(width: 5),
                            // rating
                            Text(
                              '${widget.product.rating?.rate}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        // count
                        Text(
                          '(${widget.product.rating?.count} reviews)',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Product description
                    Text(
                      widget.product.description ?? 'Error',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    // Bookmark & Add to cart button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // bookmark
                        IconButton(
                          icon: Icon(
                            iconPressed ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            updateBookmark();
                          },
                        ),
                        // add to cart
                        ElevatedButton(
                          onPressed: () {
                            addToCartAndToast();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Add to cart',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
