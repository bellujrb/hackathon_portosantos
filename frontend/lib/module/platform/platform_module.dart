import 'package:flutter_modular/flutter_modular.dart';
import 'package:frontend/module/platform/presenter/screens/help_desk_info_screen.dart';
import 'package:frontend/module/platform/presenter/screens/platform_screen.dart';
import 'package:frontend/module/platform/presenter/screens/ticket_screen.dart';
import 'package:frontend/module/platform/presenter/screens/welcome_screen.dart';

class PlatformModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => const WelcomeScreen()),
    ChildRoute('/platform', child: (context, args) => const PlatformScreen()),
    ChildRoute('/help-desk-info', child: (context, args) => const HelpDeskInfoScreen()),
    ChildRoute('/ticket-screen', child: (context, args) => const TicketScreen())
  ];
}