import 'package:flutter/material.dart';
import 'package:health_app_main/main.dart';
import 'package:provider/provider.dart';

class AndriodPrototype extends StatelessWidget {
  const AndriodPrototype({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userName = Provider.of<UsernameProvider>(context).username;

    return Scaffold(
      appBar: AppBar(
        title: Text('ỨNG DỤNG CHĂM SÓC SỨC KHỎE'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/homepage1.jpeg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chào $userName ',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildAdviceContainer(
                    context,
                    'Ngủ sớm',
                    'Ngủ ít nhất 7-9 tiếng để có sức khỏe tốt hơn.',
                    Icons.nights_stay,
                  ),
                  SizedBox(width: 20), // Vertical space between the two squares
                  buildAdviceContainer(
                    context,
                    'Đi bộ hàng ngày',
                    'Đi bộ ít nhất 30 phút mỗi ngày.',
                    Icons.directions_walk,
                  ),
                ],
              ),
              SizedBox(height: 20),
              buildOptionButton(
                context,
                'Thuốc',
                Icons.medication,
                '/medication',
              ),
              SizedBox(height: 20),
              buildOptionButton(
                context,
                'Lối sống lành mạnh',
                Icons.fitness_center,
                '/FitnessPage',
              ),
              SizedBox(height: 20),
              buildOptionButton(
                context,
                'Đặt lịch khám',
                Icons.calendar_today,
                '/appointment',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOptionButton(
    BuildContext context,
    String label,
    IconData icon,
    String route,
  ) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      label: Text(
        label,
        style: TextStyle(color: Colors.white), // Set text color to white
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF5e4e8f),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(vertical: 20),
        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildAdviceContainer(
    BuildContext context,
    String title,
    String description,
    IconData icon,
  ) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.blue,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
