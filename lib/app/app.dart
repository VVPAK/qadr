import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../l10n/app_localizations.dart';

import '../core/providers/widget_service_provider.dart';
import 'providers.dart';
import 'router.dart';
import 'theme.dart';

class QadrApp extends ConsumerStatefulWidget {
  const QadrApp({super.key});

  @override
  ConsumerState<QadrApp> createState() => _QadrAppState();
}

class _QadrAppState extends ConsumerState<QadrApp> {
  late final AppLifecycleListener _lifecycleListener;

  @override
  void initState() {
    super.initState();
    _lifecycleListener = AppLifecycleListener(
      onResume: () => ref.read(widgetServiceProvider)?.update(),
    );
    // Update widget on first launch after preferences are available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(widgetServiceProvider)?.update();
    });
  }

  @override
  void dispose() {
    _lifecycleListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    final locale = ref.watch(localProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Qadr',
      debugShowCheckedModeBanner: false,
      theme: QadrTheme.light(),
      darkTheme: QadrTheme.dark(),
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}
