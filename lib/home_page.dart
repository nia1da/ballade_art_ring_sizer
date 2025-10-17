import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dpi_helper.dart';

// 🔹 Yüzük ölçü tablosu
final List<Map<String, dynamic>> sizeChart = [
  {"us": 1, "diameter": 13.0, "circumference": 40.84},
  {"us": 1.5, "diameter": 13.16, "circumference": 41.35},
  {"us": 2, "diameter": 13.32, "circumference": 41.85},
  {"us": 2.5, "diameter": 13.48, "circumference": 42.36},
  {"us": 3, "diameter": 13.65, "circumference": 42.87},
  {"us": 3.5, "diameter": 13.81, "circumference": 43.38},
  {"us": 4, "diameter": 13.97, "circumference": 43.88},
  {"us": 4.5, "diameter": 14.13, "circumference": 44.39},
  {"us": 5, "diameter": 14.29, "circumference": 44.90},
  {"us": 5.5, "diameter": 14.45, "circumference": 45.40},
  {"us": 6, "diameter": 14.61, "circumference": 45.91},
  {"us": 6.5, "diameter": 14.78, "circumference": 46.42},
  {"us": 7, "diameter": 14.94, "circumference": 46.93},
  {"us": 7.5, "diameter": 15.10, "circumference": 47.43},
  {"us": 8, "diameter": 15.26, "circumference": 47.94},
  {"us": 8.5, "diameter": 15.42, "circumference": 48.45},
  {"us": 9, "diameter": 15.58, "circumference": 48.95},
  {"us": 9.5, "diameter": 15.74, "circumference": 49.46},
  {"us": 10, "diameter": 15.91, "circumference": 49.97},
  {"us": 10.5, "diameter": 16.07, "circumference": 50.48},
  {"us": 11, "diameter": 16.23, "circumference": 50.98},
  {"us": 11.5, "diameter": 16.39, "circumference": 51.49},
  {"us": 12, "diameter": 16.55, "circumference": 52.00},
  {"us": 12.5, "diameter": 16.71, "circumference": 52.50},
  {"us": 13, "diameter": 16.87, "circumference": 53.01},
  {"us": 13.5, "diameter": 17.04, "circumference": 53.52},
  {"us": 14, "diameter": 17.20, "circumference": 54.03},
  {"us": 14.5, "diameter": 17.36, "circumference": 54.53},
  {"us": 15, "diameter": 17.52, "circumference": 55.04},
  {"us": 15.5, "diameter": 17.68, "circumference": 55.55},
  {"us": 16, "diameter": 17.84, "circumference": 56.05},
  {"us": 16.5, "diameter": 18.00, "circumference": 56.56},
  {"us": 17, "diameter": 18.17, "circumference": 57.07},
  {"us": 17.5, "diameter": 18.33, "circumference": 57.58},
  {"us": 18, "diameter": 18.49, "circumference": 58.08},
  {"us": 18.5, "diameter": 18.65, "circumference": 58.59},
  {"us": 19, "diameter": 18.81, "circumference": 59.10},
  {"us": 19.5, "diameter": 18.97, "circumference": 59.60},
  {"us": 20, "diameter": 19.13, "circumference": 60.11},
  {"us": 20.5, "diameter": 19.30, "circumference": 60.62},
  {"us": 21, "diameter": 19.46, "circumference": 61.13},
  {"us": 21.5, "diameter": 19.62, "circumference": 61.63},
  {"us": 22, "diameter": 19.78, "circumference": 62.14},
  {"us": 22.5, "diameter": 19.94, "circumference": 62.65},
  {"us": 23, "diameter": 20.10, "circumference": 63.15},
  {"us": 23.5, "diameter": 20.26, "circumference": 63.66},
  {"us": 24, "diameter": 20.43, "circumference": 64.17},
  {"us": 24.5, "diameter": 20.59, "circumference": 64.68},
  {"us": 25, "diameter": 20.75, "circumference": 65.18},
  {"us": 25.5, "diameter": 20.91, "circumference": 65.69},
  {"us": 26, "diameter": 21.07, "circumference": 66.20},
  {"us": 26.5, "diameter": 21.23, "circumference": 66.70},
  {"us": 27, "diameter": 21.39, "circumference": 67.21},
  {"us": 27.5, "diameter": 21.56, "circumference": 67.72},
  {"us": 28, "diameter": 21.72, "circumference": 68.23},
  {"us": 28.5, "diameter": 21.88, "circumference": 68.73},
  {"us": 29, "diameter": 22.04, "circumference": 69.24},
  {"us": 29.5, "diameter": 22.20, "circumference": 69.75},
  {"us": 30, "diameter": 22.36, "circumference": 70.25},
  {"us": 30.5, "diameter": 22.52, "circumference": 70.76},
  {"us": 31, "diameter": 22.69, "circumference": 71.27},
  {"us": 31.5, "diameter": 22.85, "circumference": 71.78},
  {"us": 32, "diameter": 23.01, "circumference": 72.28},
  {"us": 32.5, "diameter": 23.17, "circumference": 72.79},
  {"us": 33, "diameter": 23.33, "circumference": 73.30},
  {"us": 33.5, "diameter": 23.49, "circumference": 73.80},
  {"us": 34, "diameter": 23.65, "circumference": 74.31},
  {"us": 34.5, "diameter": 23.82, "circumference": 74.82},
  {"us": 35, "diameter": 23.98, "circumference": 75.33},
  {"us": 35.5, "diameter": 24.14, "circumference": 75.83},
  {"us": 36, "diameter": 24.30, "circumference": 76.34},
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double diameterMm = 13.0;
  final double minDiameter = 13.0;
  final double maxDiameter = 24.3;

  Map<String, double> dpi = {"xdpi": 0.0, "ydpi": 0.0};

  @override
  void initState() {
    super.initState();
    DpiHelper.getDpi().then((value) {
      setState(() {
        dpi = value;
      });
    });
  }

  void _stepBackward() {
    setState(() {
      diameterMm = (diameterMm - 0.16).clamp(minDiameter, maxDiameter);
    });
  }

  void _stepForward() {
    setState(() {
      diameterMm = (diameterMm + 0.16).clamp(minDiameter, maxDiameter);
    });
  }

  Future<void> _shareOnWhatsApp(String message) async {
    final url = Uri.parse("https://wa.me/?text=${Uri.encodeComponent(message)}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (dpi["xdpi"] == 0.0) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    double xdpi = dpi["xdpi"]!;
    double dpr = MediaQuery.of(context).devicePixelRatio;

    // kutu ve halka ölçüleri dp
    double maxDiameterDp =
        DpiHelper.mmToDp(mm: maxDiameter, dpi: xdpi, dpr: dpr) + 40;
    double currentDiameterDp =
    DpiHelper.mmToDp(mm: diameterMm, dpi: xdpi, dpr: dpr);

    // en yakın index
    final closestIndex = sizeChart.indexed.reduce((a, b) =>
    (a.$2['diameter'] - diameterMm).abs() <
        (b.$2['diameter'] - diameterMm).abs()
        ? a
        : b).$1;

    return Scaffold(
      backgroundColor: const Color(0xFF222831),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Column(
          children: [
            const SizedBox(height: 16),
            Text(
              "BALLADEART",
              style: GoogleFonts.cinzel(
                fontSize: 28,
                letterSpacing: 4,
                color: const Color(0xFFDFD0B8),
              ),
            ),
            const SizedBox(height: 24),

            // kutu + halka + ikonlar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Nasıl Kullanılır"),
                        content: const Text(
                          "Yüzüğünüzü ekrandaki halkanın üzerine yerleştirin.\n"
                              "Slider veya listeden çapı ayarlayın.\n"
                              "Ölçünüzü kontrol edin.",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Tamam"),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/help.svg",
                    width: 45,
                    height: 45,
                    colorFilter:
                    const ColorFilter.mode(Color(0xFFDFD0B8), BlendMode.srcIn),
                  ),
                ),
                const SizedBox(width: 12),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/grid_box.svg",
                      width: maxDiameterDp,
                      height: maxDiameterDp,
                      fit: BoxFit.contain,
                      colorFilter: const ColorFilter.mode(
                          Color(0xFFDFD0B8), BlendMode.srcIn),
                    ),
                    Container(
                      width: currentDiameterDp,
                      height: currentDiameterDp,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0xFFDFD0B8), width: 1.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                IconButton(
                  onPressed: () {
                    final item = sizeChart[closestIndex];
                    final message =
                        "Yüzük ölçüm sonucu:\nÖlçü: ${item['us']}\nÇap: ${item['diameter']} mm\nÇevre: ${item['circumference']} mm";
                    _shareOnWhatsApp(message);
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/forward.svg",
                    width: 45,
                    height: 45,
                    colorFilter:
                    const ColorFilter.mode(Color(0xFFDFD0B8), BlendMode.srcIn),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // slider + oklar
            Row(
              children: [
                IconButton(
                  onPressed: _stepBackward,
                  icon: const Icon(Icons.chevron_left,
                      color: Color(0xFFDFD0B8)),
                ),
                Expanded(
                  child: Slider(
                    activeColor: const Color(0xFFDFD0B8),
                    inactiveColor:
                    const Color(0xFFDFD0B8).withValues(alpha: 0.3),
                    value: diameterMm,
                    min: minDiameter,
                    max: maxDiameter,
                    divisions: sizeChart.length - 1,
                    onChanged: (value) {
                      setState(() {
                        diameterMm = value;
                      });
                    },
                  ),
                ),
                IconButton(
                  onPressed: _stepForward,
                  icon: const Icon(Icons.chevron_right,
                      color: Color(0xFFDFD0B8)),
                ),
              ],
            ),

            const SizedBox(height: 8),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Size Chart",
                    style: TextStyle(
                        color: Color(0xFFDFD0B8), fontSize: 18)),
              ),
            ),
            const SizedBox(height: 8),

            // liste
            Expanded(
              child: ListView.builder(
                itemCount: sizeChart.length,
                itemBuilder: (context, index) {
                  final item = sizeChart[index];
                  final isSelected = index == closestIndex;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        diameterMm = item['diameter'];
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFDFD0B8)),
                        borderRadius: BorderRadius.circular(8),
                        color: isSelected
                            ? const Color(0xFFDFD0B8).withValues(alpha: 0.1)
                            : Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${item['us']}",
                              style: const TextStyle(color: Color(0xFFDFD0B8),fontSize: 18)),
                          Text("${item['diameter']}",
                              style: const TextStyle(color: Color(0xFFDFD0B8),fontSize: 18)),
                          Text("${item['circumference']}",
                              style: const TextStyle(color: Color(0xFFDFD0B8),fontSize: 18)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // alt ikonlar
            Padding(
              padding: const EdgeInsets.only(bottom: 16, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      final url = Uri.parse("https://www.instagram.com/balladeart?igsh=Z3B6bHV5OWd4MXFw");
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url,
                            mode: LaunchMode.externalApplication);
                      }
                    },
                    child: SvgPicture.asset(
                      "assets/icons/insta.svg",
                      width: 32,
                      colorFilter: const ColorFilter.mode(
                          Color(0xFFDFD0B8), BlendMode.srcIn),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final url = Uri.parse("https://www.balladeart.com/");
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url,
                            mode: LaunchMode.externalApplication);
                      }
                    },
                    child: SvgPicture.asset(
                      "assets/icons/website.svg",
                      width: 32,
                      colorFilter: const ColorFilter.mode(
                          Color(0xFFDFD0B8), BlendMode.srcIn),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final url = Uri.parse("https://maps.app.goo.gl/3FNax1PRdAbcfiPN7");
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url,
                            mode: LaunchMode.externalApplication);
                      }
                    },
                    child: SvgPicture.asset(
                      "assets/icons/location.svg",
                      width: 30,
                      colorFilter: const ColorFilter.mode(
                          Color(0xFFDFD0B8), BlendMode.srcIn),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
    );
  }
}
