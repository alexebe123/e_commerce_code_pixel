import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _hoverIndex = -1;
  final List<String> items = ["Home", "About", "Shop", "Contact"];
  final List<String> imgList = [
    "lib/res/images/1.jpg",
    "lib/res/images/2.jpg",
    "lib/res/images/3.png",
    "lib/res/images/4.jpg",
  ];

  int currentPage = 1;
  final int totalPages = 10;

  final Map<String, bool> _categories = {
    'Skin Care': false,
    'Makeup': false,
    'Hair Care': false,
    'Fragrances': false,
    'Nail Care': false,
    'Body Care': false,
  };

  final Map<String, bool> _skinTypes = {
    'Normal': false,
    'Oily': false,
    'Dry': false,
    'Combination': false,
    'Sensitive': false,
  };

  final Map<int, bool> starRatings = {
    5: false,
    4: false,
    3: false,
    2: false,
    1: false,
  };

  final Map<String, bool> promotions = {
    'New Arrivals': false,
    'Best Sellers': true,
    'On Sale': false,
  };

  final Map<String, bool> availability = {
    'In Stock': true,
    'Out of Stock': false,
  };

  RangeValues _priceRange = const RangeValues(10, 100);
  final double minPrice = 10;
  final double maxPrice = 100;

  List<Widget> _buildPageNumbers() {
    List<Widget> pages = [];

    for (int i = 1; i <= totalPages; i++) {
      if (i == 1 ||
          i == totalPages ||
          (i >= currentPage - 1 && i <= currentPage + 1)) {
        pages.add(
          GestureDetector(
            onTap: () {
              setState(() {
                currentPage = i;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color:
                    currentPage == i
                        ? Colors.green.shade900
                        : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Text(
                "$i",
                style: TextStyle(
                  color: currentPage == i ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      } else if (i == 2 && currentPage > 3) {
        pages.add(const Text("..."));
      } else if (i == totalPages - 1 && currentPage < totalPages - 2) {
        pages.add(const Text("..."));
      }
    }

    return pages;
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildReviewSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Review',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          for (var entry in starRatings.entries)
            _buildStarRatingItem(
              stars: entry.key,
              isSelected: entry.value,
              onChanged: (value) {
                setState(() {
                  starRatings[entry.key] = value!;
                });
              },
            ),
        ],
      ),
    );
  }

  Widget _buildPromotionsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'By Promotions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ..._buildCheckboxList(promotions),
        ],
      ),
    );
  }

  Widget _buildAvailabilitySection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Availability',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ..._buildCheckboxList(availability),
        ],
      ),
    );
  }

  Widget _buildStarRatingItem({
    required int stars,
    required bool isSelected,
    required ValueChanged<bool?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Checkbox(
            value: isSelected,
            onChanged: onChanged,
            activeColor: Colors.pink,
          ),
          const SizedBox(width: 8),
          // بناء النجوم
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < stars ? Icons.star : Icons.star_border,
                color: index < stars ? Colors.amber : Colors.grey,
                size: 20,
              );
            }),
          ),
          const SizedBox(width: 8),
          Text('$stars Star${stars > 1 ? 's' : ''}'),
        ],
      ),
    );
  }

  List<Widget> _buildCheckboxList(Map<String, bool> items) {
    return items.entries.map((entry) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Checkbox(
              value: entry.value,
              onChanged: (bool? value) {
                setState(() {
                  items[entry.key] = value!;
                });
              },
              activeColor: Colors.pink,
            ),
            const SizedBox(width: 8),
            Text(entry.key, style: const TextStyle(fontSize: 16)),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Contact Widget
            ContactWidget(width: width),
            const SizedBox(height: 10),

            // AppBar Widget
            Container(
              width: width,
              height: 80,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("lib/res/images/logo.png", height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(items.length, (index) {
                      return MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            _hoverIndex = index;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            _hoverIndex = -1;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                items[index],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height: 2,
                                width: _hoverIndex == index ? 40 : 0,
                                color: Colors.green.shade900,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(FontAwesomeIcons.user),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(FontAwesomeIcons.heart),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(FontAwesomeIcons.bagShopping),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Carousel Widget
            CarouselWidget(width: width, imgList: imgList),
            const SizedBox(height: 20),

            // Filter and Products Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Filter Sidebar
                  SizedBox(
                    width: 280,
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Text(
                          "Filter By",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _buildSection(
                          title: 'By Categories',
                          children: _buildCheckboxList(_categories),
                        ),
                        const SizedBox(height: 20),
                        _buildSection(
                          title: 'By Skin Type',
                          children: _buildCheckboxList(_skinTypes),
                        ),
                        const SizedBox(height: 20),
                        _buildSection(
                          title: 'Price',
                          children: [
                            RangeSlider(
                              values: _priceRange,
                              min: minPrice,
                              max: maxPrice,
                              divisions: 9,
                              labels: RangeLabels(
                                '\$${_priceRange.start.toStringAsFixed(2)}',
                                '\$${_priceRange.end.toStringAsFixed(2)}',
                              ),
                              onChanged: (RangeValues values) {
                                setState(() {
                                  _priceRange = values;
                                });
                              },
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$${minPrice.toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Text(
                                  '\$${maxPrice.toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildReviewSection(),
                        const SizedBox(height: 20),
                        _buildPromotionsSection(),
                        const SizedBox(height: 20),
                        _buildAvailabilitySection(),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Apply Filters',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),

                  const SizedBox(width: 20),

                  // Products Section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Filter and Sort Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Showing 1-12 of 2560 results"),
                            Row(
                              children: [
                                const Text("Sort by: "),
                                const SizedBox(width: 8),
                                DropdownButton<String>(
                                  value: "All",
                                  items:
                                      ["All", "Popular", "Newest", "Price"].map(
                                        (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        },
                                      ).toList(),
                                  onChanged: (value) {},
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Active Filters
                        Wrap(
                          spacing: 10,
                          children: [
                            FilterChip(
                              label: const Text("Price | 200 DA - 2000 DA"),
                              onSelected: (bool value) {},
                              backgroundColor: Colors.green[900],
                              labelStyle: const TextStyle(color: Colors.white),
                              deleteIcon: const Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.white,
                              ),
                              onDeleted: () {},
                            ),
                            FilterChip(
                              label: const Text("Best seller"),
                              onSelected: (bool value) {},
                              backgroundColor: Colors.green[900],
                              labelStyle: const TextStyle(color: Colors.white),
                              deleteIcon: const Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.white,
                              ),
                              onDeleted: () {},
                            ),
                            FilterChip(
                              label: const Text("In Stock"),
                              onSelected: (bool value) {},
                              backgroundColor: Colors.green[900],
                              labelStyle: const TextStyle(color: Colors.white),
                              deleteIcon: const Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.white,
                              ),
                              onDeleted: () {},
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Text(
                                "Clear All",
                                style: TextStyle(
                                  color: Colors.orange,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Products Grid
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 0.75,
                              ),
                          itemCount: 6,
                          itemBuilder: (context, index) => const ProductCard(),
                        ),

                        const SizedBox(height: 20),

                        // Pagination
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed:
                                  currentPage > 1
                                      ? () {
                                        setState(() {
                                          currentPage--;
                                        });
                                      }
                                      : null,
                              icon: const Icon(Icons.chevron_left),
                            ),
                            ..._buildPageNumbers(),
                            IconButton(
                              onPressed:
                                  currentPage < totalPages
                                      ? () {
                                        setState(() {
                                          currentPage++;
                                        });
                                      }
                                      : null,
                              icon: const Icon(Icons.chevron_right),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CarouselWidget extends StatelessWidget {
  final double width;
  final List<String> imgList;

  const CarouselWidget({super.key, required this.width, required this.imgList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: width,
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 300,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              enlargeCenterPage: true,
              viewportFraction: 0.9,
            ),
            items:
                imgList.map((item) {
                  return Container(
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(item),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const Text(
                  "Shop",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.black,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Home / Shop",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey[200],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ContactWidget extends StatelessWidget {
  final double width;

  const ContactWidget({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: Colors.green[900],
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Contact us +213658948791",
            style: TextStyle(color: Colors.white),
          ),
          const Text(
            "If you want to make a website https://example.com/",
            style: TextStyle(color: Colors.white),
          ),
          Row(
            children: [
              IconButton(
                color: Colors.white,
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.tiktok, size: 16),
              ),
              IconButton(
                color: Colors.white,
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.facebook, size: 16),
              ),
              IconButton(
                color: Colors.white,
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.twitter, size: 16),
              ),
              IconButton(
                color: Colors.white,
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.instagram, size: 16),
              ),
              IconButton(
                color: Colors.white,
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.linkedin, size: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.asset(
                  "lib/res/images/1.jpg",
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade700,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "50% off",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Product Details
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Skin Care",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 4),
                        Text(
                          "4.9",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  "Sculpt Serum",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "\$35.00 ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "\$70.00",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
