import 'package:flutter/material.dart';
import 'package:music_app/const/colors.dart';

import 'common widget/myappbar.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mybackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Myappbar(title: 'Privacy Policy', trailing: const SizedBox()),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: privacypolicy(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget privacypolicy() {
  return const Text(
    '''    At [Your Music App Name], we are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy explains how we collect, use, disclose, and safeguard your personal data when you use our music app. By using our app, you consent to the practices described in this policy.

Information We Collect
1.1 Personal Information: When you sign up for our app, we may collect certain personal information such as your name, email address, username, and profile picture. We may also collect information you provide to us when you contact our support team or participate in surveys or contests.

1.2 Usage Information: We may collect information about your interactions with the app, including the songs you listen to, playlists you create, and artists you follow. This data helps us personalize your music recommendations and improve our services.

1.3 Device Information: We may collect information about your device, including the device type, operating system, unique device identifiers, and mobile network information. This information helps us optimize and troubleshoot our app for different devices and platforms.

1.4 Log Data: Our servers automatically record certain information when you use the app, such as your IP address, app crashes, and usage statistics. This data is used for analyzing trends, administering the app, and ensuring its security.

How We Use Your Information
2.1 Provide and Improve our Services: We use the collected information to provide and improve our music app, personalize your music experience, develop new features, and enhance app performance.

2.2 Communications: We may use your email address to send you important updates, newsletters, marketing promotions, and information about new features. You can opt-out of receiving such communications at any time.

2.3 Analytics and Aggregated Data: We may use your information for analytics purposes to understand app usage patterns, trends, and user preferences. This data is anonymized and aggregated, ensuring that it cannot be linked back to individual users.

Information Sharing and Disclosure
3.1 Third-Party Service Providers: We may engage third-party service providers to perform functions on our behalf, such as hosting, data storage, analytics, and customer support. These providers are contractually bound to protect your information and may only use it for the specified purposes.

3.2 Legal Requirements: We may disclose your information to comply with applicable laws, regulations, or legal processes, or in response to valid governmental requests.

Data Security
We implement appropriate technical and organizational measures to protect your personal information from unauthorized access, disclosure, alteration, or destruction. However, no method of transmission over the internet or electronic storage is 100% secure, and we cannot guarantee absolute security.

Children's Privacy
Our music app is not intended for children under the age of 13. We do not knowingly collect personal information from children. If you believe that we may have collected information from a child, please contact us, and we will take appropriate measures to remove the information from our systems.

Changes to this Privacy Policy
We may update this Privacy Policy from time to time to reflect changes in our practices or legal obligations. We encourage you to review this page periodically for any updates. Your continued use of the app after the changes are posted constitutes your acceptance of the revised Privacy Policy.

Contact Us
If you have any questions or concerns about our Privacy Policy or the privacy practices of our music app, please contact us at [contact email]. We will strive to address your inquiries and resolve any issues promptly.

Last updated: [Date]

Note: This is a general template for a privacy policy and may need to be customized to fit the specific practices and requirements of your music app. It is important to consult with legal professionals to ensure compliance with applicable privacy           ''',
    style: TextStyle(letterSpacing: 5, color: Colors.white, fontSize: 15),
  );
}
