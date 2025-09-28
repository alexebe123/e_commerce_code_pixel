import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Widget _buildReviewSection(bool isDesktop, bool isTablet) {
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
              isDesktop: isDesktop,
              isTablet: isTablet,
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

  Widget _buildPromotionsSection(bool isTablet, bool isDesktop) {
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
          ..._buildCheckboxList(promotions, isTablet, isDesktop),
        ],
      ),
    );
  }

  Widget _buildAvailabilitySection(bool isTablet, bool isDesktop) {
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
          ..._buildCheckboxList(availability, isTablet, isDesktop),
        ],
      ),
    );
  }

  Widget _buildStarRatingItem({
    required int stars,
    required bool isSelected,
    required ValueChanged<bool?> onChanged,
    required bool isTablet,
    required bool isDesktop,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isTablet ? 5 : (isDesktop ? 8 : 2),
      ),
      child: Row(
        children: [
          Transform.scale(
            scale: isTablet ? 0.8 : (isDesktop ? 1.5 : 0.5),
            child: Checkbox(
              value: isSelected,
              onChanged: onChanged,
              activeColor: Colors.pink,
            ),
          ),
          SizedBox(width: isTablet ? 3 : (isDesktop ? 8 : 1.5)),
          // بناء النجوم
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < stars ? Icons.star : Icons.star_border,
                color: index < stars ? Colors.amber : Colors.grey,
                size: isTablet ? 13 : (isDesktop ? 20 : 9),
              );
            }),
          ),
          SizedBox(width: isTablet ? 5 : (isDesktop ? 8 : 3)),
          Text(
            '$stars Star${stars > 1 ? 's' : ''}',
            style: TextStyle(fontSize: isTablet ? 13 : (isDesktop ? 18 : 9)),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCheckboxList(
    Map<String, bool> items,
    bool isTablet,
    bool isDesktop,
  ) {
    return items.entries.map((entry) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Transform.scale(
              scale: isTablet ? 1 : (isDesktop ? 1.5 : 0.5),
              child: Checkbox(
                value: entry.value,
                onChanged: (bool? value) {
                  setState(() {
                    items[entry.key] = value!;
                  });
                },
                activeColor: Colors.pink,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              entry.key,
              style: TextStyle(fontSize: isTablet ? 12 : (isDesktop ? 16 : 8)),
            ),
          ],
        ),
      );
    }).toList();
  }

  Future<void> launchUrls(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'لا يمكن فتح الرابط: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isTablet = w >= 700 && w < 1000;
    final isDesktop = w >= 1000;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Contact Widget
            (isTablet | isDesktop)
                ? ContactWidget(
                  width: w,
                  isDesktop: isDesktop,
                  isTablet: isTablet,
                )
                : SizedBox(),
            const SizedBox(height: 10),

            // AppBar Widget
            Container(
              width: w,
              height: 80,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "lib/res/images/logo.png",
                    height: isTablet ? 30 : (isDesktop ? 50 : 20),
                  ),
                  Wrap(
                    spacing: 1, // المسافة الأفقية بين العناصر
                    runSpacing: 1, // المسافة العمودية بين الصفوف
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
                                style: TextStyle(
                                  fontSize:
                                      isTablet ? 15 : (isDesktop ? 18 : 10),
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
                  (isTablet | isDesktop)
                      ? Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              FontAwesomeIcons.user,
                              size: isTablet ? 16 : (isDesktop ? 20 : 12),
                            ),
                          ),
                          SizedBox(width: isTablet ? 7 : (isDesktop ? 10 : 4)),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              FontAwesomeIcons.heart,
                              size: isTablet ? 16 : (isDesktop ? 20 : 12),
                            ),
                          ),
                          SizedBox(width: isTablet ? 7 : (isDesktop ? 10 : 4)),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              FontAwesomeIcons.bagShopping,
                              size: isTablet ? 16 : (isDesktop ? 20 : 12),
                            ),
                          ),
                        ],
                      )
                      : SizedBox(),
                ],
              ),
            ),

            // Carousel Widget
            CarouselWidget(width: w, imgList: imgList),
            const SizedBox(height: 20),

            // Filter and Products Section
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 12 : (isDesktop ? 16 : 8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Filter Sidebar
                  (isTablet | isDesktop)
                      ? SizedBox(
                        width: isTablet ? 180 : (isDesktop ? 280 : 100),
                        child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Text(
                              "Filter By",
                              style: TextStyle(
                                fontSize: isTablet ? 15 : (isDesktop ? 18 : 10),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            _buildSection(
                              title: 'By Categories',
                              children: _buildCheckboxList(
                                _categories,
                                isTablet,
                                isDesktop,
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildSection(
                              title: 'By Skin Type',
                              children: _buildCheckboxList(
                                _skinTypes,
                                isTablet,
                                isDesktop,
                              ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                            _buildReviewSection(isDesktop, isTablet),
                            const SizedBox(height: 20),
                            _buildPromotionsSection(isTablet, isDesktop),
                            const SizedBox(height: 20),
                            _buildAvailabilitySection(isTablet, isDesktop),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pink,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
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
                      )
                      : SizedBox(),

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
                        SizedBox(
                          height: 600,
                          width: 1000,
                          child: GridView.builder(
                            padding: const EdgeInsets.all(16),
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 300,
                              mainAxisExtent: 300, // حسب حجم الشاشة (1 / 3 / 5)
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio:
                                  isTablet
                                      ? 0.4
                                      : (isDesktop
                                          ? 0.6
                                          : 1), // 👈 يخلي الكنتينر مربع (العرض = الطول)
                            ),
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  context.go('/product/');
                                },
                                child: ProductCard(),
                              );
                            },
                          ),
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
  final bool isTablet;
  final bool isDesktop;

  const ContactWidget({
    super.key,
    required this.width,
    required this.isDesktop,
    required this.isTablet,
  });
  Future<void> launchUrls(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'لا يمكن فتح الرابط: $url';
    }
  }

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
          Text(
            "Contact us +213658948791",
            style: TextStyle(
              color: Colors.white,
              fontSize: isTablet ? 15 : (isDesktop ? 17 : 10),
            ),
          ),
          Row(
            children: [
              Text(
                "website   ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isTablet ? 15 : (isDesktop ? 17 : 10),
                ),
              ),
              InkWell(
                onTap: () {
                  launchUrls("https://electro-daimn-house.web.app/");
                },
                child: Text(
                  "Here",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTablet ? 15 : (isDesktop ? 17 : 10),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                color: Colors.white,
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.tiktok,
                  size: isTablet ? 15 : (isDesktop ? 17 : 10),
                ),
              ),
              IconButton(
                color: Colors.white,
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.facebook,
                  size: isTablet ? 15 : (isDesktop ? 17 : 10),
                ),
              ),
              IconButton(
                color: Colors.white,
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.twitter,
                  size: isTablet ? 15 : (isDesktop ? 17 : 10),
                ),
              ),
              IconButton(
                color: Colors.white,
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.instagram,
                  size: isTablet ? 15 : (isDesktop ? 17 : 10),
                ),
              ),
              IconButton(
                color: Colors.white,
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.linkedin,
                  size: isTablet ? 15 : (isDesktop ? 17 : 10),
                ),
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
    return Column(
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
    );
  }
}
