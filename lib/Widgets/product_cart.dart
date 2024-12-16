import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProductCart extends StatelessWidget {
  final String name;
  final String imageUrl;
  final double price;
  final String offer;
  final Function onTap;

  const ProductCart(
      {super.key,
      required this.name,
      required this.imageUrl,
      required this.price,
      required this.offer,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.maxFinite,
                height: 120,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                name,
                style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 15),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Rs : $price',
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 20,
                width: 60,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: Colors.green[400],
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    offer,
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
