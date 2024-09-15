import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:frontend/core/style/text_styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart'; // Importa o url_launcher

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isHoveredPlataforma = false;
  bool isHoveredJupAbtra = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final isMobile = screenWidth < 600;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'DEMONSTRAÇÃO',
                style: GoogleFonts.poppins(
                  textStyle: context.appTextStyles.smallGrey,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Escolha a visão que você quer ver',
                style: GoogleFonts.poppins(
                  textStyle: context.appTextStyles.bigBlack,
                ),
              ),
              const SizedBox(height: 32),
              isMobile
                  ? Column(
                      children: [
                        _buildOptionCard(
                          context,
                          title: 'Plataforma',
                          description:
                              'Veja a visão completa da nossa plataforma.',
                          isHovered: isHoveredPlataforma,
                          onHover: (hovering) {
                            setState(() {
                              isHoveredPlataforma = hovering;
                            });
                          },
                          onTap: (){},
                          width: screenWidth * 0.85,
                          height: 240,
                        ),
                        const SizedBox(height: 16),
                        _buildOptionCard(
                          context,
                          title: 'JUP ABTRA',
                          description:
                              'Veja a visão completa da JUP Abtra com os novos dados obtidos com a nossa API.',
                          isHovered: isHoveredJupAbtra,
                          onHover: (hovering) {
                            setState(() {
                              isHoveredJupAbtra = hovering;
                            });
                          },
                          onTap: () async {
                            const url = 'https://jup-abtra.vercel.app';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          width: screenWidth * 0.85,
                          height: 240,
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildOptionCard(
                          context,
                          title: 'Plataforma',
                          description:
                              'Veja a visão completa da nossa plataforma.',
                          isHovered: isHoveredPlataforma,
                          onHover: (hovering) {
                            setState(() {
                              isHoveredPlataforma = hovering;
                            });
                          },
                          onTap: () => Modular.to.navigate("platform"),
                          width: screenWidth * 0.4,
                          height: 326,
                        ),
                        const SizedBox(width: 60),
                        _buildOptionCard(
                          context,
                          title: 'JUP ABTRA',
                          description:
                              'Veja a visão completa da JUP Abtra com os novos dados obtidos com a nossa API.',
                          isHovered: isHoveredJupAbtra,
                          onHover: (hovering) {
                            setState(() {
                              isHoveredJupAbtra = hovering;
                            });
                          },
                          onTap: () async {
                            const url = 'https://jup-abtra.vercel.app';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          width: screenWidth * 0.4,
                          height: 326,
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(
    BuildContext context, {
    required String title,
    required String description,
    required bool isHovered,
    required ValueChanged<bool> onHover,
    required void Function() onTap,
    required double width,
    required double height,
  }) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          alignment: Alignment.center,
          width: width,
          height: isHovered ? height + 20 : height,
          decoration: BoxDecoration(
            color: isHovered ? Colors.grey[200] : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: isHovered ? Colors.black45 : Colors.black12,
                blurRadius: isHovered ? 20 : 10,
                spreadRadius: isHovered ? 5 : 2,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  textStyle: context.appTextStyles.bigBlack.copyWith(
                    color: isHovered ? const Color(0xFF07598F) : Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: width * 0.7,
                child: Text(
                  description,
                  style: GoogleFonts.poppins(
                    textStyle: context.appTextStyles.smallGrey.copyWith(
                      color: isHovered ? const Color(0xFF07598F) : Colors.grey,
                    ),
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
