
import 'package:flutter/material.dart';

class Firstpage extends StatelessWidget {
  const Firstpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ใช้พื้นหลังสีเทาอ่อนเพื่อให้เงาของ Card ชัดเจนขึ้น
      backgroundColor: const Color.fromARGB(255, 179, 89, 89),
      appBar: AppBar(
        title: const Text("Profile Nattareya"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ส่วนหัวสีฟ้าด้านหลังรูปโปรไฟล์
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 120,
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 75,
                        backgroundImage: AssetImage("assets/Taurineforcat-1024x681.jpg"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100), // เว้นระยะจากรูปภาพลงมา

            // ส่วนข้อมูลติดต่อใน Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation: 4, // เพิ่มเงาให้ Card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildInfoRow(Icons.person, "ชื่อ", "ณัฐรียา"),
                      const Divider(),
                      _buildInfoRow(Icons.school, "สาขา", "เทคโนโลยีเเละนวัตกรรมดิจิทัล"),
                      const Divider(),
                      _buildInfoRow(Icons.email, "อีเมล", "662021049@tsu.ac.th"),
                      const Divider(),
                      _buildInfoRow(Icons.phone_android, "เบอร์โทร", "0877309055"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget ช่วยสร้างแถวข้อมูลให้ดูเป็นระเบียบ
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent, size: 28),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

        
        
      
    
  

