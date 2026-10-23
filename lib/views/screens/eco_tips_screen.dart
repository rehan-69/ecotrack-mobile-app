import 'package:flutter/material.dart';

class EcoTipsScreen extends StatelessWidget {
  const EcoTipsScreen({super.key});

  static const Color primaryGreen = Color(0xFF33A444);
  static const Color lightGreen = Color(0xFFF0F8F0);
  static const Color darkText = Color(0xFF202938);
  static const Color secondaryText = Color(0xFF858B94);

  static const List<Map<String, dynamic>> tips = [
    {
      'category': 'WASTE SEGREGATION',
      'title': 'Separate Wet & Dry Waste',
      'description':
          'Keep food scraps separate from paper, plastic, glass and other dry waste.',
      'icon': Icons.delete_sweep_outlined,
      'color': Color(0xFF33A444),
      'background': Color(0xFFEAF7EC),
    },
    {
      'category': 'E-WASTE',
      'title': 'Dispose E-Waste Safely',
      'description':
          'Take old batteries, chargers and electronic devices to an authorised collection point.',
      'icon': Icons.devices_outlined,
      'color': Color(0xFF5576C9),
      'background': Color(0xFFEDF1FF),
    },
    {
      'category': 'RECYCLING',
      'title': 'Reuse Before You Throw',
      'description':
          'Reuse bags, bottles and containers whenever practical to reduce unnecessary waste.',
      'icon': Icons.recycling_outlined,
      'color': Color(0xFF259B91),
      'background': Color(0xFFE6F7F4),
    },
    {
      'category': 'ORGANIC WASTE',
      'title': 'Compost Kitchen Scraps',
      'description':
          'Suitable fruit and vegetable scraps can be composted instead of mixed with dry waste.',
      'icon': Icons.compost_outlined,
      'color': Color(0xFF9A762E),
      'background': Color(0xFFFFF5DE),
    },
    {
      'category': 'CLEAN STREETS',
      'title': 'Use a Proper Dustbin',
      'description':
          'Never throw wrappers or plastic on roads. Use a bin or keep the waste until you find one.',
      'icon': Icons.delete_outline_rounded,
      'color': Color(0xFF885AC7),
      'background': Color(0xFFF3ECFF),
    },
    {
      'category': 'ENVIRONMENT',
      'title': 'Reduce Single-Use Plastic',
      'description':
          'Carry a reusable shopping bag and refillable water bottle to reduce disposable plastic.',
      'icon': Icons.eco_outlined,
      'color': Color(0xFF33A444),
      'background': Color(0xFFEAF7EC),
    },
    {
      'category': 'COMMUNITY',
      'title': 'Report Waste Hotspots',
      'description':
          'If you notice waste dumped in public spaces, use EcoTrack to report it to your municipality.',
      'icon': Icons.location_on_outlined,
      'color': Color(0xFFE58A24),
      'background': Color(0xFFFFF2E2),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0F8F0),
        foregroundColor: darkText,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Eco Tips',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: darkText,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          children: [
            // Header banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: lightGreen,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Small Steps,',
                          style: TextStyle(
                            color: darkText,
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 3),
                        const Text(
                          'Cleaner City!',
                          style: TextStyle(
                            color: primaryGreen,
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Simple habits for a cleaner tomorrow.',
                          style: TextStyle(
                            color: darkText.withValues(alpha: 0.7),
                            fontSize: 13,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    height: 76,
                    width: 76,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.eco_rounded,
                      color: primaryGreen,
                      size: 42,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 26),

            const Text(
              'Everyday Eco Tips',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: darkText,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Easy actions that make a difference.',
              style: TextStyle(fontSize: 14, color: secondaryText),
            ),

            const SizedBox(height: 18),

            // Static tip cards
            ...tips.asMap().entries.map((entry) {
              final index = entry.key;
              final tip = entry.value;

              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFEBEEEB)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x08000000),
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 52,
                        width: 52,
                        decoration: BoxDecoration(
                          color: tip['background'] as Color,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          tip['icon'] as IconData,
                          color: tip['color'] as Color,
                          size: 27,
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TIP ${index + 1}  •  ${tip['category']}',
                              style: const TextStyle(
                                color: primaryGreen,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),

                            const SizedBox(height: 7),

                            Text(
                              tip['title'] as String,
                              style: const TextStyle(
                                color: darkText,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              tip['description'] as String,
                              style: const TextStyle(
                                color: secondaryText,
                                fontSize: 13,
                                height: 1.55,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: lightGreen,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.favorite_outline_rounded,
                    color: primaryGreen,
                    size: 24,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'A cleaner city starts with us. '
                      'Every small action counts!',
                      style: TextStyle(
                        color: darkText,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
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
