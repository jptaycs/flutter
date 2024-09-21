import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              'https://via.placeholder.com/430x932', // Placeholder image
              fit: BoxFit.cover,
            ),
          ),
          // Main Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 62),
                // Profile Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Hello,',
                          style: TextStyle(
                            color: Color(0xD3EFEFEF),
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Jonathan',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 37,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(
                        'https://via.placeholder.com/64x59', // Placeholder image
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                // Flexible sections with Expanded
                Expanded(
                  child: Column(
                    children: [
                      _buildSection('Loads', Color(0x77FFC1C1)),
                      const SizedBox(height: 16),
                      _buildSection('Metrics', Color(0x77FFC1C1)),
                      const SizedBox(height: 16),
                      Expanded(child: _buildSection('Videos', Color(0x77FFC1C1))),
                      const SizedBox(height: 16),
                      Expanded(child: _buildSection('Improvements', Color(0x77FFC1C1))),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Flexible Start Button
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(117),
                      ),
                      backgroundColor: Colors.black,
                      minimumSize: const Size(366, 49),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'START',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Color color, {double height = 114}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black.withOpacity(0.83),
            fontSize: 23,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
