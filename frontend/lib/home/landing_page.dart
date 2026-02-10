import 'package:flutter/material.dart';
import '../assessment/assessment_page.dart';
import '../navigation/animated_routes.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌌 Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0B0F14),
                  Color(0xFF101826),
                  Color(0xFF0B0F14),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // 🔝 Top navbar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            child: Row(
              children: [
                const Text(
                  "Pharma-Guard",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2DE2C5),
                  ),
                ),
                const Spacer(),
                const _NavItem("Home"),
                const _NavItem("Check"),
                const _NavItem("About"),
                const SizedBox(width: 20),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.camera_alt, size: 18),
                  label: const Text("Scan Medicine"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF2DE2C5),
                    side: const BorderSide(color: Color(0xFF2DE2C5)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🎯 Hero content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Safety pill
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2DE2C5).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "SAFETY FIRST",
                    style: TextStyle(
                      color: Color(0xFF2DE2C5),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 12,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  "Assess Risk Before",
                  style: TextStyle(
                    fontSize: 46,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  "Visiting a Pharmacy",
                  style: TextStyle(
                    fontSize: 46,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2DE2C5),
                  ),
                ),

                const SizedBox(height: 24),

                const SizedBox(
                  width: 520,
                  child: Text(
                    "Pharma-Guard helps you check symptoms and medicine interactions instantly. "
                    "A professional safety tool for peace of mind.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF9AA4AE),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // 🔘 CTA buttons
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          poppyRoute(const AssessmentPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2DE2C5),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Text(
                            "Start Safety Check",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 60),

                // Footer icons
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _FooterItem(Icons.monitor_heart, "Medical Grade"),
                    SizedBox(width: 40),
                    _FooterItem(Icons.lock, "Privacy First"),
                    SizedBox(width: 40),
                    _FooterItem(Icons.psychology, "AI Powered"),
                  ],
                ),
              ],
            ),
          ),

          // ⚠️ Bottom disclaimer (outside the card)
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 900),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Text(
                  "Disclaimer: This assessment is for informational purposes only and may not be fully accurate. "
                  "It is not a medical diagnosis. Always consult a qualified healthcare professional.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: Color(0xFF9AA4AE),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  const _NavItem(this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white70,
        ),
      ),
    );
  }
}

class _FooterItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FooterItem(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white38),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
