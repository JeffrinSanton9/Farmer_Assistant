import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AssistantTabView extends StatelessWidget {
  const AssistantTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primary = const Color(0xFF2E7D32);
    final Color inputBg = const Color(0xFFF3F6F4);

    return SafeArea(
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: const [
                Expanded(
                  child: Text(
                    'Agri Assistant',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: const [
                _SuggestionsChips(),
                SizedBox(height: 12),
                _ImageStrip(),
                SizedBox(height: 16),
                _FAQList(),
                SizedBox(height: 16),
                _AssistantBubble(
                  text: 'Hi! How can I help you on the farm today?',
                ),
                SizedBox(height: 10),
                _UserBubble(
                  text: 'What is the best time to water tomatoes?',
                ),
                SizedBox(height: 10),
                _AssistantBubble(
                  text: 'Usually early morning or late afternoon to reduce evaporation.',
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: inputBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.camera_alt, color: Colors.black87),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: inputBg,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Type your message…',
                        border: InputBorder.none,
                      ),
                      minLines: 1,
                      maxLines: 4,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.mic, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AssistantBubble extends StatelessWidget {
  final String text;
  const _AssistantBubble({required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFE8F5E9),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}

class _UserBubble extends StatelessWidget {
  final String text;
  const _UserBubble({required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}

class _SuggestionsChips extends StatelessWidget {
  const _SuggestionsChips();

  @override
  Widget build(BuildContext context) {
    final List<String> suggestions = const [
      'Irrigation schedule',
      'Soil health tips',
      'Pest diagnosis',
      'Fertilizer guidance',
      'Market prices',
    ];
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: suggestions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final label = suggestions[index];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F6F4),
              borderRadius: BorderRadius.circular(18),
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          );
        },
      ),
    );
  }
}

class _ImageStrip extends StatelessWidget {
  const _ImageStrip();

  @override
  Widget build(BuildContext context) {
    final List<_StripItem> items = const [
      _StripItem('Irrigation', 'assets/images/droplet.svg', Color(0xFF2E7D32)),
      _StripItem('Crop care', 'assets/images/plant-2.svg', Color(0xFF1565C0)),
      _StripItem('Pests', 'assets/images/bug.svg', Color(0xFFEF6C00)),
      _StripItem('Soil', 'assets/images/shovel.svg', Color(0xFF6D4C41)),
      _StripItem('Sunlight', 'assets/images/sun.svg', Color(0xFFFFA000)),
    ];
    return SizedBox(
      height: 88,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            width: 140,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: item.color.withOpacity(0.06),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: item.color.withOpacity(0.18)),
            ),
            child: Row(
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
                    item.assetPath,
                    colorFilter: ColorFilter.mode(item.color, BlendMode.srcIn),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item.label,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: item.color),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _StripItem {
  final String label;
  final String assetPath;
  final Color color;
  const _StripItem(this.label, this.assetPath, this.color);
}

class _FAQList extends StatelessWidget {
  const _FAQList();

  @override
  Widget build(BuildContext context) {
    final List<_FaqItem> faqs = const [
      _FaqItem(
        question: 'When should I water tomatoes?',
        answer: 'Early morning or late afternoon helps reduce evaporation and plant stress.',
      ),
      _FaqItem(
        question: 'How do I improve soil health?',
        answer: 'Add compost, rotate crops, and avoid over-tilling to maintain structure.',
      ),
      _FaqItem(
        question: 'Natural ways to manage pests?',
        answer: 'Use neem oil, encourage beneficial insects, and remove infected leaves.',
      ),
    ];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.12),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionPanelList.radio(
          expandedHeaderPadding: EdgeInsets.zero,
          elevation: 0,
          children: faqs
              .map((f) => ExpansionPanelRadio(
                    value: f.question,
                    headerBuilder: (context, isExpanded) => ListTile(
                      title: Text(
                        f.question,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Text(f.answer),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class _FaqItem {
  final String question;
  final String answer;
  const _FaqItem({required this.question, required this.answer});
}
