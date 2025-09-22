import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/models/community_tab_model.dart';

class CommunityTabView extends StatelessWidget {
  const CommunityTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF3F6F4),
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: const [
                Icon(Icons.search, color: Colors.black54),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search news…',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const _TopicChips(),
        const SizedBox(height: 8),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(newsList.length, (index) {
                final news = newsList[index];
                final imagePath = imageAssetPaths[index % imageAssetPaths.length];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.12),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            news['title'] ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            height: 180,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F6F4),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              imagePath,
                              width: 96,
                              height: 96,
                              colorFilter: const ColorFilter.mode(Color(0xFF2E7D32), BlendMode.srcIn),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            news['desc'] ?? '',
                            style: const TextStyle(fontSize: 15),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: const [
                              Icon(Icons.calendar_today, size: 14, color: Colors.black45),
                              SizedBox(width: 6),
                              Text('Today', style: TextStyle(fontSize: 12, color: Colors.black54)),
                              Spacer(),
                              Icon(Icons.chat_bubble_outline, size: 14, color: Colors.black45),
                              SizedBox(width: 6),
                              Text('12 comments', style: TextStyle(fontSize: 12, color: Colors.black54)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}

class _TopicChips extends StatelessWidget {
  const _TopicChips();

  @override
  Widget build(BuildContext context) {
    final topics = const ['All', 'Irrigation', 'Soil', 'Pests', 'Market', 'Tips'];
    return SizedBox(
      height: 36,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final label = topics[index];
          final bool isPrimary = index == 0;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: isPrimary ? const Color(0xFF2E7D32) : const Color(0xFFF3F6F4),
              borderRadius: BorderRadius.circular(18),
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                color: isPrimary ? Colors.white : Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: topics.length,
      ),
    );
  }
}