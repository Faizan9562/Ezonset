import "package:flutter/material.dart";

class TOS extends StatelessWidget {
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
                padding: EdgeInsets.symmetric(horizontal: w*5.0925, vertical: h*2.4886),
                child: Image.asset("assets/dashboard/tos.png"),
              ),
            ),
            Expanded(
              flex: 9,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: w*5.0925,),
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
                              text: "Terms of Service for Ezonset\n\n",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                                text: '''
Welcome to Ezonset!

These terms and conditions outline the rules and regulations for the use of Ezonset's Website located at www.Ezonset.com and Mobile Application on Google Play Store.

By accessing this website and application we assume you accept these terms and conditions. Do not continue to use Ezonset if you do not agree to take all of the terms and conditions stated on this page.

The following terminology applies to these Terms and Conditions, Privacy Statement and Disclaimer Notice and all Agreements: "Client", "You" and "Your" refers to you, the person log on this application and compliant to the Company’s terms and conditions. "The Company", "Ourselves", "We", "Our" and "Us", refers to our Company. "Party", "Parties", or "Us", refers to both the Client and ourselves. All terms refer to the offer, acceptance and consideration of payment necessary to undertake the process of our assistance to the Client in the most appropriate manner for the express purpose of meeting the Client’s needs in respect of provision of the Company’s stated services, in accordance with and subject to, prevailing law of Netherlands. Any use of the above terminology or other words in the singular, plural, capitalization and/or he/she or they, are taken as interchangeable and therefore as referring to same.''',
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w*5.0925, vertical: h*2.4886),
                        child: Image.asset("assets/privacy_tos/11.png"),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w800),
                          children: <TextSpan>[
                            TextSpan(
                              text: "\n\nCookies\n\n",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                                text: '''
We employ the use of cookies. By accessing Ezonset, you agreed to use cookies in agreement with the Ezonset's Privacy Policy.

Most interactive websites and applications use cookies to let us retrieve the user’s details for each visit. Cookies are used by our website and application to enable the functionality of certain areas to make it easier for people visiting our website and application. Some of our affiliate/advertising partners may also use cookies.''',
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w*5.0925, vertical: h*2.4886),
                        child: Image.asset("assets/privacy_tos/12.png"),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w800),
                          children: <TextSpan>[
                            TextSpan(
                              text: "\n\nLicense\n\n",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                                text: '''
Unless otherwise stated, Ezonset and/or its licensors own the intellectual property rights for all material on Ezonset. All intellectual property rights are reserved. You may access this from Ezonset for your own personal use subjected to restrictions set in these terms and conditions.

You must not:

-	Republish material from Ezonset
-	Sell, rent or sub-license material from Ezonset
-	Reproduce, duplicate or copy material from Ezonset
-	Redistribute content from Ezonset
This Agreement shall begin on the date hereof.

Parts of this website and application offer an opportunity for users to post and exchange opinions and information in certain areas of the application. Ezonset does not filter, edit, publish or review Content prior to their presence on the website and application. The Content do not reflect the views and opinions of Ezonset, its agents and/or affiliates. Content reflect the views and opinions of the person who post their views and opinions. To the extent permitted by applicable laws, Ezonset shall not be liable for the content or for any liability, damages or expenses caused and/or suffered as a result of any use of and/or posting of and/or appearance of the content on this application & website whatsoever.

Ezonset reserves the right to monitor all Content and to remove any Content which can be considered inappropriate, offensive or causes breach of these Terms and Conditions.

You warrant and represent that:

You are entitled to post the content on our website and application and have all necessary licenses and consents to do so;
The contents do not invade any intellectual property right, including without limitation copyright, patent or trademark of any third party;
The content do not contain any defamatory, libelous, offensive, indecent or otherwise unlawful material which is an invasion of privacy
The content will not be used to solicit or promote business or custom or present commercial activities or unlawful activity.
You hereby grant Ezonset a non-exclusive license to use, reproduce, edit and authorize others to use, reproduce and edit any of your content in any and all forms, formats or media.''',
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w*5.0925, vertical: h*2.4886),
                        child: Image.asset("assets/privacy_tos/13.png"),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w800),
                          children: <TextSpan>[
                            TextSpan(
                              text: "\n\nHyperlinking to our Content\n\n",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                                text: '''
The following organizations may link to our Website & application without prior written approval:

Government agencies;
Search engines;
News organizations;
Online directory distributors may link to our Website in the same manner as they hyperlink to the Websites of other listed businesses; and
System wide Accredited Businesses except soliciting non-profit organizations, charity shopping malls, and charity fundraising groups which may not hyperlink to our Web site.
These organizations may link to our home page, to publications or to other Website information so long as the link: (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products and/or services; and (c) fits within the context of the linking party’s site.

We may consider and approve other link requests from the following types of organizations:

commonly-known consumer and/or business information sources;
dot.com community sites;
associations or other groups representing charities;
online directory distributors;
internet portals;
accounting, law and consulting firms; and
educational institutions and trade associations.
We will approve link requests from these organizations if we decide that: (a) the link would not make us look unfavorably to ourselves or to our accredited businesses; (b) the organization does not have any negative records with us; (c) the benefit to us from the visibility of the hyperlink compensates the absence of Ezonset; and (d) the link is in the context of general resource information.

These organizations may link to our home page so long as the link: (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products or services; and (c) fits within the context of the linking party’s site.

If you are one of the organizations listed in paragraph 2 above and are interested in linking to our website, you must inform us by sending an e-mail to Ezonset. Please include your name, your organization name, contact information as well as the URL of your site, a list of any URLs from which you intend to link to our Website, and a list of the URLs on our site to which you would like to link. Wait 2-3 weeks for a response.

Approved organizations may hyperlink to our Website as follows:

By use of our corporate name; or
By use of the uniform resource locator being linked to; or
By use of any other description of our Website being linked to that makes sense within the context and format of content on the linking party’s site.
No use of Ezonset's logo or other artwork will be allowed for linking absent a trademark license agreement.''',
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w*5.0925, vertical: h*2.4886),
                        child: Image.asset("assets/privacy_tos/14.png"),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w800),
                          children: <TextSpan>[
                            TextSpan(
                              text: "\n\niFrames\n\n",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                                text: '''
Without prior approval and written permission, you may not create frames around our Webpages that alter in any way the visual presentation or appearance of our Website.''',
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w*5.0925, vertical: h*2.4886),
                        child: Image.asset("assets/privacy_tos/15.png"),
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
                                  "\n\nContent Liability\n\n",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                                text: '''
We shall not be hold responsible for any content that appears on your Website & application. You agree to protect and defend us against all claims that is rising on your Website. No link(s) should appear on any Website that may be interpreted as libelous, obscene or criminal, or which infringes, otherwise violates, or advocates the infringement or other violation of, any third party rights.''',
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w*5.0925, vertical: h*2.4886),
                        child: Image.asset("assets/privacy_tos/16.png"),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w800),
                          children: <TextSpan>[
                            TextSpan(
                              text: "\n\nYour Privacy\n\n",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                                text: '''
Please read Privacy Policy documents provided in the onboarding screens or from in-app settings menu.''',
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w*5.0925, vertical: h*2.4886),
                        child: Image.asset("assets/privacy_tos/17.png"),
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
                                  "\n\nReservation of Rights\n\n",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                                text: '''
We reserve the right to request that you remove all links or any particular link to our Website and application. You approve to immediately remove all links to our Website and application upon request. We also reserve the right to amend these terms and conditions and it’s linking policy at any time. By continuously linking to our Website and application, you agree to be bound to and follow these linking terms and conditions.''',
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w*5.0925, vertical: h*2.4886),
                        child: Image.asset("assets/privacy_tos/18.png"),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w800),
                          children: <TextSpan>[
                            TextSpan(
                              text: "\n\nRemoval of links from our website & application\n\n",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                                text: '''
If you find any link on our Website and application that is offensive for any reason, you are free to contact and inform us any moment. We will consider requests to remove links but we are not obligated to or so or to respond to you directly.

We do not ensure that the information on this website and application is correct, we do not warrant its completeness or accuracy; nor do we promise to ensure that the website remains available or that the material on the website and application is kept up to date.''',
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w*5.0925, vertical: h*2.4886),
                        child: Image.asset("assets/privacy_tos/19.png"),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w800),
                          children: <TextSpan>[
                            TextSpan(
                              text: "\n\nDisclaimer\n\n",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                                text: '''
The materials on Ezonset's website and application are provided on an 'as is' basis. Ezonset makes no warranties, expressed or implied, and hereby disclaims and negates all other warranties including, without limitation, implied warranties or conditions of merchantability, fitness for a particular purpose, or non-infringement of intellectual property or other violation of rights.
Further, Ezonset does not warrant or make any representations concerning the accuracy, likely results, or reliability of the use of the materials on its website or otherwise relating to such materials or on any sites linked to this site.
In no event shall Ezonset or its suppliers be liable for any damages (including, without limitation, damages for loss of data or profit, or due to business interruption) arising out of the use or inability to use the materials on Ezonset's website, even if Ezonset or a Ezonset authorized representative has been notified orally or in writing of the possibility of such damage. Because some jurisdictions do not allow limitations on implied warranties, or limitations of liability for consequential or incidental damages, these limitations may not apply to you.
To the maximum extent permitted by applicable law, we exclude all representations, warranties and conditions relating to our website and the use of this website. Nothing in this disclaimer will:

- limit or exclude our or your liability for death or personal injury;
- limit or exclude our or your liability for fraud or fraudulent misrepresentation;
- limit any of our or your liabilities in any way that is not permitted under applicable law; or
- exclude any of our or your liabilities that may not be excluded under applicable law.
- The limitations and prohibitions of liability set in this Section and elsewhere in this disclaimer: (a) are subject to - the preceding paragraph; and (b) govern all liabilities arising under the disclaimer, including liabilities arising in contract, in tort and for breach of statutory duty.

In case of any mishap or accident of any kind, we will not be liable for any loss or damage of any nature.''',
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w*5.0925, vertical: h*2.4886),
                        child: Image.asset("assets/privacy_tos/20.png"),
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
