import 'package:flutter/material.dart';
import '../assessment/assessment_page.dart';
import '../navigation/animated_routes.dart';
import '../medicine/medicine_page.dart'; // ✅ FIXED IMPORT

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _aboutKey = GlobalKey();
  bool _isAboutVisible = false;
  double _scrollProgress = 0.0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (!_scrollController.hasClients) return;

      final maxScroll = _scrollController.position.maxScrollExtent;

      if (maxScroll > 0) {
        setState(() {
          _scrollProgress =
              (_scrollController.offset / maxScroll).clamp(0.0, 1.0);
        });
      }

      final aboutContext = _aboutKey.currentContext;
      if (aboutContext != null) {
        final box = aboutContext.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero).dy;

        setState(() {
          _isAboutVisible = position <= 120; // navbar height threshold
        });
      }
    });
  }

  void _scrollToAbout() {
    final context = _aboutKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // 🌌 Background + Scroll Content
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.lerp(
                    const Color(0xFF0B0F14),
                    const Color(0xFF08121C),
                    _scrollProgress,
                  )!,
                  Color.lerp(
                    const Color(0xFF101826),
                    const Color(0xFF0F1F2D),
                    _scrollProgress,
                  )!,
                  Color.lerp(
                    const Color(0xFF0B0F14),
                    const Color(0xFF08121C),
                    _scrollProgress,
                  )!,
                ],
                begin: Alignment(0, -1 + (_scrollProgress * 0.6)),
                end: Alignment(0, 1 + (_scrollProgress * 0.6)),
              ),
            ),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [

                    // Space for fixed navbar
                    const SizedBox(height: 110),
                    // HERO SECTION (VERTICALLY CENTERED)
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 150,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 6),
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

                            const SizedBox(height: 40),

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _PrimaryCTA(
                                  label: "Start Safety Check",
                                  icon: Icons.arrow_forward,
                                  onTap: () {
                                    Navigator.of(context).push(
                                      poppyRoute(const AssessmentPage()),
                                    );
                                  },
                                ),
                                const SizedBox(width: 16),
                                _PrimaryCTA(
                                  label: "Scan Medicine",
                                  icon: Icons.camera_alt,
                                  onTap: () {
                                    Navigator.of(context).push(
                                      poppyRoute(const ScanMedicinePage()),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ABOUT SECTION
                    Container(
                      key: _aboutKey,
                      padding: const EdgeInsets.symmetric(
                          vertical: 140, horizontal: 40),
                      child: Column(
                        children: [

                          const Text(
                            "About Pharma-Guard",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2DE2C5),
                            ),
                          ),

                          const SizedBox(height: 30),

                          const SizedBox(
                            width: 900,
                            child: Text(
                              "Pharma-Guard was built with a single objective: reduce risk in everyday health decisions. "
                              "Many people rely on self-medication or delay professional consultation due to uncertainty. "
                              "Our platform provides structured AI-driven guidance to help users better understand "
                              "their symptom patterns and medication safety before taking action.\n\n"
                              "By combining symptom modeling with medicine analysis, Pharma-Guard acts as a "
                              "decision-support layer — not as a replacement for doctors — but as a safety companion "
                              "that encourages responsible and informed health choices.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                height: 1.8,
                                color: Color(0xFFB3C0CC),
                              ),
                            ),
                          ),

                          const SizedBox(height: 70),

                          Wrap(
                            spacing: 80,
                            runSpacing: 60,
                            alignment: WrapAlignment.center,
                            children: [
                              _AboutFeature(
                                icon: Icons.monitor_heart,
                                title: "Symptom Intelligence",
                                description:
                                    "Machine learning models analyze symptom combinations to estimate severity.",
                              ),
                              _AboutFeature(
                                icon: Icons.medication,
                                title: "Medicine Analysis",
                                description:
                                    "Scan medicines to understand salts, uses, and warnings.",
                              ),
                              _AboutFeature(
                                icon: Icons.security,
                                title: "Conservative Risk Model",
                                description:
                                    "Safety-first philosophy encouraging consultation when uncertain.",
                              ),
                            ],
                          ),

                          const SizedBox(height: 100),
                        ],
                      ),
                    ),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),

          // 🔝 FIXED NAVBAR
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              color: Colors.black.withOpacity(0.25),
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
                  _NavItem(
                    label: "Home",
                    active: !_isAboutVisible,
                    onTap: () {
                      _scrollController.animateTo(
                        0,
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                  _NavItem(
                    label: "Check",
                    onTap: () {
                      Navigator.of(context).push(
                        poppyRoute(const AssessmentPage()),
                      );
                    },
                  ),
                  _NavItem(
                    label: "About",
                    active: _isAboutVisible,
                    onTap: _scrollToAbout,
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
/* NAV ITEM */

class _NavItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool active;

  const _NavItem({
    required this.label,
    required this.onTap,
    this.active = false,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.active || _hovering
        ? const Color(0xFF2DE2C5)
        : Colors.white70;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: widget.active
                  ? FontWeight.bold
                  : FontWeight.normal,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}

/* CTA BUTTON */

class _PrimaryCTA extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _PrimaryCTA({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2DE2C5),
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(
            horizontal: 32, vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward),
        ],
      ),
    );
  }
}

/* ABOUT FEATURE */

class _AboutFeature extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _AboutFeature({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Column(
        children: [
          Icon(icon, size: 48, color: const Color(0xFF2DE2C5)),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Color(0xFF9AA4AE),
            ),
          ),
        ],
      ),
    );
  }
}
