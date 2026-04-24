import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../core/constants/islamic_constants.dart';
import '../../../core/data/preferences/secure_storage.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/providers/preferences_provider.dart';

import '../../../app/theme.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _apiKeyController = TextEditingController();
  final _baseUrlController = TextEditingController();
  bool _obscureKey = true;

  @override
  void initState() {
    super.initState();
    _loadValues();
  }

  Future<void> _loadValues() async {
    final key = await SecureStorage.getApiKey();
    final url = await SecureStorage.getApiBaseUrl();
    if (mounted) {
      setState(() {
        _apiKeyController.text = key ?? '';
        _baseUrlController.text = url ?? 'https://api.openai.com/v1';
      });
    }
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    _baseUrlController.dispose();
    super.dispose();
  }

  Future<void> _saveApiSettings() async {
    await SecureStorage.setApiKey(_apiKeyController.text.trim());
    await SecureStorage.setApiBaseUrl(_baseUrlController.text.trim());
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.apiSettingsSaved)),
      );
    }
  }

  Future<void> _changeLanguage() async {
    final prefs = await ref.read(userPreferencesProvider.future);
    final currentLang = prefs.language;

    if (!mounted) return;
    final selected = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(context.l10n.language),
        children: [
          _languageOption(context, 'en', 'English', '🇬🇧', currentLang),
          _languageOption(context, 'ar', 'العربية', '🇸🇦', currentLang),
          _languageOption(context, 'ru', 'Русский', '🇷🇺', currentLang),
        ],
      ),
    );

    if (selected != null && selected != currentLang) {
      prefs.language = selected;
      ref.read(localProvider.notifier).state = Locale(selected);
    }
  }

  Widget _languageOption(
    BuildContext context,
    String code,
    String name,
    String flag,
    String currentCode,
  ) {
    return SimpleDialogOption(
      onPressed: () => Navigator.pop(context, code),
      child: Row(
        children: [
          Text(flag, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(child: Text(name, style: const TextStyle(fontSize: 16))),
          if (code == currentCode)
            Icon(Icons.check, color: Theme.of(context).colorScheme.primary),
        ],
      ),
    );
  }

  Future<void> _changeMadhab() async {
    final prefs = await ref.read(userPreferencesProvider.future);
    final currentMadhab = prefs.madhab;

    if (!mounted) return;
    final selected = await showDialog<Madhab>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(context.l10n.madhab),
        children: Madhab.values.map((m) => SimpleDialogOption(
          onPressed: () => Navigator.pop(context, m),
          child: Row(
            children: [
              Expanded(
                child: Text(m.displayName, style: const TextStyle(fontSize: 16)),
              ),
              if (m == currentMadhab)
                Icon(Icons.check, color: Theme.of(context).colorScheme.primary),
            ],
          ),
        )).toList(),
      ),
    );

    if (selected != null && selected != currentMadhab) {
      prefs.madhab = selected;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localProvider);
    final langName = switch (locale.languageCode) {
      'ar' => 'العربية',
      'ru' => 'Русский',
      _ => 'English',
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings),
      ),
      body: ListView(
        padding: const EdgeInsets.all(QadrSpacing.md),
        children: [
          // AI section
          Text(
            context.l10n.aiChat,
            style: context.textTheme.titleSmall?.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
          const SizedBox(height: QadrSpacing.sm),
          TextField(
            controller: _baseUrlController,
            decoration: InputDecoration(
              labelText: context.l10n.apiBaseUrl,
              hintText: 'https://api.openai.com/v1',
              prefixIcon: const Icon(Icons.link),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _apiKeyController,
            obscureText: _obscureKey,
            decoration: InputDecoration(
              labelText: context.l10n.apiKey,
              hintText: 'sk-...',
              prefixIcon: const Icon(Icons.key),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureKey ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () => setState(() => _obscureKey = !_obscureKey),
              ),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: _saveApiSettings,
            icon: const Icon(Icons.save),
            label: Text(context.l10n.saveApiSettings),
          ),
          const Divider(height: 32),
          // General settings
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(context.l10n.language),
            trailing: Text(
              langName,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
            onTap: _changeLanguage,
          ),
          ListTile(
            leading: const Icon(Icons.account_balance),
            title: Text(context.l10n.madhab),
            trailing: FutureBuilder(
              future: ref.read(userPreferencesProvider.future),
              builder: (context, snap) => Text(
                snap.data?.madhab.displayName ?? '',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.primary,
                ),
              ),
            ),
            onTap: _changeMadhab,
          ),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: Text(context.l10n.notifications),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(context.l10n.about),
          ),
          if (kDebugMode) ...[
            const Divider(height: 32),
            Text(
              'Debug',
              style: context.textTheme.titleSmall?.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.restart_alt),
              title: const Text('Replay onboarding'),
              subtitle: const Text(
                'Resets the onboarding flag and returns to the welcome screen',
              ),
              onTap: _replayOnboarding,
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _replayOnboarding() async {
    final prefs = await ref.read(userPreferencesProvider.future);
    prefs.onboardingComplete = false;
    ref.invalidate(userPreferencesProvider);
    if (mounted) context.go('/onboarding');
  }
}
