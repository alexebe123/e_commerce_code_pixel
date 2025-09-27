// lib/main.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    // arrange charts in column on mobile, grid on wide screens
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child:
          isMobile
              ? SingleChildScrollView(
                child: Column(
                  children: const [
                    SizedBox(height: 12),
                    _Card(
                      title: 'Net Revenue (Line)',
                      child: LineChartSample(),
                    ),
                    SizedBox(height: 12),
                    _Card(
                      title: 'Monthly Orders (Bar)',
                      child: BarChartSample(),
                    ),
                    SizedBox(height: 12),
                    _Card(title: 'Order Status (Pie)', child: PieChartSample()),
                  ],
                ),
              )
              : GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: const [
                  _Card(title: 'Net Revenue (Line)', child: LineChartSample()),
                  _Card(title: 'Monthly Orders (Bar)', child: BarChartSample()),
                  _Card(title: 'Order Status (Pie)', child: PieChartSample()),
                  // you can add another widget or a table here
                  _Card(
                    title: 'Recent Orders',
                    child: Center(child: Text('Order list here')),
                  ),
                ],
              ),
    );
  }
}

/// Small white card used to contain charts
class _Card extends StatelessWidget {
  final String title;
  final Widget child;
  const _Card({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(height: 220, child: child),
        ],
      ),
    );
  }
}

/// ===== Line Chart Example =====
class LineChartSample extends StatelessWidget {
  const LineChartSample({super.key});

  @override
  Widget build(BuildContext context) {
    // sample data points
    final spots = [
      FlSpot(0, 3),
      FlSpot(1, 3.5),
      FlSpot(2, 4),
      FlSpot(3, 4.2),
      FlSpot(4, 3.8),
      FlSpot(5, 5),
      FlSpot(6, 4.6),
      FlSpot(7, 5.2),
    ];

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true, horizontalInterval: 1),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 36),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (v, meta) {
                // simple labels for x axis
                const labels = [
                  'Jan',
                  'Feb',
                  'Mar',
                  'Apr',
                  'May',
                  'Jun',
                  'Jul',
                  'Aug',
                ];
                final idx = v.toInt();
                return Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    idx >= 0 && idx < labels.length ? labels[idx] : '',
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: 7,
        minY: 0,
        maxY: 6,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            barWidth: 3,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [Colors.green.withOpacity(0.25), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            color: Colors.green.shade700,
          ),
        ],
      ),
    );
  }
}

/// ===== Bar Chart Example =====
class BarChartSample extends StatelessWidget {
  const BarChartSample({super.key});

  @override
  Widget build(BuildContext context) {
    final barGroups = List.generate(7, (i) {
      final value = [8.0, 10.0, 6.0, 12.0, 9.0, 11.0, 7.0][i];
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: value,
            width: 14,
            borderRadius: BorderRadius.circular(6),
          ),
        ],
      );
    });

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 14,
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (v, meta) {
                const labels = [
                  'Mon',
                  'Tue',
                  'Wed',
                  'Thu',
                  'Fri',
                  'Sat',
                  'Sun',
                ];
                final idx = v.toInt();
                return Text(idx >= 0 && idx < labels.length ? labels[idx] : '');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 28),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: barGroups,
      ),
      swapAnimationDuration: const Duration(milliseconds: 400),
    );
  }
}

/// ===== Pie Chart Example =====
class PieChartSample extends StatelessWidget {
  const PieChartSample({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      PieChartSectionData(
        value: 60,
        title: 'Completed\n60%',
        radius: 56,
        titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      PieChartSectionData(
        value: 25,
        title: 'Pending\n25%',
        radius: 48,
        titleStyle: const TextStyle(fontSize: 12),
      ),
      PieChartSectionData(
        value: 15,
        title: 'Canceled\n15%',
        radius: 40,
        titleStyle: const TextStyle(fontSize: 12),
      ),
    ];

    return PieChart(
      PieChartData(
        sections: sections,
        centerSpaceRadius: 28,
        sectionsSpace: 6,
        startDegreeOffset: -90,
      ),
      swapAnimationDuration: const Duration(milliseconds: 350),
    );
  }
}
