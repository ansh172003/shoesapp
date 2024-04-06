import 'package:flutter/material.dart';
import 'package:shop_app/providers/global_var.dart';
import 'package:shop_app/widgets/product_card.dart';
import 'package:shop_app/pages/product_detail_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const ["All", "Addidas", "Nike", "Bata"];
  late String selectedFilter;
  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromRGBO(225, 225, 225, 1)),
      borderRadius: BorderRadius.horizontal(left: Radius.circular(50)),
    );
    return SafeArea(
        child: Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const IconButton(
            icon: Icon(
              Icons.download,
              color: Colors.black,
            ),
            onPressed: _launchURLGDrive,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Shoes\nCollection",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const Expanded(
              child: TextField(
            decoration: InputDecoration(
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
              border: border,
              enabledBorder: border,
              focusedBorder: border,
            ),
          )),
        ],
      ),
      SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: filters.length,
          itemBuilder: (context, index) {
            final filter = filters[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedFilter = filter;
                  });
                },
                child: Chip(
                  backgroundColor: selectedFilter == filter
                      ? Theme.of(context).colorScheme.primary
                      : const Color.fromRGBO(245, 247, 249, 1),
                  label: Text(filter),
                  side:
                      const BorderSide(color: Color.fromRGBO(245, 247, 249, 1)),
                  labelStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            );
          },
        ),
      ),
      Expanded(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 1080) {
              return GridView.builder(
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1.75),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(CupertinoPageRoute(builder: (context) {
                          return ProductDetailsPage(product: product);
                        }));
                      },
                      child: ProductCard(
                        color: index % 2 == 0
                            ? const Color.fromRGBO(216, 240, 253, 1)
                            : const Color.fromRGBO(245, 247, 249, 1),
                        title: product['title'] as String,
                        price: product['price'] as double,
                        image: product['imageUrl'] as String,
                      ),
                    );
                  });
            } else {
              return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(CupertinoPageRoute(builder: (context) {
                          return ProductDetailsPage(product: product);
                        }));
                      },
                      child: ProductCard(
                        color: index % 2 == 0
                            ? const Color.fromRGBO(216, 240, 253, 1)
                            : const Color.fromRGBO(245, 247, 249, 1),
                        title: product['title'] as String,
                        price: product['price'] as double,
                        image: product['imageUrl'] as String,
                      ),
                    );
                  });
            }
          },
        ),
      ),
    ]));
  }
}

_launchURLGDrive() async {
  const url = 'https://bit.ly/shoesappansh';
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}
