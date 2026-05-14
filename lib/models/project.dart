class Project {
  final String id;
  final String title;
  final String tagline;
  final String description;
  final List<String> techStack;
  final List<String> categories;
  final String overview;
  final String problem;
  final String solution;
  final List<String> features;
  final String architecture;
  final String results;

  const Project({
    required this.id,
    required this.title,
    required this.tagline,
    required this.description,
    required this.techStack,
    required this.categories,
    required this.overview,
    required this.problem,
    required this.solution,
    required this.features,
    required this.architecture,
    required this.results,
  });
}

const List<Project> kProjects = [
  Project(
    id: 'food-delivery',
    title: 'Swiggy-Style Food Delivery App',
    tagline: 'End-to-end food delivery platform with real-time tracking',
    description:
        'A full-scale food delivery platform with real-time tracking, complex state management, and a seamless user experience.',
    techStack: ['Flutter', 'Firebase', 'Google Maps API', 'Provider', 'Node.js'],
    categories: ['Mobile Apps', 'Firebase', 'Full Stack'],
    overview:
        'Built a production-grade food delivery application from the ground up, covering the full lifecycle — from user onboarding and restaurant discovery to real-time order tracking and payment integration.',
    problem:
        'Restaurant chains needed a scalable, branded mobile ordering platform with live order tracking without the dependency on third-party marketplaces that cut into margins.',
    solution:
        'Designed and developed a white-label Flutter app with Firebase Realtime Database for live order updates, Google Maps integration for delivery tracking, and a Stripe payment flow — all within an 8-week sprint.',
    features: [
      'Real-time GPS order tracking with Google Maps',
      'Multi-restaurant support with dynamic menus',
      'Stripe payment integration with saved cards',
      'Push notifications via Firebase Cloud Messaging',
      'Admin dashboard for order management',
      'Loyalty points and coupon system',
    ],
    architecture:
        'MVVM architecture using Provider for state management. Firebase Firestore for real-time data sync. Node.js microservice for payment processing. Cloud Functions for order lifecycle automation.',
    results:
        'Reduced order processing time by 35%. Achieved a 99.8% crash-free session rate. Successfully onboarded 5+ restaurant chains within the first month of launch.',
  ),
  Project(
    id: 'ai-saas-dashboard',
    title: 'AI SaaS Analytics Dashboard',
    tagline: 'Premium analytics platform with integrated AI insights',
    description:
        'A premium analytics dashboard integrating AI insights with modern data visualization for SaaS businesses.',
    techStack: ['Flutter Web', 'Dart', 'REST APIs', 'Firebase', 'Chart Libraries'],
    categories: ['AI SaaS', 'Dashboards', 'Flutter Web', 'Full Stack'],
    overview:
        'Designed and developed a multi-tenant SaaS analytics platform enabling business owners to monitor KPIs, generate AI-powered summaries, and make data-driven decisions through an intuitive dashboard.',
    problem:
        'SaaS companies were dealing with fragmented data across multiple tools. Founders needed a single unified dashboard that could surface critical business insights in real time without requiring a dedicated data analyst.',
    solution:
        'Built a Flutter Web application with a modular dashboard system, role-based access control, and integration with AI text-generation APIs to auto-summarize trends and anomalies in business data.',
    features: [
      'AI-powered trend summaries and anomaly detection',
      'Interactive charts with drill-down capability',
      'Multi-tenant architecture with RBAC',
      'CSV/PDF export for reports',
      'Real-time data refresh via WebSockets',
      'Customizable widget grid layout',
    ],
    architecture:
        'Flutter Web with a component-based widget system. REST API integration layer with caching. Firebase Auth for multi-tenant session management. AI summarization powered by external LLM API.',
    results:
        'Reduced reporting time by 60%. Dashboard adopted by 3 enterprise clients within the pilot phase. Received a Net Promoter Score of 72.',
  ),
  Project(
    id: 'restaurant-management',
    title: 'Restaurant Management MVP',
    tagline: 'End-to-end POS and management system for modern restaurants',
    description:
        'An end-to-end management system for modern restaurants including POS, inventory, and online ordering.',
    techStack: ['Flutter', 'Firebase', 'Node.js', 'PostgreSQL'],
    categories: ['Mobile Apps', 'Full Stack', 'Startup MVP'],
    overview:
        'Delivered a complete restaurant management MVP for a startup client in 6 weeks — covering table management, digital POS, real-time inventory tracking, and customer-facing ordering via QR codes.',
    problem:
        'A restaurant startup needed to go live quickly with a full-featured management system but had a limited budget and a tight launch deadline.',
    solution:
        'Leveraged Flutter for rapid cross-platform UI development and Firebase for zero-setup backend infrastructure, enabling an MVP delivery in 6 weeks that covered all core workflows.',
    features: [
      'Digital POS with split billing support',
      'Real-time inventory management with low-stock alerts',
      'QR code-based customer menu and ordering',
      'Staff management with role permissions',
      'Daily revenue and sales analytics',
      'Kitchen display system integration',
    ],
    architecture:
        'Flutter cross-platform app targeting Android tablets for POS use. Firebase Firestore for real-time data. Node.js server for complex billing logic and report generation. PostgreSQL for long-term data persistence.',
    results:
        'MVP launched in 6 weeks. Onboarded 3 restaurant locations at launch. Reduced order errors by 70% compared to manual processes.',
  ),
  Project(
    id: 'booking-platform',
    title: 'Scalable Booking Platform',
    tagline: 'Concurrent reservation system with enterprise-grade reliability',
    description: 'Scalable booking system handling concurrent reservations with high reliability.',
    techStack: ['Flutter', 'Spring Boot', 'PostgreSQL', 'Firebase'],
    categories: ['Mobile Apps', 'Full Stack', 'Firebase'],
    overview:
        'Architected and built a high-concurrency booking platform for a services business, handling simultaneous reservations without race conditions or double-bookings through a robust backend.',
    problem:
        'The client\'s existing booking system was experiencing double-booking issues and frequent downtime during peak hours, leading to customer complaints and revenue loss.',
    solution:
        'Redesigned the booking architecture using Spring Boot with optimistic locking at the database level to prevent race conditions. Built a clean Flutter frontend with a real-time availability calendar.',
    features: [
      'Real-time availability calendar with instant updates',
      'Concurrent booking protection via database locking',
      'Automated confirmation emails and reminders',
      'Dynamic pricing based on demand',
      'Admin portal for booking management',
      'Cancellation and rescheduling workflows',
    ],
    architecture:
        'Spring Boot REST API with PostgreSQL and optimistic locking for concurrency control. Flutter mobile + web frontend. Firebase for real-time calendar updates and push notifications.',
    results:
        'Zero double-booking incidents post-launch. System uptime reached 99.9%. Booking completion rate improved by 45% due to reduced friction.',
  ),
  Project(
    id: 'ecommerce-ui',
    title: 'Modern E-Commerce Platform',
    tagline: 'Premium e-commerce UI/UX with smooth microinteractions',
    description: 'A pixel-perfect, premium e-commerce platform with smooth microinteractions and a modern design system.',
    techStack: ['Flutter', 'Firebase', 'Stripe', 'Provider'],
    categories: ['Mobile Apps', 'UI/UX', 'Firebase'],
    overview:
        'Designed and developed a premium mobile e-commerce application with a focus on exceptional UI/UX, smooth animations, and a streamlined purchase flow that drives higher conversion.',
    problem:
        'The client\'s existing app had a high cart abandonment rate and poor user reviews related to the confusing navigation and slow checkout experience.',
    solution:
        'Rebuilt the app with a focus on design excellence — implementing smooth page transitions, instant product search with Algolia, and a one-tap checkout flow. Every interaction was optimized to reduce friction.',
    features: [
      'Instant product search with filters and sorting',
      'Wishlist and persistent cart across devices',
      'One-tap checkout with saved payments',
      'Animated product gallery with zoom',
      'Personalized product recommendations',
      'Order tracking with push notifications',
    ],
    architecture:
        'Flutter with custom animation layer using flutter_animate. Firebase as backend. Stripe for secure payment processing. Provider for cart and user state management.',
    results:
        'Cart abandonment reduced by 38%. Average session duration increased by 2.4 minutes. App Store rating improved from 3.2 to 4.7 stars.',
  ),
];
