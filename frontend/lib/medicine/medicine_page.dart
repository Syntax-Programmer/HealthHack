import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ScanMedicinePage extends StatelessWidget {
  const ScanMedicinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌌 Background gradient
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

          // ⬅ Back button ONLY (top-left)
          Positioned(
            top: 32,
            left: 24,
            child: TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xFF2DE2C5),
                size: 20,
              ),
              label: const Text(
                "Back",
                style: TextStyle(
                  color: Color(0xFF2DE2C5),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF2DE2C5),
              ),
            ),
          ),

          // 🎯 Main content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Page title (CENTERED, not in corner)
                const Text(
                  "Scan Medicine",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  "Analyze medicine safety, usage, and warnings",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF9AA4AE),
                  ),
                ),

                const SizedBox(height: 40),

                // Scan button
                ElevatedButton.icon(
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles(
                        type: FileType.image, // ✅ images only
                        allowMultiple: false,
                        withData: true, // ✅ required for web (bytes)
                      );

                      if (result == null) {
                        // User cancelled picker
                        return;
                      }

                      final PlatformFile file = result.files.first;

                      // Safety check
                      if (file.bytes == null) {
                        debugPrint("Failed to read image bytes");
                        return;
                      }
                      // 🔜 NEXT STEP (later):
                      // Send imageBytes to backend OCR / med_analyze endpoint
                    },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Select Picture"),
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
                ),
              ],
            ),
          ),

          // ⚠️ Footer disclaimer
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 900),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Text(
                  "Disclaimer: Medicine analysis is informational only and may not be fully accurate. "
                  "Always verify with a licensed pharmacist or doctor.",
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
