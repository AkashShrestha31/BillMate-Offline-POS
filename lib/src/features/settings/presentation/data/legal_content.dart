import 'package:hotel/src/features/settings/presentation/pages/legal_document_page.dart';

/// Privacy Policy and Terms of Service copy for Settings → Privacy & Policies.
abstract final class LegalContent {
  static const lastUpdatedLabel = 'Last updated: June 4, 2026';

  static List<LegalSection> privacyPolicy(String appName) => [
    LegalSection(
      title: '1. Introduction',
      paragraphs: [
        '$appName ("we", "our", or "us") provides business management software '
            'for hotels, restaurants, and similar operations. This Privacy Policy '
            'explains how we handle information when you use the $appName mobile '
            'application and related services.',
        'By using $appName, you agree to the practices described here. If you do '
            'not agree, please do not use the app.',
      ],
    ),
    LegalSection(
      title: '2. Information we collect',
      paragraphs: [
        'The information we process depends on how you use $appName:',
      ],
      bullets: [
        'Account and profile: name, email address, password (stored securely on your device), role, and organization details you provide during setup or employee records.',
        'Business data: invoices, sales and purchase records, parties (customers and suppliers), items, stock counts, payments, expenses, reports, and notes you enter in the app.',
        'Device and usage: app version, device type, and diagnostic data used to improve stability (for example, crash or performance logs if enabled).',
        'Optional sync: if your administrator configures server sync, business data may be transmitted to your organization\'s backend when you run sync.',
        'Support: information you send when you contact support or report a problem.',
      ],
    ),
    LegalSection(
      title: '3. How we use information',
      paragraphs: [
        'We use information to:',
      ],
      bullets: [
        'Operate core features such as invoicing, inventory, parties, payments, dashboards, and reports.',
        'Keep you signed in and associate activity with your organization.',
        'Store data locally on your device for offline use.',
        'Sync with a server when you or your administrator requests it.',
        'Improve the app, fix errors, and comply with legal obligations.',
      ],
    ),
    LegalSection(
      title: '4. Local storage and offline use',
      paragraphs: [
        '$appName is designed to work offline-first. Most business data is stored '
            'in a local database on your device. We do not upload your books to our '
            'servers unless you use optional sync or other features your administrator enables.',
        'You are responsible for securing the device (screen lock, backups, and who '
            'can access the app). Logging out reduces the risk of unauthorized access on a shared device.',
      ],
    ),
    LegalSection(
      title: '5. Optional cloud sync and third parties',
      paragraphs: [
        'If sync is enabled, data is sent to endpoints configured by your organization. '
            'That processing is controlled by your organization and its hosting provider, not only by us.',
        'We may use service providers (for example, analytics, crash reporting, or '
            'app update services) that process limited technical data under their own policies. '
            'We do not sell your personal information.',
      ],
    ),
    LegalSection(
      title: '6. Data retention',
      paragraphs: [
        'Data remains on your device until you delete it, clear app data, uninstall the app, '
            'or your organization removes it through sync or administration.',
        'Backup or export files (such as PDF credentials or reports you share) are your '
            'responsibility to store safely.',
      ],
    ),
    LegalSection(
      title: '7. Security',
      paragraphs: [
        'We use reasonable technical measures to protect data in the app, including '
            'secure local storage where supported by your device. No method of storage or '
            'transmission is completely secure; you should use strong passwords and keep devices updated.',
      ],
    ),
    LegalSection(
      title: '8. Your rights and choices',
      paragraphs: [
        'Depending on your location, you may have rights to access, correct, delete, or '
            'restrict certain processing of your personal information.',
        'You can update profile details in the app where available, log out, or contact '
            'your organization administrator. For requests directed to us, use the contact details below.',
      ],
    ),
    LegalSection(
      title: '9. Children',
      paragraphs: [
        '$appName is intended for business use and is not directed at children under 16. '
            'We do not knowingly collect personal information from children.',
      ],
    ),
    LegalSection(
      title: '10. Changes to this policy',
      paragraphs: [
        'We may update this Privacy Policy from time to time. We will post the revised '
            'version in the app and update the "Last updated" date. Continued use after changes '
            'means you accept the updated policy.',
      ],
    ),
    LegalSection(
      title: '11. Contact us',
      paragraphs: [
        'For privacy questions or requests, contact your organization administrator '
            'or reach us through the Contact support option in Help & Support.',
      ],
    ),
  ];

