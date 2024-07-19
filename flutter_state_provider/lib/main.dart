import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int total = 0;

  // Prices of the items
  final Map<String, int> itemPrices = {
    "iPad": 19000,
    "iPad Mini": 23000,
    "iPad Air": 29000,
    "iPad Pro": 39000,
  };

  // Keys for each ShoppingItem widget
  final List<GlobalKey<_ShoppingItemState>> itemKeys = [
    GlobalKey<_ShoppingItemState>(),
    GlobalKey<_ShoppingItemState>(),
    GlobalKey<_ShoppingItemState>(),
    GlobalKey<_ShoppingItemState>(),
  ];

  final NumberFormat formatter = NumberFormat('#,###');

  void _updateTotal(int priceChange) {
    setState(() {
      total += priceChange;
    });
  }

  void _resetTotal() {
    setState(() {
      total = 0;
    });
    for (var key in itemKeys) {
      key.currentState?.resetCount();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Shopping Cart"),
          backgroundColor: Color.fromARGB(255, 252, 182, 84),
        ),
        body: Column(children: [
          Expanded(
            child: Column(children: [
              ShoppingItem(
                key: itemKeys[0],
                title: "iPad",
                price: itemPrices["iPad"]!,
                onItemCountChanged: _updateTotal,
              ),
              ShoppingItem(
                key: itemKeys[1],
                title: "iPad Mini",
                price: itemPrices["iPad Mini"]!,
                onItemCountChanged: _updateTotal,
              ),
              ShoppingItem(
                key: itemKeys[2],
                title: "iPad Air",
                price: itemPrices["iPad Air"]!,
                onItemCountChanged: _updateTotal,
              ),
              ShoppingItem(
                key: itemKeys[3],
                title: "iPad Pro",
                price: itemPrices["iPad Pro"]!,
                onItemCountChanged: _updateTotal,
              ),
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Total",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                formatter.format(total),
                style: const TextStyle(fontSize: 30),
              ),
              const Text(
                "Bath",
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: _resetTotal,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Rounded corners
              ),
            ),
            child: const Text(
              "Clear",
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ]),
      ),
    );
  }
}

class ShoppingItem extends StatefulWidget {
  final String title;
  final int price;
  final ValueChanged<int> onItemCountChanged;

  ShoppingItem({
    required Key key,
    required this.title,
    required this.price,
    required this.onItemCountChanged,
  }) : super(key: key);

  @override
  State<ShoppingItem> createState() => _ShoppingItemState();
}

class _ShoppingItemState extends State<ShoppingItem> {
  int count = 0;
  final NumberFormat formatter = NumberFormat('#,###');

  void _incrementCount() {
    setState(() {
      count++;
      widget.onItemCountChanged(widget.price);
    });
  }

  void _decrementCount() {
    if (count > 0) {
      setState(() {
        count--;
        widget.onItemCountChanged(-widget.price);
      });
    }
  }

  void resetCount() {
    setState(() {
      count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(fontSize: 28),
              ),
              Text("${formatter.format(widget.price)}฿"),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
                onPressed: _decrementCount, icon: const Icon(Icons.remove)),
            const SizedBox(
              width: 10,
            ),
            Text(
              count.toString(),
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(onPressed: _incrementCount, icon: const Icon(Icons.add)),
          ],
        ),
      ],
    );
  }
}
