import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:frontend/core/components/svg_custom.dart';
import 'package:frontend/core/constants/constants_exports.dart';
import 'package:frontend/core/style/text_styles.dart';
import 'package:google_fonts/google_fonts.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  int _selectedIndex = 1; 
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  List<Map<String, dynamic>> ticketList = [];

  List<Map<String, dynamic>> alerts = [
    {
      'viagem': '3675 / 2024',
      'problema': 'Data de Atracação está incompleta.',
      'equipe': 'Operações',
      'tempo': '2h',
      'apsData': 'Previsão: 10:00, Autorização: 09:30',
      'abrtraData': 'Previsão: 09:45, Autorização: 09:40',
      'erro': 'Falha na API'
    },
    {
      'viagem': '2451 / 2023',
      'problema': 'Operador está faltando.',
      'equipe': 'TI',
      'tempo': '1h',
      'apsData': 'Operador: Não informado',
      'abrtraData': 'Operador: ABC Logística',
      'erro': 'Falha na Request'
    },
    {
      'viagem': '3871 / 2023',
      'problema': 'Previsão de Atracação incorreta.',
      'equipe': 'Operações',
      'tempo': '3h',
      'apsData': 'Previsão: 14:00, Autorização: 13:45',
      'abrtraData': 'Previsão: 13:30, Autorização: 13:50',
      'erro': 'Falha na Ingestão de Dados'
    },
  ];

  @override
  void initState() {
    super.initState();
    _generateTickets();
  }

  void _generateTickets() {
    Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (alerts.isNotEmpty) {
        setState(() {
          ticketList.add(alerts.removeAt(0));
        });
        _listKey.currentState?.insertItem(ticketList.length - 1);
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
                        Text(
                          'Tickets Gerados',
                          style: GoogleFonts.poppins(
                              textStyle: context.appTextStyles.mediumBlack),
                        ),
                        const SizedBox(height: 16),
                        AnimatedList(
                          key: _listKey,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          initialItemCount: ticketList.length,
                          itemBuilder: (context, index, animation) {
                            return _buildTicket(ticketList[index], animation);
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

  Widget _buildTicket(Map<String, dynamic> ticket, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: InkWell(
            onTap: () => _showTicketDetails(ticket),
            child: TicketCard(
              viagem: ticket['viagem'],
              problema: ticket['problema'],
              equipe: ticket['equipe'],
              tempo: ticket['tempo'],
              erro: ticket['erro'],
            ),
          ),
        ),
      ),
    );
  }

  void _showTicketDetails(Map<String, dynamic> ticket) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Detalhes do Ticket',
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(height: 16),
              Text(
                'Problema: ${ticket['problema']}',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'Número da Viagem: ${ticket['viagem']}',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dados APS:',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          ticket['apsData'],
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dados ABTRA:',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          ticket['abrtraData'],
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Erro: ${ticket['erro']}',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Fechar'),
              ),
            ],
          ),
        );
      },
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
              isSelected ? const Color(0xFF07598F) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class TicketCard extends StatelessWidget {
  final String viagem;
  final String problema;
  final String equipe;
  final String tempo;
  final String erro;

  const TicketCard({
    super.key,
    required this.viagem,
    required this.problema,
    required this.equipe,
    required this.tempo,
    required this.erro,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blueAccent),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.assignment_late, color: Colors.blueAccent),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Viagem: $viagem',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Problema: $problema',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Equipe Responsável: $equipe',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tempo Estimado de Correção: $tempo',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Erro: $erro',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 13,
                      color: Colors.redAccent,
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
}
