import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(),
            const SizedBox(height: 16),
            _SearchBar(),
            const SizedBox(height: 16),
            _WeatherCard(),
            const SizedBox(height: 16),
            _SectionTitle(title: 'Categories'),
            const SizedBox(height: 12),
            _CategoriesRow(),
            const SizedBox(height: 20),
            _SectionTitle(title: 'Growth this week (inches)'),
            const SizedBox(height: 12),
            Builder(
              builder: (context) {
                final List<double> growthInches = [1.2, 1.6, 2.1, 2.9, 3.5, 4.0, 4.4];
                return _GrowthChartCard(heightsInches: growthInches);
              },
            ),
            const SizedBox(height: 20),
            _SectionTitle(title: 'Featured tips'),
            const SizedBox(height: 12),
            _TipsCarousel(),
            const SizedBox(height: 28),
            _AssistantCTA(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Hello, Farmer',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 6),
              Text(
                'Grow smarter today',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            shape: BoxShape.circle,
          ),
          clipBehavior: Clip.antiAlias,
          child: SvgPicture.asset(
            'assets/images/tractor.svg',
            colorFilter: const ColorFilter.mode(Color(0xFF2E7D32), BlendMode.srcIn),
            fit: BoxFit.scaleDown,
          ),
        ),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3F6F4),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.black54),
          const SizedBox(width: 8),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search crops, diseases, tips…',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.tune, color: Colors.black54),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

class _WeatherCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF43A047), Color(0xFF2E7D32)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Today\'s Weather',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                SizedBox(height: 6),
                Text(
                  '28°C • Sunny',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 6),
                Text(
                  'Good time for irrigation in the evening',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ],
            ),
          ),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.wb_sunny, color: Colors.white, size: 40),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('See all'),
        )
      ],
    );
  }
}

class _CategoriesRow extends StatelessWidget {
  final List<_CategoryItemData> items = const [
    _CategoryItemData('Crops', Icons.grass, Color(0xFFE8F5E9), Color(0xFF2E7D32)),
    _CategoryItemData('Soil', Icons.terrain, Color(0xFFE3F2FD), Color(0xFF1565C0)),
    _CategoryItemData('Pests', Icons.bug_report, Color(0xFFFFF3E0), Color(0xFFEF6C00)),
    _CategoryItemData('Market', Icons.storefront, Color(0xFFFFEBEE), Color(0xFFC62828)),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items
          .map((e) => _CategoryChip(label: e.label, icon: e.icon, bg: e.bg, fg: e.fg))
          .toList(),
    );
  }
}

class _CategoryItemData {
  final String label;
  final IconData icon;
  final Color bg;
  final Color fg;
  const _CategoryItemData(this.label, this.icon, this.bg, this.fg);
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color bg;
  final Color fg;
  const _CategoryChip({required this.label, required this.icon, required this.bg, required this.fg});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 32 - 12) / 4,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(14)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.antiAlias,
            child: SvgPicture.asset(
              _mapCategoryToAsset(label),
              colorFilter: ColorFilter.mode(fg, BlendMode.srcIn),
              fit: BoxFit.scaleDown,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(color: fg, fontWeight: FontWeight.w600, fontSize: 12),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  String _mapCategoryToAsset(String label) {
    switch (label) {
      case 'Crops':
        return 'assets/images/plant.svg';
      case 'Soil':
        return 'assets/images/shovel.svg';
      case 'Pests':
        return 'assets/images/bug.svg';
      case 'Market':
        return 'assets/images/building-store.svg';
      default:
        return 'assets/images/leaf.svg';
    }
  }
}

class _TipsCarousel extends StatelessWidget {
  final List<_TipCardData> tips = const [
    _TipCardData('Drip irrigation saves water', 'Irrigation', Icons.water_drop, Color(0xFF2E7D32)),
    _TipCardData('Rotate crops to improve yield', 'Crop care', Icons.autorenew, Color(0xFF1565C0)),
    _TipCardData('Use neem oil for pests', 'Pest control', Icons.sanitizer, Color(0xFFEF6C00)),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tips.length,
        padding: const EdgeInsets.only(right: 4),
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final tip = tips[index];
          return _TipCard(data: tip);
        },
      ),
    );
  }
}

class _TipCardData {
  final String title;
  final String tag;
  final IconData icon;
  final Color color;
  const _TipCardData(this.title, this.tag, this.icon, this.color);
}

class _TipCard extends StatelessWidget {
  final _TipCardData data;
  const _TipCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: data.color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: data.color.withOpacity(0.18)),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: data.color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.antiAlias,
            child: SvgPicture.asset(
              _mapTipToAsset(data.tag),
              colorFilter: ColorFilter.mode(data.color, BlendMode.srcIn),
              fit: BoxFit.scaleDown,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data.tag,
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Text(
                  data.title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String _mapTipToAsset(String tag) {
    switch (tag) {
      case 'Irrigation':
        return 'assets/images/droplet.svg';
      case 'Crop care':
        return 'assets/images/plant-2.svg';
      case 'Pest control':
        return 'assets/images/bug-off.svg';
      default:
        return 'assets/images/info-circle.svg';
    }
  }
}

class _AssistantCTA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1B5E20),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            clipBehavior: Clip.antiAlias,
            child: SvgPicture.asset(
              'assets/images/robot.svg',
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              fit: BoxFit.scaleDown,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Need help? Ask the Agri Assistant',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF1B5E20),
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              Navigator.of(context).maybePop();
            },
            child: const Text('Open'),
          )
        ],
      ),
    );
  }
}


class _GrowthChartCard extends StatelessWidget {
  final List<double> heightsInches;
  const _GrowthChartCard({required this.heightsInches});
  @override
  Widget build(BuildContext context) {
    final int numDays = heightsInches.length;
    final List<BarChartGroupData> groups = List.generate(numDays, (i) {
      final day = i + 1;
      final value = heightsInches[i];
      return BarChartGroupData(
        x: day,
        barRods: [
          BarChartRodData(
            toY: value,
            color: const Color(0xFF2E7D32),
            width: 14,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: (heightsInches.reduce((a, b) => a > b ? a : b)).ceilToDouble() + 1,
              color: const Color(0xFFE8F5E9),
            ),
          ),
        ],
      );
    });

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE0E0E0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SizedBox(
        height: 200,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              getDrawingHorizontalLine: (value) => FlLine(
                color: const Color(0xFFECEFF1),
                strokeWidth: 1,
              ),
            ),
            titlesData: FlTitlesData(
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 36,
                  getTitlesWidget: (value, meta) {
                    if (value % 1 != 0) return const SizedBox.shrink();
                    return Text('${value.toInt()}"', style: const TextStyle(fontSize: 10, color: Colors.black54));
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final day = value.toInt();
                    if (day < 1 || day > numDays) return const SizedBox.shrink();
                    return Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text('D$day', style: const TextStyle(fontSize: 10, color: Colors.black54)),
                    );
                  },
                ),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: const Border(
                bottom: BorderSide(color: Color(0xFFE0E0E0)),
                left: BorderSide(color: Color(0xFFE0E0E0)),
                right: BorderSide(color: Colors.transparent),
                top: BorderSide(color: Colors.transparent),
              ),
            ),
            barGroups: groups,
          ),
        ),
      ),
    );
  }
}


