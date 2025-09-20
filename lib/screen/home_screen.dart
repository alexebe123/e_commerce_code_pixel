import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _hoverIndex = -1; // باش نعرف وين راهي الفأرة
  final List<String> items = ["Home", "About", "Shop", "Contact"];
  final List<String> imgList = [
    "lib/res/images/1.jpg",
    "lib/res/images/2.jpg",
    "lib/res/images/3.png",
    "lib/res/images/4.jpg",
  ];
  final Map<String, String> typeMap = {
    'All': 'All',
    'Web Apps': 'web', // تأكد أن 'web' هو نفس القيمة في model
    'Mobile Apps': 'Mobile', // أو 'mobile' حسب ما تحفظ في project.type
    'Desktop App': 'Desktop',
  };

  int currentPage = 1; // الصفحة الحالية
  final int totalPages = 10; // عدد الصفحات الكلي
  List<Widget> _buildPageNumbers() {
    List<Widget> pages = [];

    for (int i = 1; i <= totalPages; i++) {
      // لإظهار أول 3 صفحات + آخر صفحة + الصفحة الحالية مع النقاط
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Start  Contact Widget
            ContactWidget(width: width), // End  Contact Widget
            SizedBox(height: 10),
            // Satrt  AppBAr Widget
            Container(
              width: width,
              height: 40,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset("lib/res/images/logo.png"),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(items.length, (index) {
                        return MouseRegion(
                          onEnter: (_) {
                            _hoverIndex = index;
                            setState(() {});
                          },
                          onExit: (_) {
                            _hoverIndex = -1;
                            setState(() {});
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
                  ),
                  SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesomeIcons.user),
                        ),
                        SizedBox(width: 20),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesomeIcons.heart),
                        ),
                        SizedBox(width: 20),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesomeIcons.message),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // End  AppBAr Widget
            // Satrt  CarouselSlider imahge Widget
            CarouselWidget(width: width, imgList: imgList),
            // End  CarouselSlider imahge Widget
            SizedBox(height: 10),
            // Satrt  Products Widget
            SizedBox(
              height: height,
              width: width - 250,
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    width: width,
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween, // يخلي واحد يسار وواحد يمين
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // اليسار
                        SizedBox(
                          child: const Text("Showing 1-12 of 2560 results"),
                        ),
                        // اليمين
                        Row(
                          children: [
                            const Text(
                              "Sort by: ",
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(width: 8),
                            DropdownButton<String>(
                              dropdownColor: Colors.white,
                              value: "All",
                              style: const TextStyle(color: Colors.black),
                              items:
                                  [
                                        "All",
                                        "Web Apps",
                                        "Mobile Apps",
                                        "Desktop App",
                                      ]
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(
                                            e,
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (value) {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width,
                    height: 40,
                    child: Row(
                      children: [
                        Text("Active Filter"),
                        SizedBox(width: 10),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green[900],
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                            "Price | 200 DA - 2000 DA   x",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green[900],
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                            "Best seller   x",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green[900],
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                            "In Stock   x",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Clear All",
                              style: TextStyle(color: Colors.orangeAccent),
                            ),
                            Container(
                              height: 2,
                              width: 45,
                              color: Colors.orangeAccent,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4, // عدد الأعمدة
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.7, // تناسب الطول/العرض
                          ),
                      itemBuilder: (context, index) => ProductCard(),
                      itemCount: 8,
                    ),
                  ),
                ],
              ),
            ),
            // End  Products Widget
            SizedBox(height: 10),
            // Satrt Pagination System
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // زر السابق
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

                // الصفحات
                ..._buildPageNumbers(),

                // زر التالي
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

            // End Pagination System
          ],
        ),
      ),
    );
  }
}

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({super.key, required this.width, required this.imgList});

  final double width;
  final List<String> imgList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: width,
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 200,
              autoPlay: true, // ✅ يتحرك تلقائي
              autoPlayInterval: Duration(seconds: 3), // مدة كل صورة
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              enlargeCenterPage: true, // يكبر الصورة الوسطى
              viewportFraction: 0.9, // عرض كل صورة
            ),
            items:
                imgList
                    .map(
                      (item) => Container(
                        margin: EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            item,
                            fit: BoxFit.cover,
                            width: width,
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Shop",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                ),
                Text(
                  "Home / Shop",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
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
  const ContactWidget({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: const Color.fromARGB(255, 1, 85, 3),
      height: 40,
      child: Row(
        children: [
          SizedBox(
            width: width,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  child: Text(
                    "Contact us +213658948791",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  child: Row(
                    children: [
                      Text(
                        "If you want to make a website ",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "https://electro-daimn-house.web.app/",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Row(
                    children: [
                      IconButton(
                        color: Colors.white,
                        onPressed: () {},
                        icon: Icon(FontAwesomeIcons.tiktok),
                      ),
                      IconButton(
                        color: Colors.white,
                        onPressed: () {},
                        icon: Icon(FontAwesomeIcons.facebook),
                      ),
                      IconButton(
                        color: Colors.white,
                        onPressed: () {},
                        icon: Icon(FontAwesomeIcons.twitter),
                      ),
                      IconButton(
                        color: Colors.white,
                        onPressed: () {},
                        icon: Icon(FontAwesomeIcons.instagram),
                      ),
                      IconButton(
                        color: Colors.white,
                        onPressed: () {},
                        icon: Icon(FontAwesomeIcons.linkedin),
                      ),
                    ],
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

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go('/products/dsdss'),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الجزء العلوي (صورة + خصم + أيقونات)
            Stack(
              children: [
                // صورة المنتج
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    "lib/res/images/1.jpg",
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                // زر الخصم
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
                      ),
                    ),
                  ),
                ),

                // الأيقونات
                Positioned(
                  top: 12,
                  right: 12,
                  child: Column(
                    children: [
                      _buildIcon(FontAwesomeIcons.heart),
                      const SizedBox(height: 10),
                      _buildIcon(FontAwesomeIcons.expand),
                      const SizedBox(height: 10),
                      _buildIcon(FontAwesomeIcons.bagShopping),
                    ],
                  ),
                ),
              ],
            ),

            // معلومات المنتج
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Sker Cate",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      // تقييم النجوم
                      Row(
                        children: const [
                          Icon(Icons.star, color: Colors.amber, size: 18),
                          SizedBox(width: 4),
                          Text(
                            "4.9",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "SäkSculpt Serum",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  // السعر
                  Row(
                    children: const [
                      Text(
                        "\$35.00 ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
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
      ),
    );
  }

  // ويدجت صغيرة لبناء الأيقونات الدائرية
  static Widget _buildIcon(IconData icon) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.white,
      child: Icon(icon, color: Colors.black87, size: 18),
    );
  }
}
