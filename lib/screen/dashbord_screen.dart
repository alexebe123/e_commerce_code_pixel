// lib/main.dart
import 'package:flutter/material.dart';



class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  int _columnsForWidth(double width) {
    if (width < 600) return 1;     // mobile
    if (width < 1000) return 2;    // tablet / small desktop
    return 3;                      // large desktop
  }

  // medium card height for dashboard tiles
  double _cardHeightForWidth(double width) {
    if (width < 600) return 160;
    if (width < 1000) return 200;
    return 180;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F7),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          final cols = _columnsForWidth(constraints.maxWidth);
          final cardHeight = _cardHeightForWidth(constraints.maxWidth);

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top navigation / title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.storefront, color: Colors.green.shade700),
                      ),
                      const SizedBox(width: 12),
                      Text('Dashboard', style: theme.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold)),
                    ]),
                    Row(children: [
                      if (constraints.maxWidth > 600) ...[
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.home_outlined),
                          label: const Text('Home'),
                        ),
                        const SizedBox(width: 8),
                      ],
                      IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                      CircleAvatar(child: const Icon(Icons.person)),
                    ])
                  ],
                ),
                const SizedBox(height: 20),

                // Grid of cards (responsive)
                GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: cols,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: (constraints.maxWidth / cols) / cardHeight,
                  ),
                  children: [
                    // Total Profit
                    _StatCard(
                      title: 'Total Profit',
                      subtitle: '(Completed Orders)',
                      value: '\$95,000',
                      accent: Colors.green,
                      showArrowUp: true,
                    ),

                    // Total Loss
                    _StatCard(
                      title: 'Total Loss',
                      subtitle: '(Returned Orders)',
                      value: '-\$1,000',
                      accent: Colors.red,
                      showArrowUp: false,
                    ),

                    // Net Revenue Trend (placeholder graph)
                    _LargeCard(
                      title: 'Net Revenue Trend',
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Expanded(child: _SimpleLineChart()),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('2011'),
                                Text('2016'),
                                Text('2021'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Order Financial Status (donut)
                    _LargeCard(
                      title: 'Order Financial Status',
                      child: Center(
                        child: SizedBox(
                          width: 140,
                          height: 140,
                          child: CustomPaint(
                            painter: _DonutPainter(),
                          ),
                        ),
                      ),
                    ),

                    // Top Performing Categories (wide)
                    _WideCard(
                      title: 'Top Performing Categories',
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            _CategoryRow(label: 'Product A', percent: 0.7),
                            _CategoryRow(label: 'Product B', percent: 0.2),
                            _CategoryRow(label: 'Apparel B', percent: 0.1),
                            _CategoryRow(label: 'Apparel C', percent: 0.2),
                          ],
                        ),
                      ),
                    ),

                    // Placeholder for more content
                    _LargeCard(
                      title: 'Recent Orders',
                      child: const Center(child: Text('Table or list of orders here')),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

/// Small statistic card (profit/loss)
class _StatCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String value;
  final Color accent;
  final bool showArrowUp;

  const _StatCard({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.accent,
    required this.showArrowUp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withOpacity(0.12), width: 2),
        boxShadow: const [
          BoxShadow(color: Color(0x11000000), blurRadius: 12, offset: Offset(0, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: accent)),
              Icon(showArrowUp ? Icons.arrow_upward : Icons.arrow_downward, color: accent),
            ],
          )
        ],
      ),
    );
  }
}

/// Generic card used for charts / content
class _LargeCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _LargeCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 12, offset: Offset(0, 6))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Expanded(child: child),
        ],
      ),
    );
  }
}

/// A variation that spans more vertical space (useful in grid)
class _WideCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _WideCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return _LargeCard(title: title, child: child);
  }
}

/// Small horizontal bar used in "Top Performing Categories"
class _CategoryRow extends StatelessWidget {
  final String label;
  final double percent; // 0.0 - 1.0
  const _CategoryRow({required this.label, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(label, style: const TextStyle(fontSize: 13))),
          const SizedBox(width: 8),
          Expanded(
            child: Stack(
              children: [
                Container(height: 14, decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8))),
                FractionallySizedBox(
                  widthFactor: percent,
                  child: Container(height: 14, decoration: BoxDecoration(color: Colors.green.shade400, borderRadius: BorderRadius.circular(8))),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text('${(percent * 100).round()}%', style: const TextStyle(fontSize: 12))
        ],
      ),
    );
  }
}

/// Simple painted 'line chart' placeholder (not a full-featured chart lib)
class _SimpleLineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LineChartPainter(),
      child: Container(),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintGrid = Paint()
      ..color = Colors.grey.withOpacity(0.12)
      ..style = PaintingStyle.stroke;
    // draw some horizontal grid lines
    for (int i = 1; i <= 4; i++) {
      final y = size.height * i / 5;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paintGrid);
    }

    // fake data points (normalized)
    final points = <Offset>[
      Offset(0.0 * size.width, size.height * 0.8),
      Offset(0.15 * size.width, size.height * 0.6),
      Offset(0.3 * size.width, size.height * 0.7),
      Offset(0.45 * size.width, size.height * 0.5),
      Offset(0.6 * size.width, size.height * 0.4),
      Offset(0.75 * size.width, size.height * 0.45),
      Offset(0.9 * size.width, size.height * 0.3),
      Offset(1.0 * size.width, size.height * 0.35),
    ];

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (var p in points.skip(1)) path.lineTo(p.dx, p.dy);

    final fill = Paint()
      ..shader = LinearGradient(
        colors: [Colors.green.withOpacity(0.16), Colors.transparent],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final stroke = Paint()
      ..color = Colors.green.shade600
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    // draw filled area
    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(fillPath, fill);

    // draw the line
    canvas.drawPath(path, stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Donut / pie painter (simple)
class _DonutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = size.width / 2;

    final paintBackground = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.stroke
      ..strokeWidth = 22;

    canvas.drawCircle(center, radius - 11, paintBackground);

    final paintGreen = Paint()
      ..color = Colors.green.shade500
      ..style = PaintingStyle.stroke
      ..strokeWidth = 22
      ..strokeCap = StrokeCap.butt;

    final paintRed = Paint()
      ..color = Colors.red.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 22
      ..strokeCap = StrokeCap.butt;

    // angles for example: green 70% , red 30%
    final greenSweep = 2 * 3.1415926535 * 0.7;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 11), -3.1415 / 2, greenSweep, false, paintGreen);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 11), -3.1415 / 2 + greenSweep, 2 * 3.1415926535 * 0.3, false, paintRed);

    // inner circle to make donut hole
    final hole = Paint()..color = Colors.white;
    canvas.drawCircle(center, radius - 36, hole);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
