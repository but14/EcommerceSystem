import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:woshoesapp/screens/payment_method_screen.dart';
import 'package:woshoesapp/widget/container_button_model.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  List<dynamic> cartItems = []; // Cart items data from API
  bool isLoading = true; // Loading state for fetching data
  bool selectAll = false; // State for "Select All" checkbox
  double totalAmount = 0.0;

  // Fetch the cart data from API
  Future<void> fetchCartData() async {
    try {
      String? token = await storage.read(key: 'token');

      if (token == null) {
        // Handle case where user is not logged in
        print("User is not logged in.");
        return;
      }

      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/api/user/cartM'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          cartItems = data['data']; // Assuming the cart items are in 'data'
          totalAmount = _calculateTotalAmount();
          isLoading = false;
        });
      } else {
        print('Failed to load cart data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Calculate the total amount for selected items
  double _calculateTotalAmount() {
    double total = 0.0;
    for (var item in cartItems) {
      if (item['selected'] == true) {
        final product = item['product'];
        final price = double.tryParse(product['product_variants'][0]['price'].toString()) ?? 0.0;
        final quantity = item['quantity'];
        total += price * quantity;
      }
    }
    return total;
  }

  // Handle toggle of "Select All" checkbox
  void toggleSelectAll(bool? value) {
    setState(() {
      selectAll = value ?? false;
      for (var item in cartItems) {
        item['selected'] = selectAll;
      }
      totalAmount = _calculateTotalAmount();
    });
  }

  // Toggle selection for a single item
  void toggleItemSelection(int index) {
    setState(() {
      cartItems[index]['selected'] = !cartItems[index]['selected'];
      totalAmount = _calculateTotalAmount();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCartData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    // Display cart items dynamically
                    Container(
                      child: ListView.builder(
                        itemCount: cartItems.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final cartItem = cartItems[index];
                          final product = cartItem['product'];

                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Checkbox(
                                  splashRadius: 20,
                                  activeColor: Color(0xFFDB3022),
                                  value: cartItem['selected'] ?? false,
                                  onChanged: (val) {
                                    toggleItemSelection(index);
                                  },
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product['product_name'], // Product name
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "\$${product['product_variants'][0]['price']}", // Price
                                      style: TextStyle(
                                        color: Color(0xFFDB3022),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.minus,
                                      color: Colors.green,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      cartItem['quantity'].toString(), // Quantity
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(
                                      CupertinoIcons.plus,
                                      color: Color(0xFFDB3022),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Select All",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Checkbox(
                          splashRadius: 20,
                          activeColor: Color(0xFFDB3022),
                          value: selectAll,
                          onChanged: toggleSelectAll,
                        ),
                      ],
                    ),
                    Divider(
                      height: 20,
                      thickness: 1,
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Payment",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "\$${totalAmount.toStringAsFixed(2)}", // Total amount
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFFDB3022),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PaymentMethodScreen()),
                        );
                      },
                      child: ContainerButtonModel(
                        itext: "Checkout",
                        containerWidth: MediaQuery.of(context).size.width,
                        bgColor: Color(0xFFDB3022),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }
}
