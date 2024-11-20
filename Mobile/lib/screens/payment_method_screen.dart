import 'package:flutter/material.dart';
import 'package:woshoesapp/widget/container_button_model.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  int _type = 1;
  void _handleRadio(Object? e) => setState(() {
        _type = e as int;
      });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Method"),
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                width: size.width,
                height: 55,
                decoration: BoxDecoration(
                  border: _type == 1
                      ? Border.all(width: 1, color: Color(0xFFDB3022))
                      : Border.all(width: 0.5, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.transparent,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: _type,
                              onChanged: _handleRadio,
                              activeColor: Color(0xFFDB3022),
                            ),
                            Text("MoMo Pay",
                                style: _type == 1
                                    ? TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)
                                    : TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: size.width,
                height: 55,
                decoration: BoxDecoration(
                  border: _type == 2
                      ? Border.all(width: 1, color: Color(0xFFDB3022))
                      : Border.all(width: 0.5, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.transparent,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: 2,
                              groupValue: _type,
                              onChanged: _handleRadio,
                              activeColor: Color(0xFFDB3022),
                            ),
                            Text("PayPal",
                                style: _type == 2
                                    ? TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)
                                    : TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: size.width,
                height: 55,
                decoration: BoxDecoration(
                  border: _type == 3
                      ? Border.all(width: 1, color: Color(0xFFDB3022))
                      : Border.all(width: 0.5, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.transparent,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: 3,
                              groupValue: _type,
                              onChanged: _handleRadio,
                              activeColor: Color(0xFFDB3022),
                            ),
                            Text("COD",
                                style: _type == 3
                                    ? TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)
                                    : TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "\$350.00",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Shipping",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "\$5.00",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ), 
              Divider(
                height: 30, color: Colors.black,
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "\$400.00",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFDB3022),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 70,), 
              InkWell(
                onTap: () {},
                child: ContainerButtonModel(itext: "Confirm Payment", 
                containerWidth: size.width,
                bgColor: Color(0xFFDB3022),))
            ],
          ),
        ),
      ),
    );
  }
}
