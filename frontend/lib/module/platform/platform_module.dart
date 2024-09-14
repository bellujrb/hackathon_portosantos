import 'package:flutter_modular/flutter_modular.dart';
import 'package:frontend/module/platform/presenter/screens/platform_screen.dart';

class PlatformModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => const PlatformScreen()),
  ];
}