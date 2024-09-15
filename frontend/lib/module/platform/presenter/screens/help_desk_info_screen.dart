import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:frontend/core/components/svg_custom.dart';
import 'package:frontend/core/constants/constants_exports.dart';
import 'package:frontend/core/style/colors.dart';
import 'package:frontend/core/style/text_styles.dart';
import 'package:frontend/module/platform/presenter/widgets/help_desk_card.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpDeskInfoScreen extends StatefulWidget {
  const HelpDeskInfoScreen({super.key});

  @override
  State<HelpDeskInfoScreen> createState() => _HelpDeskInfoScreenState();
}

class _HelpDeskInfoScreenState extends State<HelpDeskInfoScreen> {
  int _selectedIndex = 1; 
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>(); 

  List<String> incompleteData = []; 
  List<String> dataToSend = [ 
    'Lloyd: Informação de "Data de Atracação" está incompleta.',
    'Navio: Informação de "Operador" está faltando.',
    'Viagem: Informação de "Previsão de Atracação" está incorreta.',
    'Viagem: Informação de "Data de Desatracação" está incompleta.',
  ];

  @override
  void initState() {
    super.initState();
    _sendIncompleteData();
  }

  void _sendIncompleteData() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (dataToSend.isNotEmpty) {
        setState(() {
          incompleteData.add(dataToSend.removeAt(0));
        });
        _listKey.currentState?.insertItem(incompleteData.length - 1);
      } else {
        timer.cancel(); 
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Modular.to.navigate("platform");
        break;
      case 1:
        Modular.to.navigate("ticket-screen");
        break;
      case 2:
        Modular.to.navigate("settings");
        break;
      case 3:
        Modular.to.navigate("/");
        break;
      default:
        Modular.to.navigate("/");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 250,
            child: Column(
              children: [
                const DrawerHeader(
                  child: SvgCustom(svg: SvgEnum.logo, height: 108, width: 200),
                ),
                buildMenuItem(
                  index: 0,
                  icon: Icons.home,
                  label: 'Home',
                ),
                buildMenuItem(
                  index: 1,
                  icon: Icons.report,
                  label: 'Chamados',
                ),
                buildMenuItem(
                  index: 2,
                  icon: Icons.settings,
                  label: 'Configurações',
                ),
                buildMenuItem(
                  index: 3,
                  icon: Icons.help,
                  label: 'Logout',
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () => Modular.to.navigate("platform"),
                              child: Icon(
                                Icons.arrow_back,
                                size: 24,
                                color: AppColors.black,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              'Home / Help Desk / MAIPO',
                              style: GoogleFonts.poppins(
                                  textStyle: context.appTextStyles.smallGrey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const HelpDeskCard(
                          title: 'MAIPO',
                          infoIncompleta: 4,
                          falhaApi: true,
                          viagem: '3675 / 2024',
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Informações Incompletas',
                          style: GoogleFonts.poppins(
                            textStyle: context.appTextStyles.mediumBlack,
                          ),
                        ),
                        const SizedBox(height: 16),
                        AnimatedList(
                          key: _listKey, 
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          initialItemCount: incompleteData.length,
                          itemBuilder: (context, index, animation) {
                            return _buildAnimatedAlert(
                                incompleteData[index], animation);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () {
        _onItemTapped(index); 
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Icon(
            icon,
            color: isSelected ? Colors.white : Colors.grey,
          ),
          title: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
            ),
          ),
          tileColor:
              isSelected ? Color(0xFF07598F) : null, 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedAlert(String info, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: AlertIncompleteInfo(info: info),
        ),
      ),
    );
  }
}

class AlertIncompleteInfo extends StatelessWidget {
  final String info;
  const AlertIncompleteInfo({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.redAccent),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          const Icon(Icons.error, color: Colors.red),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              info,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
