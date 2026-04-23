import 'package:flutter/material.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../chat/domain/chat_component.dart';
import '../../../chat/domain/models/component_data.dart';
import 'prayer_rows_widget.dart';

class PrayerTimesCard extends StatelessWidget with ChatComponent {
  const PrayerTimesCard({super.key, required this.data});
  final PrayerTimesData data;

  @override
  Map<String, dynamic> toContextJson() => {
        'type': 'prayerTimes',
        ...data.toJson(),
      };

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 280),
      child: IntrinsicWidth(
        child: GlassContainer(
          borderRadius: 24,
          blur: 22,
          backgroundOpacity: 0.55,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
                child: PrayerRowsWidget(prayers: data.prayers),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                decoration: const BoxDecoration(
                  color: Color(0x8C8A6E4F),
                  border: Border(top: BorderSide(color: Color(0x14FFFFFF))),
                ),
                child: Text(
                  data.date,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xA6F4EFE6),
                    letterSpacing: -0.1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
