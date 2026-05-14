import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/home_navigation_provider.dart';
import '../../widgets/nav_bar.dart';
import 'sections/hero_section.dart';
import 'sections/trust_bar_section.dart';
import 'sections/services_section.dart';
import 'sections/projects_section.dart';
import 'sections/why_us_section.dart';
import 'sections/tech_stack_section.dart';
import 'sections/process_section.dart';
import 'sections/testimonials_section.dart';
import 'sections/about_section.dart';
import 'sections/faq_section.dart';
import 'sections/contact_section.dart';
import 'sections/footer_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<HomeNavigationProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: navProvider.scrollController,
            child: Column(
              children: [
                const SizedBox(height: 72),
                HeroSection(key: navProvider.sectionKeys['hero']),
                const TrustBarSection(),
                ServicesSection(key: navProvider.sectionKeys['services']),
                ProjectsSection(key: navProvider.sectionKeys['work']),
                const WhyUsSection(),
                const TechStackSection(),
                ProcessSection(key: navProvider.sectionKeys['process']),
                TestimonialsSection(key: navProvider.sectionKeys['testimonials']),
                AboutSection(key: navProvider.sectionKeys['about']),
                const FAQSection(),
                ContactSection(key: navProvider.sectionKeys['contact']),
                const FooterSection(),
              ],
            ),
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(),
          ),
        ],
      ),
    );
  }
}
