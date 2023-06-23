import 'package:flutter/material.dart';
import 'package:music_app/const/colors.dart';

import 'common widget/myappbar.dart';

class Terms extends StatelessWidget {
  const Terms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mybackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Myappbar(title: 'Terms and Conditions', trailing: const SizedBox()),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: conditions(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget conditions() {
  return const Text(
    '''   Please read these Terms and Conditions ("Terms") carefully before using our music app ("the App"). These Terms govern your use of the App and constitute a legally binding agreement between you and [Your Music App Name]. By using the App, you agree to be bound by these Terms.

Use of the App
1.1 Eligibility: You must be at least 13 years old to use the App. By using the App, you represent and warrant that you meet the eligibility requirements.

1.2 License: Subject to your compliance with these Terms, [Your Music App Name] grants you a limited, non-exclusive, non-transferable, and revocable license to use the App for personal, non-commercial purposes.

1.3 User Accounts: You may need to create a user account to access certain features of the App. You are responsible for maintaining the confidentiality of your account information and agree to be responsible for all activities that occur under your account.

1.4 Prohibited Activities: When using the App, you agree not to:

Violate any applicable laws or regulations.
Infringe upon the intellectual property rights of others.
Transmit any harmful, offensive, or unlawful content.
Interfere with the operation or security of the App.
Attempt to gain unauthorized access to the App or other user accounts.
Use the App for any commercial or promotional purposes without prior written consent from [Your Music App Name].
Content and Intellectual Property Rights
2.1 Ownership: The App and its content, including but not limited to text, graphics, user interfaces, visual interfaces, photographs, trademarks, logos, and audiovisual material, are owned or licensed by [Your Music App Name] and are protected by intellectual property laws.

2.2 User-Generated Content: By using the App, you may have the opportunity to submit or post user-generated content. You retain ownership of your user-generated content, but by submitting or posting it, you grant [Your Music App Name] a worldwide, royalty-free, perpetual, irrevocable, and sublicensable right to use, reproduce, modify, adapt, publish, translate, distribute, publicly perform, and display the content in connection with the App.

Privacy
Your privacy is important to us. Please refer to our Privacy Policy [insert link to Privacy Policy] for information on how we collect, use, and disclose your personal information in connection with the App.

Disclaimer of Warranties
The App is provided on an "as is" and "as available" basis. [Your Music App Name] makes no warranties or representations, express or implied, regarding the App's accuracy, reliability, completeness, or fitness for a particular purpose. You use the App at your own risk.

Limitation of Liability
To the maximum extent permitted by applicable law, [Your Music App Name] shall not be liable for any indirect, incidental, consequential, or punitive damages arising out of or related to your use or inability to use the App, even if advised of the possibility of such damages.

Modification and Termination
[Your Music App Name] reserves the right to modify, suspend, or terminate the App or your access to it, at any time without prior notice and for any reason. We may also update these Terms from time to time. Continued use of the App after such modifications constitutes your acceptance of the updated Terms.

Governing Law and Dispute Resolution
These Terms shall be governed by and construed in accordance with the laws of [Your Country/State]. Any dispute arising out of or in connection with these Terms shall be subject to the exclusive jurisdiction of the courts in [Your Jurisdiction].

Severability
If any provision of these Terms    ''',
    style: TextStyle(letterSpacing: 5, color: Colors.white, fontSize: 15),
  );
}
