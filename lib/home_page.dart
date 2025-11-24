import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dpi_helper.dart';
import 'package:video_player/video_player.dart';


// 🔹 Yüzük ölçü tablosu (EU formatında; eski 'us' değerleri aynen 'eu' alanına taşındı)
final List<Map<String, dynamic>> sizeChart = [
  {"eu": 1, "diameter": 13.0, "circumference": 40.84},
  {"eu": 1.5, "diameter": 13.16, "circumference": 41.35},
  {"eu": 2, "diameter": 13.32, "circumference": 41.85},
  {"eu": 2.5, "diameter": 13.48, "circumference": 42.36},
  {"eu": 3, "diameter": 13.65, "circumference": 42.87},
  {"eu": 3.5, "diameter": 13.81, "circumference": 43.38},
  {"eu": 4, "diameter": 13.97, "circumference": 43.88},
  {"eu": 4.5, "diameter": 14.13, "circumference": 44.39},
  {"eu": 5, "diameter": 14.29, "circumference": 44.90},
  {"eu": 5.5, "diameter": 14.45, "circumference": 45.40},
  {"eu": 6, "diameter": 14.61, "circumference": 45.91},
  {"eu": 6.5, "diameter": 14.78, "circumference": 46.42},
  {"eu": 7, "diameter": 14.94, "circumference": 46.93},
  {"eu": 7.5, "diameter": 15.10, "circumference": 47.43},
  {"eu": 8, "diameter": 15.26, "circumference": 47.94},
  {"eu": 8.5, "diameter": 15.42, "circumference": 48.45},
  {"eu": 9, "diameter": 15.58, "circumference": 48.95},
  {"eu": 9.5, "diameter": 15.74, "circumference": 49.46},
  {"eu": 10, "diameter": 15.91, "circumference": 49.97},
  {"eu": 10.5, "diameter": 16.07, "circumference": 50.48},
  {"eu": 11, "diameter": 16.23, "circumference": 50.98},
  {"eu": 11.5, "diameter": 16.39, "circumference": 51.49},
  {"eu": 12, "diameter": 16.55, "circumference": 52.00},
  {"eu": 12.5, "diameter": 16.71, "circumference": 52.50},
  {"eu": 13, "diameter": 16.87, "circumference": 53.01},
  {"eu": 13.5, "diameter": 17.04, "circumference": 53.52},
  {"eu": 14, "diameter": 17.20, "circumference": 54.03},
  {"eu": 14.5, "diameter": 17.36, "circumference": 54.53},
  {"eu": 15, "diameter": 17.52, "circumference": 55.04},
  {"eu": 15.5, "diameter": 17.68, "circumference": 55.55},
  {"eu": 16, "diameter": 17.84, "circumference": 56.05},
  {"eu": 16.5, "diameter": 18.00, "circumference": 56.56},
  {"eu": 17, "diameter": 18.17, "circumference": 57.07},
  {"eu": 17.5, "diameter": 18.33, "circumference": 57.58},
  {"eu": 18, "diameter": 18.49, "circumference": 58.08},
  {"eu": 18.5, "diameter": 18.65, "circumference": 58.59},
  {"eu": 19, "diameter": 18.81, "circumference": 59.10},
  {"eu": 19.5, "diameter": 18.97, "circumference": 59.60},
  {"eu": 20, "diameter": 19.13, "circumference": 60.11},
  {"eu": 20.5, "diameter": 19.30, "circumference": 60.62},
  {"eu": 21, "diameter": 19.46, "circumference": 61.13},
  {"eu": 21.5, "diameter": 19.62, "circumference": 61.63},
  {"eu": 22, "diameter": 19.78, "circumference": 62.14},
  {"eu": 22.5, "diameter": 19.94, "circumference": 62.65},
  {"eu": 23, "diameter": 20.10, "circumference": 63.15},
  {"eu": 23.5, "diameter": 20.26, "circumference": 63.66},
  {"eu": 24, "diameter": 20.43, "circumference": 64.17},
  {"eu": 24.5, "diameter": 20.59, "circumference": 64.68},
  {"eu": 25, "diameter": 20.75, "circumference": 65.18},
  {"eu": 25.5, "diameter": 20.91, "circumference": 65.69},
  {"eu": 26, "diameter": 21.07, "circumference": 66.20},
  {"eu": 26.5, "diameter": 21.23, "circumference": 66.70},
  {"eu": 27, "diameter": 21.39, "circumference": 67.21},
  {"eu": 27.5, "diameter": 21.56, "circumference": 67.72},
  {"eu": 28, "diameter": 21.72, "circumference": 68.23},
  {"eu": 28.5, "diameter": 21.88, "circumference": 68.73},
  {"eu": 29, "diameter": 22.04, "circumference": 69.24},
  {"eu": 29.5, "diameter": 22.20, "circumference": 69.75},
  {"eu": 30, "diameter": 22.36, "circumference": 70.25},
  {"eu": 30.5, "diameter": 22.52, "circumference": 70.76},
  {"eu": 31, "diameter": 22.69, "circumference": 71.27},
  {"eu": 31.5, "diameter": 22.85, "circumference": 71.78},
  {"eu": 32, "diameter": 23.01, "circumference": 72.28},
  {"eu": 32.5, "diameter": 23.17, "circumference": 72.79},
  {"eu": 33, "diameter": 23.33, "circumference": 73.30},
  {"eu": 33.5, "diameter": 23.49, "circumference": 73.80},
  {"eu": 34, "diameter": 23.65, "circumference": 74.31},
  {"eu": 34.5, "diameter": 23.82, "circumference": 74.82},
  {"eu": 35, "diameter": 23.98, "circumference": 75.33},
  {"eu": 35.5, "diameter": 24.14, "circumference": 75.83},
  {"eu": 36, "diameter": 24.30, "circumference": 76.34},
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  double diameterMm = 13.0;
  final double minDiameter = 13.0;
  final double maxDiameter = 24.3;

  Map<String, double> dpi = {"xdpi": 0.0, "ydpi": 0.0};
  late bool isTurkish;


  @override
  void initState() {
    super.initState();
    final langCode = WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    isTurkish = langCode == 'tr';   // <-- dil tespiti buraya eklendi

    _loadDpi();
  }

  Future<void> _loadDpi() async {
    final result = await DpiHelper.getDpi();
    if (!mounted) return; // clean guard
    setState(() => dpi = result);
  }


  // 🔸 Seçili satırı görünür tut
  void _scrollToSelected() {
    final index = sizeChart.indexed.reduce((a, b) =>
    (a.$2['diameter'] - diameterMm).abs() <
        (b.$2['diameter'] - diameterMm).abs()
        ? a
        : b).$1;

    const double itemHeight = 64.0; // kart başına yaklaşık yükseklik
    final scrollOffset = _scrollController.offset;
    final viewHeight = _scrollController.position.viewportDimension;
    final targetOffset = index * itemHeight;

    if (targetOffset < scrollOffset ||
        targetOffset > scrollOffset + viewHeight - itemHeight) {
      _scrollController.animateTo(
        (targetOffset - viewHeight / 2)
            .clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    }
  }

  void _stepBackward() {
    setState(() {
      diameterMm = (diameterMm - 0.16).clamp(minDiameter, maxDiameter);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToSelected());
  }

  void _stepForward() {
    setState(() {
      diameterMm = (diameterMm + 0.16).clamp(minDiameter, maxDiameter);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToSelected());
  }
  Future<void> _showHelpVideo() async {
    final controller = VideoPlayerController.asset('assets/videos/help.mp4');

    await controller.initialize();
    if (!mounted) return; // <- profesyonel koruma

    controller
      ..setLooping(true)
      ..play();

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF222831),
        title: Text(
          isTurkish ? "Nasıl Kullanılır" : "How to Use",
          style: const TextStyle(color: Color(0xFFDFD0B8)),
        ),
        content: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              isTurkish ? "Kapat" : "Close",
              style: const TextStyle(color: Color(0xFFDFD0B8)),
            ),
          ),
        ],
      ),
    );

    controller.dispose();
  }


  Future<void> _shareOnWhatsApp(String message) async {
    final url = Uri.parse("https://wa.me/?text=${Uri.encodeComponent(message)}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }//KILL ME NOW

  @override
  Widget build(BuildContext context) {
    if (dpi["xdpi"] == 0.0) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final xdpi = dpi["xdpi"]!;
    final dpr = MediaQuery.of(context).devicePixelRatio;

    // halka ölçüleri (dp)
    final maxDiameterDp =
        DpiHelper.mmToDp(mm: maxDiameter, dpi: xdpi, dpr: dpr) + 40;
    final currentDiameterDp =
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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

              // 🔹 kutu + halka + ikonlar
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => _showHelpVideo(),
                    icon: SvgPicture.asset(
                      "assets/icons/help.svg",
                      width: 45,
                      height: 45,
                      colorFilter: const ColorFilter.mode(Color(0xFFDFD0B8), BlendMode.srcIn),
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
                              color: const Color(0xFFDFD0B8), width: 1.8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    onPressed: () {
                      final item = sizeChart[closestIndex];
                      final message = isTurkish
                          ? "Yüzük ölçüm sonucu:\nÖlçü: ${item['eu']}\nÇap: ${item['diameter']} mm\nÇevre: ${item['circumference']} mm"
                          : "Ring size result:\nSize: ${item['eu']}\nDiameter: ${item['diameter']} mm\nCircumference: ${item['circumference']} mm";

                      _shareOnWhatsApp(message);
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/forward.svg",
                      width: 45,
                      height: 45,
                      colorFilter: const ColorFilter.mode(Color(0xFFDFD0B8), BlendMode.srcIn),
                    ),
                  ),


                ],
              ),

              const SizedBox(height: 16),

              // 🔹 slider + oklar
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
                      const Color(0xFFDFD0B8).withValues(alpha: 0.6),
                      value: diameterMm,
                      min: minDiameter,
                      max: maxDiameter,

                      onChanged: (value) {
                        setState(() {
                          diameterMm = value;
                        });
                        // seçili satırı görünür tut
                        WidgetsBinding.instance
                            .addPostFrameCallback((_) => _scrollToSelected());
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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    isTurkish ? "Ölçü Tablosu" : "Size Chart",
                    style: const TextStyle(
                      color: Color(0xFFDFD0B8),
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),
              // --- sütun başlıkları (liste üstü) ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: const Color(0xFFDFD0B8).withValues(alpha: 0.75),
                        width: 1,
                      ),
                    ),
                  ),
                  child:  Row(
                    children: [
                      // Size
                      Expanded(
                        child: Text(
                          isTurkish ? "Ölçü" : "Size",
                          style : TextStyle(
                            color: Color(0xFFDFD0B8),
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      // Diameter (mm)
                      Expanded(
                        child: Center(
                          child: Text(
                            isTurkish ? "Çap" : "Diameter",
                            style: TextStyle(
                              color: Color(0xFFDFD0B8),
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      // Circumference (mm)
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            isTurkish ? "Çevre" : "Circumference",
                            style: TextStyle(
                              color: Color(0xFFDFD0B8),
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),


              // 🔹 liste
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: sizeChart.length,
                  itemBuilder: (context, index) {
                    final item = sizeChart[index];
                    final isSelected = index == closestIndex;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          diameterMm = item['diameter'];
                        });
                        WidgetsBinding.instance
                            .addPostFrameCallback((_) => _scrollToSelected());
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          border:
                          Border.all(color: const Color(0xFFDFD0B8)),
                          borderRadius: BorderRadius.circular(8),
                          color: isSelected
                              ? const Color(0xFFDFD0B8)
                              .withValues(alpha: 0.1)
                              : Colors.transparent,
                        ),
                        child: Row(
                          children: [
                            // 1) Size (EU) - sola hizalı
                            Expanded(
                              child: Text(
                                "${item['eu']}",
                                style: const TextStyle(color: Color(0xFFDFD0B8), fontSize: 18),
                              ),
                            ),

                            // 2) Diameter (mm) - ortalı
                            Expanded(
                              child: Center(
                                child: Text(
                                  "${item['diameter']}",
                                  style: const TextStyle(color: Color(0xFFDFD0B8), fontSize: 18),
                                ),
                              ),
                            ),

                            // 3) Circumference (mm) - sağa hizalı
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "${item['circumference']}",
                                  style: const TextStyle(color: Color(0xFFDFD0B8), fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),

                      ),
                    );
                  },
                ),
              ),

              // 🔹 alt ikonlar
              Padding(
                padding: const EdgeInsets.only(bottom: 16, top: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () async {
                        final url = Uri.parse(
                            "https://www.instagram.com/balladeart?igsh=Z3B6bHV5OWd4MXFw");
                        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                          debugPrint("❌ Instagram linki açılamadı: $url");
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
                        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                          debugPrint("❌ Website linki açılamadı: $url");
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
                        final url = Uri.parse(
                            "https://maps.app.goo.gl/3FNax1PRdAbcfiPN7");
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
      ),
    );
  }
}
