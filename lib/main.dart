import 'package:flutter/material.dart';
import 'package:lifecoach/di/injector.dart';
import 'package:lifecoach/ui/app/app.dart';

/// The [main] is the ultimate detail — the lowest-level policy.
/// It is the initial entry point of the system.
/// Nothing, other than the operating system, depends on it.
/// Here we should [injectDependencies] by a dependency injection framework.
/// The [main] is a dirty low-level module in the outermost circle of the onion
/// architecture.
/// Think of [main] as a plugin to the [LifeCoachingAiApp] — a plugin that sets
/// up the initial conditions and configurations, gathers all the outside
/// resources, and then hands control over to the high-level policy of the
/// [LifeCoachingAiApp].
/// When [main] is released, it has utterly no effect on any of the other
/// components in the system. They don’t know about [main], and they don’t care
/// when it changes.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  injectDependencies();

  runApp(const App());
}
