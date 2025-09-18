import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Ölçüm durumu
  double diameterMm = 16.0; // slider ile ayarlanacak
  double get circumferenceMm => diameterMm * math.pi;

  // EU ölçü tablosu (örnek değerler: çap mm -> EU)
  final List<Map<String, dynamic>> ringTable = List.generate(36, (i) {
    // 1. ölçü = 13 mm, 36. ölçü = 24.3 mm
    final step = (24.3 - 13.0) / 35;
    final dia = 13.0 + i * step;
    return {
      "eu": i + 1,
      "dia": dia,
      "cir": dia * math.pi,
    };
  });

  // Slider aralığı
  final double minDia = 13.0;
  final double maxDia = 24.3;

  // Alt kısım linkleri (kendi linklerinle değiştir)
  final Uri ig = Uri.parse('https://instagram.com/balladeart');
  final Uri web = Uri.parse('https://example.com');
  final Uri maps = Uri.parse('https://maps.google.com/?q=Ballade+Art');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // Kutunun boyutu ekranın %68’i ama min/max sınırlarla
    final baseEdge = width * 0.68;
    const minEdge = 180.0;
    final maxEdgeByW = width - 60;
    final maxEdgeByH = height * 0.5;

    // güvenli max hesap
    final safeMaxEdge = math.max(minEdge, math.min(maxEdgeByW, maxEdgeByH));
    final boxEdge = baseEdge.clamp(minEdge, safeMaxEdge);

    // pxPerMm (telefonun pixel density'sine göre ayarlayabilirsin)
    const pxPerMm = 10.0;
    final ringPx = (diameterMm * pxPerMm).clamp(0.0, boxEdge - 20);

    const bg = Color(0xFF222831);
    const ink = Color(0xFFDFD0B8);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Başlık
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 12),
                child: Text(
                  'BALLADEART',
                  style: const TextStyle(
                    color: ink,
                    fontSize: 28,
                    letterSpacing: 4,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Üst kontrol satırı
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _svgIconBig("assets/icons/help.svg", onTap: _showHelp),
                  _MeasurementBox(edge: boxEdge, diameterPx: ringPx),
                  _svgIconBig("assets/icons/forward.svg", onTap: () {
                    _showSnack('Next action here');
                  }),
                ],
              ),

              const SizedBox(height: 16),

              // Slider + oklar
              Row(
                children: [
                  _tinyArrow(onTap: () => _nudge(-0.1), icon: Icons.chevron_left),
                  Expanded(
                    child: Column(
                      children: [
                        _Ruler(min: minDia, max: maxDia, value: diameterMm),
                        Slider(
                          min: minDia,
                          max: maxDia,
                          divisions: ((maxDia - minDia) * 10).round(),
                          value: diameterMm,
                          activeColor: ink,
                          inactiveColor: ink.withOpacity(0.3),
                          onChanged: (v) {
                            setState(() {
                              diameterMm = double.parse(v.toStringAsFixed(1));
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  _tinyArrow(onTap: () => _nudge(0.1), icon: Icons.chevron_right),
                ],
              ),

              const SizedBox(height: 8),

              // "Size Chart"
              Row(
                children: const [
                  Text('Size Chart',
                      style: TextStyle(color: ink, fontSize: 18)),
                  Spacer(),
                  Icon(Icons.circle_outlined, color: ink, size: 20),
                  SizedBox(width: 8),
                ],
              ),

              const SizedBox(height: 8),

              // Tablo
              Expanded(
                child: SingleChildScrollView(
                  child: _SizeTable(
                    table: ringTable,
                    currentDia: diameterMm,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Alt ikonlar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _svgIcon("assets/icons/insta.svg", onTap: () => _open(ig)),
                  _svgIcon("assets/icons/website.svg", onTap: () => _open(web)),
                  _svgIcon("assets/icons/location.svg", onTap: () => _open(maps)),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  // --- helpers --------------------------------------------------------------

  void _nudge(double delta) {
    final next = (diameterMm + delta).clamp(minDia, maxDia);
    setState(() => diameterMm = double.parse(next.toStringAsFixed(1)));
  }

  Widget _tinyArrow({required VoidCallback onTap, required IconData icon}) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, size: 26, color: const Color(0xFFDFD0B8)),
    );
  }

  Widget _svgIconBig(String path, {required VoidCallback onTap}) {
    return InkResponse(
      onTap: onTap,
      radius: 32,
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: SvgPicture.asset(
          path,
          fit: BoxFit.contain,
          color: const Color(0xFFDFD0B8),
        ),
      ),
    );
  }

  Widget _svgIcon(String path, {required VoidCallback onTap}) {
    return InkResponse(
      onTap: onTap,
      radius: 20,
      child: SizedBox(
        width: 36,
        height: 36,
        child: SvgPicture.asset(
          path,
          fit: BoxFit.contain,
          color: const Color(0xFFDFD0B8),
        ),
      ),
    );
  }

  void _showHelp() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0F1419),
      showDragHandle: true,
      builder: (_) => const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Yüzüğünüzü ekranın ortasındaki daireye hizalayın. '
              'Dairenin çapını slider ile büyütüp küçültün. '
              'Alt kısımdaki tablo, seçtiğiniz değere karşılık gelen EU (ISO) ölçüsünü gösterir.',
          style: TextStyle(color: Color(0xFFDFD0B8)),
        ),
      ),
    );
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _open(Uri uri) async {
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      _showSnack('Açılamadı: $uri');
    }
  }
}

