class Food {
  String engName;
  String thaName;
  bool checked;
  double price;

  Food({
    required this.engName,
    required this.thaName,
    required this.checked,
    required this.price,
  });

  static List<Food> getFood() {
    return <Food>[
      Food(
        engName: 'Pizza',
        thaName: 'พิซซ่า',
        checked: false,
        price: 45.0,
      ),
      Food(
        engName: 'Shabu',
        thaName: 'ชาบู',
        checked: false,
        price: 19.0,
      ),
      Food(
        engName: 'Steak',
        thaName: 'สเต็ก',
        checked: false,
        price: 149.0,
      ),
      Food(
        engName: 'Salad',
        thaName: 'สลัด',
        checked: false,
        price: 30.0,
      ),
      Food(
        engName: 'Sandwich',
        thaName: 'แซนวิช',
       checked: false,
        price: 20.0,
      ),
    ];
  }
}