  static List<LegalSection> termsOfService(String appName) => [
    LegalSection(
      title: '1. Acceptance of terms',
      paragraphs: [
        'These Terms of Service ("Terms") govern your use of the $appName mobile '
            'application and related services (collectively, the "Service").',
        'By installing, accessing, or using the Service, you agree to these Terms. '
            'If you use the Service on behalf of an organization, you represent that you '
            'have authority to bind that organization.',
      ],
    ),
    LegalSection(
      title: '2. Description of the service',
      paragraphs: [
        '$appName helps you manage business operations such as sales and purchase '
            'invoices, parties, items, stock, payments, expenses, cash summaries, and reports. '
            'Features may vary by role, organization settings, and app version.',
      ],
    ),
    LegalSection(
      title: '3. Accounts and access',
      paragraphs: [
        'You must provide accurate information during setup and keep login credentials confidential.',
        'You are responsible for all activity under your account. Notify your administrator '
            'immediately if you suspect unauthorized access.',
        'We may suspend or restrict access if we reasonably believe these Terms were violated '
            'or the Service is being misused.',
      ],
    ),
    LegalSection(
      title: '4. Acceptable use',
      paragraphs: [
        'You agree not to:',
      ],
      bullets: [
        'Use the Service for unlawful purposes or in violation of applicable tax, accounting, or trade laws.',
        'Attempt to reverse engineer, disrupt, or overload the Service except as permitted by law.',
        'Upload malicious code or interfere with other users\' data.',
        'Misrepresent invoices, payments, or records in a fraudulent manner.',
        'Share login credentials with unauthorized persons.',
      ],
    ),
    LegalSection(
      title: '5. Your business data',
      paragraphs: [
        'You retain ownership of business data you enter. You grant us a limited license '
            'to process that data solely to provide and improve the Service, including local '
            'storage and optional sync you initiate.',
        'You are solely responsible for the accuracy of invoices, tax calculations, inventory '
            'figures, and compliance with laws applicable to your business. $appName is a tool; '
            'it does not replace professional accounting or legal advice.',
      ],
    ),
    LegalSection(
      title: '6. Offline operation and sync',
      paragraphs: [
        'The Service may function without an internet connection after initial setup. '
            'Data is stored on your device. Optional sync may send data to servers configured '
            'by your organization; sync failures do not excuse your obligation to maintain '
            'accurate records locally.',
      ],
    ),
    LegalSection(
      title: '7. Disclaimers',
      paragraphs: [
        'THE SERVICE IS PROVIDED "AS IS" AND "AS AVAILABLE" WITHOUT WARRANTIES OF ANY KIND, '
            'WHETHER EXPRESS OR IMPLIED, INCLUDING MERCHANTABILITY, FITNESS FOR A PARTICULAR '
            'PURPOSE, AND NON-INFRINGEMENT.',
        'We do not warrant that the Service will be uninterrupted, error-free, or that data '
            'will never be lost. You should maintain backups appropriate for your business.',
      ],
    ),
    LegalSection(
      title: '8. Limitation of liability',
      paragraphs: [
        'TO THE MAXIMUM EXTENT PERMITTED BY LAW, WE AND OUR SUPPLIERS SHALL NOT BE LIABLE '
            'FOR ANY INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL, OR PUNITIVE DAMAGES, OR FOR '
            'LOSS OF PROFITS, DATA, OR GOODWILL, ARISING FROM YOUR USE OF THE SERVICE.',
        'OUR TOTAL LIABILITY FOR ANY CLAIM RELATED TO THE SERVICE SHALL NOT EXCEED THE '
            'AMOUNT YOU PAID US FOR THE SERVICE IN THE TWELVE (12) MONTHS BEFORE THE CLAIM, '
            'OR ONE HUNDRED US DOLLARS (USD 100) IF NO FEES WERE PAID, WHICHEVER IS GREATER.',
      ],
    ),
    LegalSection(
      title: '9. Intellectual property',
      paragraphs: [
        'The Service, including software, design, and branding, is owned by us or our '
            'licensors and protected by intellectual property laws. These Terms do not grant '
            'you rights to our trademarks except as needed to use the Service.',
      ],
    ),
    LegalSection(
      title: '10. Termination',
      paragraphs: [
        'You may stop using the Service at any time by uninstalling the app or logging out. '
            'We may discontinue or modify features with reasonable notice where practicable.',
        'Sections that by nature should survive termination (including disclaimers, '
            'limitation of liability, and governing law) will survive.',
      ],
    ),
    LegalSection(
      title: '11. Changes to terms',
      paragraphs: [
        'We may update these Terms. The updated version will be available in the app with '
            'a revised "Last updated" date. Your continued use after changes constitutes acceptance.',
      ],
    ),
    LegalSection(
      title: '12. Premium and in-app purchases',
      paragraphs: [
        '$appName offers optional Premium features through in-app purchases '
            'on the Apple App Store and Google Play, including monthly and yearly '
            'auto-renewing subscriptions and a one-time lifetime purchase.',
        'Payment is processed by Apple or Google, not directly by us. Prices are '
            'shown in the app before you confirm a purchase.',
      ],
      bullets: [
        'Subscriptions renew automatically unless you cancel at least 24 hours before the end of the current billing period.',
        'Manage or cancel subscriptions in your device account settings (Apple ID → Subscriptions, or Google Play → Subscriptions).',
        'Lifetime purchases are charged once and do not renew.',
        'Use Restore purchases on the Premium screen if you reinstall the app or change devices.',
        'Refunds are handled by Apple or Google according to their policies; we cannot issue refunds directly.',
        'Premium unlocks features described on the paywall; free-tier limits may apply without Premium.',
      ],
    ),
    LegalSection(
      title: '13. Governing law',
      paragraphs: [
        'These Terms are governed by the laws applicable in your place of business, '
            'without regard to conflict-of-law rules, unless mandatory local law requires otherwise.',
        'Disputes should first be raised with your organization administrator or through '
            'Contact support in the app.',
      ],
    ),
    LegalSection(
      title: '14. Contact',
      paragraphs: [
        'Questions about these Terms may be sent through Contact support under Help & Support in the app.',
      ],
    ),
  ];

  static String privacyIntro(String appName) =>
      'This policy describes how $appName handles information when you manage your business on this device.';

  static String termsIntro(String appName) =>
      'Please read these terms carefully before using $appName. They form a binding agreement between you and us regarding use of the app.';
}
