import 'package:flutter/material.dart' hide RadioListTile;
import 'package:flutter/material.dart' as material show RadioListTile;

class Food {
  final String engName;
  final String thaName;
  final double price;
  final String value;
  bool checked;

  Food({
    required this.engName,
    required this.thaName,
    required this.price,
    required this.value,
    this.checked = false,
  });
}

class Fristpage extends StatefulWidget {
  const Fristpage({super.key});

  @override
  State<Fristpage> createState() => _FristpageState();
}

class _FristpageState extends State<Fristpage> {
  String? groupFood;
  List<Food> selectedFoods = [];

  // Dropdown & Address
  final List<String> orderTypes = ["กินที่ร้าน", "กลับบ้าน"];
  String? selectedOrderType;
  final TextEditingController _addressController = TextEditingController();

  final List<Food> foods = [
    Food(engName: "Pizza", thaName: "พิซซ่า", price: 45, value: "pizza"),
    Food(engName: "Shabu", thaName: "ชาบู", price: 199, value: "shabu"),
    Food(engName: "Steak", thaName: "สเต็ก", price: 149, value: "steak"),
    Food(engName: "Salad", thaName: "สลัด", price: 40, value: "salad"),
    Food(engName: "Sandwich", thaName: "แซนวิช", price: 20, value: "sandwich"),
  ];

  /// ===== คำนวณราคารวม =====
  double calculateTotal() {
    double total = 0;

    if (groupFood != null) {
      total += foods.firstWhere((f) => f.value == groupFood).price;
    }

    for (var f in selectedFoods) {
      total += f.price;
    }

    return total;
  }

  /// ===== Radio =====
  List<Widget> createRadioFood() {
    return foods.map((food) {
      return RadioListTile(
        value: food.value,
        title: Text(
          food.engName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        subtitle: Text(food.thaName),
        secondary: Text(
          "${food.price} ฿",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    }).toList();
  }

  /// ===== Checkbox =====
  List<Widget> createCheckbox() {
    return foods.map((food) {
      return CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          food.engName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(food.thaName),
        secondary: Text(
          "${food.price} ฿",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        value: food.checked,
        onChanged: (bool? value) {
          setState(() {
            food.checked = value ?? false;
            if (food.checked) {
              selectedFoods.add(food);
            } else {
              selectedFoods.removeWhere((f) => f.value == food.value);
            }
          });
        },
      );
    }).toList();
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo Food"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// ===== Radio =====
            RadioGroup(
              groupValue: groupFood,
              onChanged: (value) => setState(() => groupFood = value),
              child: Column(children: createRadioFood()),
            ),

            const Divider(thickness: 2),

            /// ===== Checkbox =====
            ...createCheckbox(),

            const Divider(thickness: 2),

            /// ===== Dropdown =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  const Text(
                    "รูปแบบการสั่ง:",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 20),
                  DropdownButton<String>(
                    value: selectedOrderType,
                    hint: const Text("กรุณาเลือก"),
                    items: orderTypes.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedOrderType = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            /// ===== Address =====
            if (selectedOrderType == "กลับบ้าน")
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: "กรุณากรอกที่อยู่ส่งอาหาร",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.home),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),

            const Divider(thickness: 2),

            /// ===== Result =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.grey[100],
              child: Column(
                children: [
                  Text(
                    "รูปแบบ: ${selectedOrderType ?? 'ยังไม่ได้เลือก'}",
                    style: const TextStyle(
                        fontSize: 16, color: Colors.green),
                  ),
                  if (selectedOrderType == "กลับบ้าน")
                    Text(
                      "ที่อยู่: ${_addressController.text}",
                      style: const TextStyle(
                          fontSize: 14, color: Colors.orange),
                    ),
                  const SizedBox(height: 5),
                  Text(
                    "จานหลัก: ${groupFood ?? 'ยังไม่ได้เลือก'}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    "เพิ่มเติม: ${selectedFoods.isEmpty ? 'ไม่มี' : selectedFoods.map((f) => f.engName).join(', ')}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 14, color: Colors.blueAccent),
                  ),
                  const Divider(),
                  Text(
                    "ราคารวมทั้งหมด: ${calculateTotal().toStringAsFixed(2)} บาท",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
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

/// ===== Radio Backend =====
class RadioGroup extends InheritedWidget {
  final String? groupValue;
  final ValueChanged<String?>? onChanged;

  const RadioGroup({
    super.key,
    required this.groupValue,
    required this.onChanged,
    required super.child,
  });

  static RadioGroup? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<RadioGroup>();

  @override
  bool updateShouldNotify(RadioGroup oldWidget) =>
      groupValue != oldWidget.groupValue;
}

class RadioListTile extends StatelessWidget {
  final String value;
  final Widget title;
  final Widget? subtitle;
  final Widget? secondary;

  const RadioListTile({
    super.key,
    required this.value,
    required this.title,
    this.subtitle,
    this.secondary,
  });

  @override
  Widget build(BuildContext context) {
    final group = RadioGroup.of(context);
    return material.RadioListTile<String>(
      title: title,
      subtitle: subtitle,
      secondary: secondary,
      value: value,
      groupValue: group?.groupValue,
      onChanged: group?.onChanged,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
