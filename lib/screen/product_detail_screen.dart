import 'package:flutter/material.dart';
import 'package:e_commerce_code_pixel/res/algeria_cites.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? _selectedColor;
  String? _selectedSize;
  int _quantity = 1;
  String? selectedWilaya;
  String? selectedCommune;
  String name = "";
  String phone = "";
  final List<Map<String, dynamic>> _colors = [
    {'name': 'Black', 'value': Colors.black},
    {'name': 'White', 'value': Colors.white},
    {'name': 'Gray', 'value': Colors.grey},
    {'name': 'Navy Blue', 'value': const Color(0xFF000080)},
  ];

  final List<String> _sizes = ['XS', 'S', 'M', 'L', 'XL'];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final wilayas =
        algeria_cites
            .map((e) => e["wilaya_name_ascii"] as String)
            .toSet()
            .toList();

    // استخراج البلديات التابعة للولاية المختارة
    final communes =
        algeria_cites
            .where((e) => e["wilaya_name_ascii"] == selectedWilaya)
            .map((e) => e["commune_name_ascii"] as String)
            .toList();
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, size: 24),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, size: 24),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Product Image and Basic Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // image & form
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                "lib/res/images/1.jpg",
                                height: 280,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  const Text(
                                    'Cozy Knit Sweater',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    '\$49.99',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2A4BA0),
                                    ),
                                  ),
                                ],
                              ),
                              // Additional Images Gallery
                              const SizedBox(height: 16),
                              SizedBox(
                                height: 120,
                                width: 300,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  separatorBuilder:
                                      (context, index) =>
                                          const SizedBox(width: 12),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: 100,
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
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            'https://images.unsplash.com/photo-1576566588028-4147f3842f27?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=300&q=80',
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          SizedBox(
                            width: 500,
                            height: 400,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Select Color',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  height: 50,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _colors.length,
                                    separatorBuilder:
                                        (context, index) =>
                                            const SizedBox(width: 12),
                                    itemBuilder: (context, index) {
                                      final color = _colors[index];
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedColor = color['name'];
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                _selectedColor == color['name']
                                                    ? const Color(
                                                      0xFF2A4BA0,
                                                    ).withOpacity(0.1)
                                                    : Colors.transparent,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            border: Border.all(
                                              color:
                                                  _selectedColor ==
                                                          color['name']
                                                      ? const Color(0xFF2A4BA0)
                                                      : Colors.grey[300]!,
                                              width:
                                                  _selectedColor ==
                                                          color['name']
                                                      ? 1.5
                                                      : 1,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  color: color['value'],
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Colors.grey[300]!,
                                                    width: 1,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                color['name'],
                                                style: TextStyle(
                                                  fontWeight:
                                                      _selectedColor ==
                                                              color['name']
                                                          ? FontWeight.w600
                                                          : FontWeight.normal,
                                                  color:
                                                      _selectedColor ==
                                                              color['name']
                                                          ? const Color(
                                                            0xFF2A4BA0,
                                                          )
                                                          : Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                const SizedBox(height: 24),

                                // Size Selection
                                const Text(
                                  'Select Size',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  height: 50,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _sizes.length,
                                    separatorBuilder:
                                        (context, index) =>
                                            const SizedBox(width: 12),
                                    itemBuilder: (context, index) {
                                      final size = _sizes[index];
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedSize = size;
                                          });
                                        },
                                        child: Container(
                                          width: 60,
                                          decoration: BoxDecoration(
                                            color:
                                                _selectedSize == size
                                                    ? const Color(0xFF2A4BA0)
                                                    : Colors.transparent,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            border: Border.all(
                                              color:
                                                  _selectedSize == size
                                                      ? const Color(0xFF2A4BA0)
                                                      : Colors.grey[300]!,
                                              width: 1.5,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              size,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    _selectedSize == size
                                                        ? Colors.white
                                                        : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                const SizedBox(height: 24),

                                // Quantity Selector
                                const Text(
                                  'Quantity',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  width: 140,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (_quantity > 1) {
                                            setState(() {
                                              _quantity--;
                                            });
                                          }
                                        },
                                        child: Container(
                                          width: 32,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(
                                                  0.2,
                                                ),
                                                blurRadius: 4,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: const Icon(
                                            Icons.remove,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        _quantity.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _quantity++;
                                          });
                                        },
                                        child: Container(
                                          width: 32,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(
                                                  0.2,
                                                ),
                                                blurRadius: 4,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Color Selection

                          // Delivery Information Card
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'Delivery Information',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2A4BA0),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // Full Name
                                SizedBox(
                                  width: 200,
                                  child: TextFormField(
                                    onSaved: (value) => name = value!,
                                    decoration: InputDecoration(
                                      labelText: "Name",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    validator:
                                        (value) =>
                                            value == null || value.isEmpty
                                                ? "Enter your name"
                                                : null,
                                  ),
                                ),

                                const SizedBox(height: 16),

                                // State
                                SizedBox(
                                  width: 200,
                                  height: 50,
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    hint: const Text("wilaya"),
                                    value: selectedWilaya,
                                    items:
                                        wilayas.map((wilaya) {
                                          return DropdownMenuItem(
                                            value: wilaya,
                                            child: Text(wilaya),
                                          );
                                        }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedWilaya = value;
                                        selectedCommune = null; // reset commune
                                      });
                                    },
                                  ),
                                ),

                                // Dropdown البلديات
                                (selectedWilaya != null)
                                    ? Column(
                                      children: [
                                        const SizedBox(height: 20),
                                        SizedBox(
                                          width: 200,
                                          height: 50,
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            hint: const Text("Daira"),
                                            value: selectedCommune,
                                            items:
                                                communes.map((commune) {
                                                  return DropdownMenuItem(
                                                    value: commune,
                                                    child: Text(commune),
                                                  );
                                                }).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                selectedCommune = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                    : SizedBox(),

                                // Municipality
                                const SizedBox(height: 16),

                                // Phone Number
                                SizedBox(
                                  width: 200,
                                  child: TextFormField(
                                    onSaved: (value) => phone = value!,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      labelText: "Phone",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "من فضلك أدخل رقم الهاتف";
                                      }

                                      // الشرط 1: لازم 10 أرقام
                                      if (value.length != 10) {
                                        return "رقم الهاتف يجب أن يكون 10 أرقام";
                                      }

                                      // الشرط 2: لازم يبدأ بـ 05 أو 06 أو 07
                                      if (!(value.startsWith("05") ||
                                          value.startsWith("06") ||
                                          value.startsWith("07"))) {
                                        return "رقم الهاتف يجب أن يبدأ بـ 05 أو 06 أو 07";
                                      }

                                      // الشرط 3: التأكد أنه كله أرقام
                                      if (!RegExp(
                                        r'^[0-9]+$',
                                      ).hasMatch(value)) {
                                        return "رقم الهاتف يجب أن يحتوي على أرقام فقط";
                                      }

                                      return null; // صحيح ✅
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Delivery Price
                                const Text(
                                  'Delivery Price 60\$ ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2A4BA0),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Total Price
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        blurRadius: 10,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Total Price:',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        '\$64.99',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Add to Cart Button
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {}
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    backgroundColor: const Color(0xFF2A4BA0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    margin: EdgeInsets.all(5),
                                    child: const Text(
                                      'Add to Cart',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //End image & form
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const InfoCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
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
          Icon(icon, size: 20, color: const Color(0xFF2A4BA0)),
          const SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
