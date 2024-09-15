import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:frontend/core/components/svg_custom.dart';
import 'package:frontend/core/constants/constants_exports.dart';
import 'package:frontend/core/style/colors.dart';
import 'package:frontend/core/style/text_styles.dart';
import 'package:frontend/module/platform/presenter/widgets/info_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PlatformScreen extends StatefulWidget {
  const PlatformScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PlatformScreenState createState() => _PlatformScreenState();
}

class _PlatformScreenState extends State<PlatformScreen> {
  int _selectedIndex = 0;

  final List<_PieData> chamadosResolvidosData = [
    _PieData('Falha API', 2, Colors.black),
    _PieData('Data Incompleta', 22.5, Colors.greenAccent),
    _PieData('Dados Corrompidos', 30.8, Color(0xFF07598F)),
  ];

  final List<_BarData> chamadosPorDispositivo = [
    _BarData('Operações', 32, Colors.purpleAccent),
    _BarData('TI', 4, Colors.greenAccent),
    _BarData('Gestor de Dados', 25, Colors.black),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Modular.to.navigate('/'); 
        break;
      case 1:
        Modular.to.navigate('ticket-screen');
        break;
      case 2:
        Modular.to.navigate('settings');
        break;
      case 3:
        Modular.to.navigate('/');
        break;
      default:
        Modular.to.navigate('/');
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
                  icon: Icons.logout,
                  label: 'Logout',
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Geral',
                    style: GoogleFonts.poppins(
                        textStyle: context.appTextStyles.mediumBlack),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildKPIComparativeContainer(
                          "Chamados Resolvidos", "87%", "+12%", Colors.green),
                      const SizedBox(
                        width: 20,
                      ),
                      _buildKPIComparativeContainer("Tempo Médio de Resolução",
                          "45 min", "-5%", Colors.red),
                      const SizedBox(
                        width: 20,
                      ),
                      _buildKPIComparativeContainer(
                          "Falhas na API", "7%", "-2%", Colors.red),
                      const SizedBox(
                        width: 20,
                      ),
                      _buildKPIComparativeContainer(
                          "Satisfação do Cliente", "92%", "+5%", Colors.green),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Help Desk',
                    style: GoogleFonts.poppins(
                        textStyle: context.appTextStyles.mediumBlack),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Modular.to.navigate("help-desk-info"),
                        child: const InfoCard(
                          title: 'MAIPO',
                          infoIncompleta: 4,
                          falhaApi: true,
                          viagem: '3675 / 2024',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Gráficos de Desempenho',
                    style: GoogleFonts.poppins(
                        textStyle: context.appTextStyles.mediumBlack),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.black.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chamados resolvidos por dia',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildPieChart(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.black.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chamados por Função',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildBarChart(),
                      ],
                    ),
                  ),
                ],
              ),
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
          tileColor: isSelected ? Color(0xFF07598F) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildPieChart() {
    return SfCircularChart(
      legend: const Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
        position: LegendPosition.right,
      ),
      series: <CircularSeries>[
        DoughnutSeries<_PieData, String>(
          dataSource: chamadosResolvidosData,
          xValueMapper: (_PieData data, _) => data.category,
          yValueMapper: (_PieData data, _) => data.value,
          pointColorMapper: (_PieData data, _) => data.color,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          innerRadius: '70%', 
        ),
      ],
    );
  }

  Widget _buildBarChart() {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      series: <ChartSeries>[
        ColumnSeries<_BarData, String>(
          dataSource: chamadosPorDispositivo,
          xValueMapper: (_BarData data, _) => data.device,
          yValueMapper: (_BarData data, _) => data.usage,
          pointColorMapper: (_BarData data, _) => data.color,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}

class _PieData {
  _PieData(this.category, this.value, this.color);
  final String category;
  final double value;
  final Color color;
}

class _BarData {
  _BarData(this.device, this.usage, this.color);
  final String device;
  final double usage;
  final Color color;
}

Widget _buildKPIComparativeContainer(
    String title, String value, String percentage, Color changeColor) {
  return Container(
    height: 130,
    width: 200,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.black.withOpacity(0.05),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.black87,
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  percentage,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: changeColor,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.trending_up,
                  color: changeColor,
                  size: 18,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
