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
    id: 'supplix',
    title: 'Supplix',
    tagline: 'Full business ecosystem platform for modern enterprises',
    description:
        'A comprehensive business management ecosystem featuring a Flutter client app, admin app, marketing website, and a Windows/Linux desktop admin panel — all backed by a Spring Boot microservice backend.',
    techStack: ['Flutter', 'Spring Boot', 'PostgreSQL', 'REST APIs', 'Desktop'],
    categories: ['Mobile Apps', 'Full Stack', 'Startup MVP'],
    overview:
        'Supplix is a complete digital business platform built from the ground up. It covers every layer of a business operation — customer-facing mobile app, internal admin mobile app, a marketing website, and a cross-platform desktop admin panel for Windows and Linux.',
    problem:
        'Businesses needed a unified ecosystem to manage clients, operations, and internal administration without juggling multiple disconnected tools and platforms.',
    solution:
        'Designed and developed an integrated ecosystem: a Flutter client app for end users, a Flutter admin app for field managers, a marketing website, and a Flutter desktop admin panel — all communicating with a robust Spring Boot + PostgreSQL backend.',
    features: [
      'Flutter client app for end users (Android & iOS)',
      'Flutter admin mobile app for managers',
      'Marketing website for brand presence',
      'Desktop admin panel for Windows & Linux',
      'Spring Boot REST API backend',
      'PostgreSQL database with relational data modeling',
      'Role-based access control across all platforms',
      'Real-time data sync across client and admin interfaces',
    ],
    architecture:
        'Multi-platform Flutter apps sharing a common design system. Spring Boot REST API with JWT authentication. PostgreSQL for relational data persistence. Desktop app built with Flutter targeting Windows and Linux.',
    results:
        'Delivered a production-ready, multi-platform business ecosystem. Unified 4 separate products under one backend, enabling consistent data flow and drastically reducing operational overhead.',
  ),
  Project(
    id: 'grocery-app',
    title: 'Grocery App',
    tagline: 'Smart grocery shopping and delivery application',
    description:
        'A grocery shopping and delivery app with intuitive product browsing, cart management, and a smooth ordering system — built for fast, reliable everyday use.',
    techStack: ['Flutter', 'Firebase', 'Firestore', 'Firebase Auth'],
    categories: ['Mobile Apps', 'Firebase'],
    overview:
        'A feature-rich grocery delivery application that simplifies the daily shopping experience. Users can browse categories, search products, manage their cart, and place orders with real-time status tracking.',
    problem:
        'Shoppers needed a fast, friction-free mobile app to browse local grocery inventory and place delivery orders without the complexity of large marketplace apps.',
    solution:
        'Built a clean Flutter app with a category-driven product catalog, smart search, a persistent cart powered by Firebase, and a streamlined checkout flow. Firebase enabled real-time order updates without heavy backend setup.',
    features: [
      'Category and sub-category product browsing',
      'Smart product search with filtering',
      'Persistent shopping cart with quantity management',
      'Seamless checkout and order placement',
      'Real-time order status tracking',
      'Firebase Auth for secure user accounts',
      'Order history and reordering',
    ],
    architecture:
        'Flutter with Provider for state management. Firebase Firestore for product catalog and order management. Firebase Auth for user authentication. Cloud Functions for order notifications.',
    results:
        'Delivered a production-ready grocery app with real-time sync. Smooth UI achieved sub-2-second load times for product listings across catalog pages.',
  ),
  Project(
    id: 'voucher-vault',
    title: 'Voucher Vault',
    tagline: 'Discover and save the best offers in one place',
    description:
        'An offer and coupon collection platform that aggregates deals from websites and apps, giving users a single hub to discover, save, and redeem discounts.',
    techStack: ['Flutter', 'Firebase', 'REST APIs', 'API Integration'],
    categories: ['Mobile Apps', 'Firebase'],
    overview:
        'Voucher Vault is a deal aggregation app that pulls coupons and offers from multiple sources via API integrations, presenting them in a clean, browsable UI. Users can bookmark deals, filter by category, and access redemption links instantly.',
    problem:
        'Consumers waste time hunting for valid coupons across dozens of websites and apps. There was no single, clean mobile platform to discover and access the best active deals.',
    solution:
        'Built a Flutter app that aggregates deals via external APIs and Firebase-stored promotions. A smart categorization system and search help users quickly find relevant offers, while bookmarking ensures their favourite deals are always accessible.',
    features: [
      'Aggregated deals from websites and apps via APIs',
      'Category-based coupon browsing',
      'Smart search and filtering by brand or discount',
      'Bookmark and save favourite offers',
      'One-tap redemption link access',
      'Expiry tracking with deal validity indicators',
      'Push notifications for new deals in saved categories',
    ],
    architecture:
        'Flutter with Riverpod for reactive state management. Firebase Firestore for curated deal storage. External coupon/offer APIs integrated via a REST layer. Firebase Cloud Messaging for deal notifications.',
    results:
        'Aggregated 500+ active deals at launch. Delivered a clean browsing experience with instant search across all categories and integrated push notification system.',
  ),
  Project(
    id: 'shopapp',
    title: 'ShopApp',
    tagline: 'Premium e-commerce shopping experience inspired by Amazon',
    description:
        'A full-featured e-commerce app inspired by Amazon and Flipkart, with product listings, cart management, order placement, and a polished shopping experience.',
    techStack: ['Flutter', 'Firebase', 'Provider', 'Firebase Auth'],
    categories: ['Mobile Apps', 'Firebase', 'UI/UX'],
    overview:
        'ShopApp is a premium e-commerce mobile application that brings the big-marketplace experience to a clean, fast Flutter app. Features include rich product listings, search, cart, and a full checkout to order management flow.',
    problem:
        'Building a scalable, feature-complete e-commerce app that matches the functionality expectations of users familiar with Amazon and Flipkart while keeping the codebase clean and maintainable.',
    solution:
        'Designed a modular Flutter architecture with Provider for cart and user state. Firebase powers the product catalog, orders, and auth. The UI focuses on conversion — fast browsing, clear CTAs, and a frictionless checkout.',
    features: [
      'Rich product listing with images and ratings',
      'Smart search with category filters',
      'Wishlist and persistent cart',
      'Secure checkout and order placement',
      'Order tracking and history',
      'User profile and address management',
      'Firebase Auth with email & social login',
    ],
    architecture:
        'Flutter with Provider for cart, wishlist, and auth state. Firebase Firestore for products and orders. Firebase Auth for user management. Firebase Storage for product images.',
    results:
        'Delivered a polished, production-ready shopping app. Clean architecture enables easy addition of new product categories and payment gateways with minimal code changes.',
  ),
  Project(
    id: 'expense-tracker',
    title: 'Expense Tracker',
    tagline: 'Smart expense management with visual budget insights',
    description:
        'A personal finance app for tracking spending, setting budgets, and visualising where money goes — designed for clarity and daily use.',
    techStack: ['Flutter', 'Firebase', 'Firestore', 'Charts'],
    categories: ['Mobile Apps', 'Firebase'],
    overview:
        'Expense Tracker helps users take control of their finances by logging expenses, categorising spending, and tracking budgets against actual spend. Visual charts make financial patterns easy to understand at a glance.',
    problem:
        'Most people lack visibility into their daily spending patterns. Manual tracking in spreadsheets is tedious, and existing apps are either too complex or lack insightful visualisations.',
    solution:
        'Built an intuitive Flutter app where adding an expense takes seconds. Firebase syncs data across devices. Pie charts and bar graphs give instant visual feedback on spending categories and monthly trends.',
    features: [
      'Quick expense logging with categories and notes',
      'Budget setting per category with overspend alerts',
      'Visual spending breakdowns (pie & bar charts)',
      'Monthly and weekly expense summaries',
      'Transaction history with search and filter',
      'Firebase sync across multiple devices',
      'Export expense reports',
    ],
    architecture:
        'Flutter with Provider/ChangeNotifier for expense state. Firebase Firestore for real-time cloud sync of transactions and budgets. FL Chart library for data visualisation.',
    results:
        'Users reported a measurable improvement in budget awareness within the first week of use. Clean UX reduced expense logging time to under 5 seconds per entry.',
  ),
  Project(
    id: 'motogenie',
    title: 'MotoGenie',
    tagline: 'Smart vehicle management for bikes and scooties',
    description:
        'A vehicle management app tailored for bike and scooty owners, helping them track service history, fuel logs, and maintenance reminders in one place.',
    techStack: ['Flutter', 'Firebase', 'Firestore', 'Firebase Auth'],
    categories: ['Mobile Apps', 'Firebase'],
    overview:
        'MotoGenie is a dedicated vehicle companion app for two-wheeler owners. It helps users log fuel fill-ups, track servicing history, set maintenance reminders, and monitor vehicle health — all from a clean mobile interface.',
    problem:
        'Two-wheeler owners often lose track of service dates, fuel costs, and maintenance schedules, leading to costly repairs and poor vehicle health. There was no dedicated, simple app targeting this specific segment.',
    solution:
        'Built MotoGenie with a focus on simplicity and daily utility. Users add their vehicle(s), log fuel and service entries with a few taps, and receive smart reminders before scheduled maintenance is due.',
    features: [
      'Multi-vehicle profile management',
      'Fuel log with mileage/efficiency tracking',
      'Service history with date and cost records',
      'Maintenance reminders with push notifications',
      'Expense summary by vehicle',
      'Firebase sync for cross-device access',
      'Clean, two-wheeler-focused UI',
    ],
    architecture:
        'Flutter with Provider for vehicle and log state management. Firebase Firestore for real-time data persistence. Firebase Cloud Messaging for maintenance reminders.',
    results:
        'Delivered a purpose-built vehicle management app with intuitive UX. Reminder system proactively notifies users before service is overdue, reducing missed maintenance events.',
  ),
  Project(
    id: 'nexus-forge',
    title: 'Nexus Forge',
    tagline: 'Community-building platform connecting people and ideas',
    description:
        'A community application that brings people together around shared interests, enabling discussions, collaboration, and connection in a structured, engaging environment.',
    techStack: ['Flutter', 'Firebase', 'Firestore', 'Firebase Auth'],
    categories: ['Mobile Apps', 'Firebase', 'Full Stack'],
    overview:
        'Nexus Forge is a community platform designed to foster meaningful connections. Users can join interest-based communities, participate in discussions, share content, and collaborate — all in a real-time, Firebase-powered environment.',
    problem:
        'Existing community platforms feel either too noisy (like large social networks) or too restrictive. There was a need for a focused, moderated space where communities could organically grow around specific interests.',
    solution:
        'Built a Flutter community app where users create or join focused groups, post discussions, and interact in real time. Firebase Firestore powers live feeds and messaging, while Auth ensures secure, identity-verified participation.',
    features: [
      'Interest-based community creation and joining',
      'Real-time discussion feeds with posts and comments',
      'User profiles with activity history',
      'Firebase-powered real-time updates',
      'Content moderation tools for community admins',
      'Push notifications for new activity',
      'Search and discover communities',
    ],
    architecture:
        'Flutter with Provider for community and feed state. Firebase Firestore for real-time community data. Firebase Auth for user identity. Cloud Functions for notification triggers and moderation workflows.',
    results:
        'Delivered a scalable community platform with real-time capabilities. Architecture supports thousands of concurrent users with Firestore\'s real-time listener model.',
  ),
  Project(
    id: 'support-system',
    title: 'Support System',
    tagline: 'Internal issue management platform for company teams',
    description:
        'An internal company support and issue management platform where employees can raise, track, and resolve company-related issues efficiently.',
    techStack: ['Node.js', 'Express.js', 'MongoDB', 'REST APIs'],
    categories: ['Full Stack', 'Dashboards'],
    overview:
        'A dedicated internal support platform that streamlines how employees raise and manage company issues. Built with a Node.js/Express backend and MongoDB, it provides a structured workflow for issue creation, assignment, tracking, and resolution.',
    problem:
        'Internal company issues were being reported over chat and email, making tracking, assignment, and resolution chaotic and inconsistent. Teams needed a structured system to manage issue lifecycles.',
    solution:
        'Built a web-based internal support platform with a Node.js/Express REST API backend and MongoDB for flexible data storage. Employees raise issues via a clean interface; managers assign, prioritise, and track resolution status in real time.',
    features: [
      'Issue creation with category, priority, and description',
      'Assignment workflow for managers and team leads',
      'Status tracking: Open → In Progress → Resolved',
      'Comment threads on each issue for discussion',
      'Dashboard with issue analytics and resolution metrics',
      'Role-based access (Employee, Manager, Admin)',
      'Email notifications on issue updates',
    ],
    architecture:
        'Node.js with Express.js for RESTful API. MongoDB for flexible document-based issue storage. JWT-based authentication with role-based access control. Nodemailer for email notifications.',
    results:
        'Reduced issue resolution time by organising and prioritising requests in a structured pipeline. Provided management with clear visibility into recurring problem areas via dashboard analytics.',
  ),
];
