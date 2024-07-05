import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:learnly_assessment/providers/api_provider.dart';

class ProductListScreen extends StatelessWidget {
  final ApiProvider apiProvider;

  const ProductListScreen({
    super.key,
    required this.apiProvider,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65, //0.95, // tweak this
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: apiProvider.products.length,
      itemBuilder: (context, index) {
        final product = apiProvider.products[index];
        return GestureDetector(
          onTap: () {
            context.go('/productdetail', extra: product);
          },
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: FadeInImage(
                          fit: BoxFit.cover,
                          placeholder: const AssetImage('assets/loading.gif'),
                          image: NetworkImage(product.image ?? 'https://storage.googleapis.com/cms-storage-bucket/64d67700f8293a9dc827.svg'),
                        ).image, //NetworkImage(product.image ?? ''),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Product Title
                  Text(
                    product.title ?? 'Error',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Product rating & category
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Product rating & price
                      Row(
                        children: [
                          // rating
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green[400],
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            child: Row(
                              children: [
                                // icon
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                SizedBox(width: 5),
                                // rating
                                Text(
                                  '${product.rating?.rate}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 5),
                        ],
                      ),
                      // Product price
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.nairaSign,
                            size: 15,
                          ),
                          Text(
                            product.price.toString(),
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    product.category?.toUpperCase() ?? 'error',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