/// Ölçüm kutusu
class _MeasurementBox extends StatelessWidget {
  final double edge;
  final double diameterPx;

  const _MeasurementBox({required this.edge, required this.diameterPx});

  @override
  Widget build(BuildContext context) {
    const ink = Color(0xFFDFD0B8);
    const inkDim = Color(0x66DFD0B8);

    return Container(
      width: edge,
      height: edge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: inkDim),
      ),
      child: CustomPaint(
        painter: _GridPainter(lineColor: inkDim),
        child: Center(
          child: Container(
            width: diameterPx,
            height: diameterPx,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: ink, width: 2),
            ),
          ),
        ),
      ),
    );
  }
}

/// Grid painter
class _GridPainter extends CustomPainter {
  final Color lineColor;
  const _GridPainter({required this.lineColor});

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = lineColor..strokeWidth = 1.2;
    const step = 20.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) => false;
}

/// Cetvel painter
class _Ruler extends StatelessWidget {
  final double min, max, value;
  const _Ruler({required this.min, required this.max, required this.value});

  @override
  Widget build(BuildContext context) {
    const ink = Color(0x66DFD0B8);
    const strong = Color(0xFFDFD0B8);
    return SizedBox(
      height: 30,
      child: CustomPaint(
        painter: _RulerPainter(
          min: min,
          max: max,
          value: value,
          line: ink,
          strong: strong,
        ),
      ),
    );
  }
}

class _RulerPainter extends CustomPainter {
  final double min, max, value;
  final Color line, strong;

  _RulerPainter(
      {required this.min,
        required this.max,
        required this.value,
        required this.line,
        required this.strong});

  @override
  void paint(Canvas canvas, Size size) {
    final total = max - min;
    final pThin = Paint()..color = line..strokeWidth = 1;
    final pBold = Paint()..color = strong..strokeWidth = 2;

    final int mmTicks = (total * 2).round();

    for (int i = 0; i <= mmTicks; i++) {
      final x = size.width * (i / mmTicks);
      final isFullMm = i % 2 == 0;
      final h = isFullMm ? size.height : size.height * 0.6;
      canvas.drawLine(
          Offset(x, size.height - h),
          Offset(x, size.height),
          isFullMm ? pBold : pThin);
    }

    // ok işareti
    final dx = size.width * ((value - min) / total);
    final path = Path()
      ..moveTo(dx, 0)
      ..lineTo(dx - 7, 10)
      ..lineTo(dx + 7, 10)
      ..close();
    canvas.drawPath(path, pBold);
  }

  @override
  bool shouldRepaint(covariant _RulerPainter old) =>
      old.value != value || old.min != min || old.max != max;
}

/// Tablo
class _SizeTable extends StatelessWidget {
  final List<Map<String, dynamic>> table;
  final double currentDia;

  const _SizeTable({required this.table, required this.currentDia});

  @override
  Widget build(BuildContext context) {
    const ink = Color(0xFFDFD0B8);

    // en yakın 3 ölçüyü göster
    table.sort((a, b) =>
        (a['dia'] as double).compareTo(b['dia'] as double));
    final nearest = table
        .map((e) => e)
        .toList()
      ..sort((a, b) =>
          ((a['dia'] - currentDia).abs())
              .compareTo((b['dia'] - currentDia).abs()));

    final rows = nearest.take(4).toList();

    Widget headerCell(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(t,
          style: const TextStyle(color: ink, fontSize: 12),
          textAlign: TextAlign.center),
    );

    TableRow header = TableRow(
      children: [
        headerCell('EU\nISO'),
        headerCell('Diameter (mm)'),
        headerCell('Circumference (mm)'),
      ],
    );

    List<TableRow> body = [];
    for (final r in rows) {
      final isSel =
          (r['dia'] - currentDia).abs() < 0.2; // yakın ölçü highlight
      body.add(
        TableRow(
          decoration: BoxDecoration(
            border: Border.all(
                color: isSel ? ink : ink.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(10),
          ),
          children: [
            _cell(r['eu'].toString(), isSel),
            _cell(r['dia'].toStringAsFixed(1), isSel),
            _cell(r['cir'].toStringAsFixed(1), isSel),
          ],
        ),
      );
    }

    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1.2),
        1: FlexColumnWidth(1.4),
        2: FlexColumnWidth(1.6),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [header, ...body],
    );
  }

  Widget _cell(String text, bool highlight) {
    const ink = Color(0xFFDFD0B8);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ink,
          fontWeight: highlight ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
    );
  }
}
