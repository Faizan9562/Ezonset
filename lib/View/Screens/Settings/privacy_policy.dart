import "package:flutter/material.dart";

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("assets/dashboard/privacy.png"),
              ),
            ),
            Expanded(
              flex: 9,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w800),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Privacy Policy for Ezonset\n\n",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                                text: '''
At Ezonset, accessible from www.Ezonset.com and from Google Play Store, one of our main priorities is the privacy of our users and visitors. This Privacy Policy document contains types of information that is collected and recorded by Ezonset and how we use it.

If you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us.

This Privacy Policy applies only to our online activities and is valid for users of Ezonset's Android Application and visitors to our website with regards to the information that they shared and/or collect in Ezonset. This policy is not applicable to any information collected offline or via channels other than this website.''',
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset("assets/privacy_tos/1.png"),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w800),
                          children: <TextSpan>[
                            TextSpan(
                              text: "\nConsent\n\n",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                                text: '''
By using our Application and website, you hereby consent to our Privacy Policy and agree to its terms.

All of the information that is collected will only be shared with the person you choose to pair with and vice versa. This information is only being collected to provide enhanced in-app experience and satisfaction to both of the end users.
The information we use and collect under the hood are device Information such as screen state, volume, light activity, brightness, battery stats, location, orientation, motion, and device specs to give insight to the paired user about your device and vice versa.
The rest of the personal information that you are asked to provide, and the reasons why you are asked to provide it will be made clear to you within the application.
If you contact us directly, we may receive additional information about you such as your name, email address, phone number, the contents of the message and/or attachments you may send us, and any other information you may choose to provide.
When you register for an Account, we may ask for your contact information, including items such as name, company name, address, email address, and telephone number.''',
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset("assets/privacy_tos/2.png"),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w800),
                          children: <TextSpan>[
                            TextSpan(
                              text: "How we use your information\n\n",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                                text: '''
We use the information we collect in various ways, including to:

- Provide, operate, and maintain our application
- Improve, personalize, and expand our application
- Understand and analyze how you use our application
- Develop new products, services, features, and functionality to satisfy user needs
- Communicate with you, either directly or through one of our partners, including for customer service, to provide you with updates and other information relating to the app, and for marketing and promotional purposes
- Send you emails
- Find and prevent fraud.''',
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset("assets/privacy_tos/3.png"),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w800),
                          children: <TextSpan>[
                            TextSpan(
                              text: "\nLog Files\n\n",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                                text: '''
By using our Application and website, you hereby consent to our Privacy Policy and agree to its terms.

All of the information that is collected will only be shared with the person you choose to pair with and vice versa. This information is only being collected to provide enhanced in-app experience and satisfaction to both of the end users.
The information we use and collect under the hood are device Information such as screen state, volume, light activity, brightness, battery stats, location, orientation, motion, and device specs to give insight to the paired user about your device and vice versa.
The rest of the personal information that you are asked to provide, and the reasons why you are asked to provide it will be made clear to you within the application.
If you contact us directly, we may receive additional information about you such as your name, email address, phone number, the contents of the message and/or attachments you may send us, and any other information you may choose to provide.
When you register for an Account, we may ask for your contact information, including items such as name, company name, address, email address, and telephone number.''',
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset("assets/privacy_tos/4.png"),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w800),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Cookies and Web Beacons\n\n",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                                text: '''
Like any other website, Ezonset uses 'cookies'. These cookies are used to store information including visitors' preferences, and the pages on the website that the visitor accessed or visited. The information is used to optimize the users' experience by customizing our web page content based on visitors' browser type and/or other information.

For more general information on cookies, please read "What Are Cookies''',
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset("assets/privacy_tos/5.png"),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w800),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  "\nAdvertising Partners Privacy Policies\n\n",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                                text: '''
You may consult this list to find the Privacy Policy for each of the advertising partners of Ezonset.

Third-party ad servers or ad networks uses technologies like cookies, JavaScript, or Web Beacons that are used in their respective advertisements and links that appear on Ezonset, which are sent directly to users' browser. They automatically receive your IP address when this occurs. These technologies are used to measure the effectiveness of their advertising campaigns and/or to personalize the advertising content that you see on websites that you visit.

Note that Ezonset has no access to or control over these cookies that are used by third-party advertisers.''',
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset("assets/privacy_tos/6.png"),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w800),
                          children: <TextSpan>[
                            TextSpan(
                              text: "\nThird Party Privacy Policies\n\n",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                                text: '''
Ezonset's Privacy Policy does not apply to other advertisers or websites. Thus, we are advising you to consult the respective Privacy Policies of these third-party ad servers for more detailed information. It may include their practices and instructions about how to opt-out of certain options.

You can choose to disable cookies through your individual browser options. To know more detailed information about cookie management with specific web browsers, it can be found at the browsers' respective websites.''',
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset("assets/privacy_tos/7.png"),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w800),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  "\nCCPA Privacy Rights (Do Not Sell My Personal Information)\n\n",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                                text: '''
Under the CCPA, among other rights, California consumers have the right to:

Request that a business that collects a consumer's personal data disclose the categories and specific pieces of personal data that a business has collected about consumers.

Request that a business delete any personal data about the consumer that a business has collected.

Request that a business that sells a consumer's personal data, not sell the consumer's personal data.

If you make a request, we have one month to respond to you. If you would like to exercise any of these rights, please contact us.''',
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset("assets/privacy_tos/8.png"),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w800),
                          children: <TextSpan>[
                            TextSpan(
                              text: "\nGDPR Data Protection Rights\n\n",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                                text: '''
We would like to make sure you are fully aware of all of your data protection rights. Every user is entitled to the following:

The right to access – You have the right to request copies of your personal data. We may charge you a small fee for this service.

The right to rectification – You have the right to request that we correct any information you believe is inaccurate. You also have the right to request that we complete the information you believe is incomplete.

The right to erasure – You have the right to request that we erase your personal data, under certain conditions.

The right to restrict processing – You have the right to request that we restrict the processing of your personal data, under certain conditions.

The right to object to processing – You have the right to object to our processing of your personal data, under certain conditions.''',
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset("assets/privacy_tos/9.png"),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w800),
                          children: <TextSpan>[
                            TextSpan(
                              text: "\nChildren's Information\n\n",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                                text: '''
Another part of our priority is adding protection for children while using the internet. We encourage parents and guardians to observe, participate in, and/or monitor and guide their online activity.

Ezonset does not knowingly collect any Personal Identifiable Information from children under the age of 13. If you think that your child provided this kind of information on our website, we strongly encourage you to contact us immediately and we will do our best efforts to promptly remove such information from our records.''',
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset("assets/privacy_tos/10.png"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
