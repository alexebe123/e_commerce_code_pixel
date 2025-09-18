import 'package:e_commerce_code_pixel/res/app_conste.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Start  Contact Widget
            Container(
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
            ), // End  Contact Widget
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
                      children: [
                        Text("Home"),
                        SizedBox(width: 10),
                        Text("Home"),
                        SizedBox(width: 10),
                        Text("Home"),
                        SizedBox(width: 10),
                        Text("Home"),
                        SizedBox(width: 10),
                        Text("Home"),
                        SizedBox(width: 10),
                        Text("Home"),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesomeIcons.user),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesomeIcons.user),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // End  AppBAr Widget
            SizedBox(
              height: height,
              width: width - 250,
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(12),
                children: [
                  CategoryCard(
                    title: "For Her",
                    imageUrl: "https://i.ibb.co/mCjY5Lp/for-her.jpg",
                  ),
                  CategoryCard(
                    title: "For Him",
                    imageUrl: "https://i.ibb.co/S5cQTSm/for-him.jpg",
                  ),
                  CategoryCard(
                    title: "Kids",
                    imageUrl: "https://i.ibb.co/FVn1J6L/kids.jpg",
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

class CategoryCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const CategoryCard({super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go('/products/$title'),
      child: Card(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(AppConste.imageUrl, fit: BoxFit.cover),
            Container(
              color: Colors.black26,
              alignment: Alignment.center,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
