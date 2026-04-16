import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/providers/preferences_provider.dart';
import '../../../prayer/domain/prayer_times_service.dart';

class LocationPermissionStep extends ConsumerWidget {
  const LocationPermissionStep({
    super.key,
    required this.onNext,
    required this.onBack,
  });
  final VoidCallback onNext;
  final VoidCallback onBack;

  Future<void> _requestLocation(WidgetRef ref) async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      final position = await Geolocator.getCurrentPosition();
      final prefs = await ref.read(userPreferencesProvider.future);
      prefs.latitude = position.latitude;
      prefs.longitude = position.longitude;
      prefs.madhab = PrayerTimesService.madhabForLocation(
        position.latitude,
        position.longitude,
      );
    }

    onNext();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 80,
            color: context.colorScheme.primary,
          ),
          const SizedBox(height: 24),
          Text(
            context.l10n.onboardingLocation,
            style: context.textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            context.l10n.onboardingLocationDesc,
            style: context.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          FilledButton.icon(
            onPressed: () => _requestLocation(ref),
            icon: const Icon(Icons.my_location),
            label: Text(context.l10n.next),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: onNext,
            child: Text(context.l10n.skip),
          ),
        ],
      ),
    );
  }
}
