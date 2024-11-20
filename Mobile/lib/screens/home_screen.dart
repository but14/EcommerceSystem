import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For decoding JSON
import 'package:woshoesapp/screens/product_screen.dart';
import 'package:woshoesapp/model/product.dart'; // Ensure correct import

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categories = ["All", "Nike", "Adidas", "MLB", "Puma"];
  List<Product> products = []; // List of Product objects
  bool isLoading = true; // Track loading state
  String selectedCategory = "All"; // Track selected category

  // Fetch products from the API
  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/getAllProducts'));

      if (response.statusCode == 200) {
        setState(() {
          products = (json.decode(response.body) as List)
              .map((data) => Product.fromJson(data)) // Convert to Product objects
              .toList();
          isLoading = false; // Set loading to false once data is fetched
        });
      } else {
        setState(() {
          isLoading = false; // Stop loading if there's an error
        });
        throw Exception('Failed to load products');
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Stop loading if there's an error
      });
      print('Error fetching products: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProducts(); // Fetch products when the screen initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar and notifications
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    height: 50,
                    width: MediaQuery.of(context).size.width / 1.5,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xF7FF9233),
                        ),
                        border: InputBorder.none,
                        label: Text("Find your product"),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 6,
                    decoration: BoxDecoration(
                      color: Colors.black12.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.05),
                          blurRadius: 2,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.notifications,
                        color: Color(0xF7FF9233),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Featured image
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFFFF0DD),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 1,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Image.asset("images/freed.png"),
              ),
              SizedBox(height: 20),
              // Category list with active state
              SizedBox(
                height: 50,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = categories[index];
                        });
                      },
                      child: FittedBox(
                        child: Container(
                          height: 40,
                          margin: EdgeInsets.all(8),
                          padding: EdgeInsets.only(left: 15, right: 15),
                          decoration: BoxDecoration(
                            color: selectedCategory == categories[index]
                                ? Color(0xFFFFF0DD) // Highlight selected category
                                : Colors.black12.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: FittedBox(
                              child: Text(
                                categories[index],
                                style: TextStyle(
                                  color: selectedCategory == categories[index]
                                      ? Colors.black
                                      : Colors.black38,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              // Featured products section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Featured Products",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Display loading indicator if fetching data
              Expanded(
                child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : products.isEmpty
                        ? Center(child: Text("No products available"))
                        : GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.75,
                            ),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12.withOpacity(0.05),
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProductScreen(
                                              product: products[index], // Pass the Product object to the ProductScreen
                                            ),
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          products[index].productImg ?? 'https://example.com/default_image.jpg',
                                          fit: BoxFit.cover,
                                          height: 150,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      products[index].productName ?? 'Unnamed Product',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      '\$${products[index].price}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFDB3022),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
