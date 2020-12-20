import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:ezonset/View/Widgets/GigViews/gig_view_three.dart';
import 'package:ezonset/View/Widgets/GradientButton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GigMain extends StatelessWidget {
  final String title;
  
  GigMain({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/gigImage.jpeg"),
              Container(
                height: 60,
                width: double.infinity,
                child: Container(
                  color: Colors.grey[300],
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: CircularProfileAvatar(
                          "https://cdn.iconscout.com/icon/free/png-512/avatar-369-456321.png",
                          radius: 20,
                          backgroundColor: Colors.transparent,
                          borderWidth: 1,
                          borderColor: Colors.deepPurpleAccent,
                          elevation: 20.0,
                          errorWidget: (context, url, error) {
                            return Icon(
                              Icons.face,
                              size: 50,
                            );
                          },
                          cacheImage: true,
                          onTap: () {
                            // if (userFriend.avatarUrl != null) {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => ImageView(
                            //         url: userFriend.avatarUrl,
                            //       ),
                            //     ),
                            //   );
                            // }
                          },
                          animateFromOldImageOnUrlChange: true,
                          placeHolder: (context, url) {
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "@username",
                            style: TextStyle(
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w700),
                          ),
                          Text("Seller Perks")
                        ],
                      ),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.centerRight,
                          child: Icon(
                            FontAwesomeIcons.angleDoubleDown,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  "$title",
                  style: TextStyle(
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: ExpandableText(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nulla magna, bibendum quis finibus nec, laoreet id ante. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur a neque bibendum, pulvinar nisi ac, consectetur lorem. Mauris ut justo cursus, volutpat est vel, posuere est. Vestibulum blandit tincidunt nisl, at semper eros sollicitudin ac. Vivamus non nulla in magna placerat posuere. Aenean ac ante elit. Ut suscipit mauris vitae aliquet feugiat. Nullam at dui sed mauris elementum mattis non nec nisi. In vestibulum odio eu eros congue, sed mollis nisl mollis. Nam quis ante et nibh volutpat aliquet. In rutrum purus mauris, at malesuada nisi tempus et. Sed quam justo, commodo facilisis volutpat eget, tempus ut tortor. Quisque in ornare ante. Donec tincidunt, massa ac viverra sagittis, nunc nisi commodo ligula, eu sodales magna tortor maximus mi. Morbi tincidunt, purus at tristique posuere, magna massa rutrum eros, quis ornare lectus lacus sit amet ex. Donec id lorem vitae velit lobortis finibus. Donec ultricies diam pretium neque malesuada, ut vestibulum lorem tristique. Maecenas in arcu sit amet arcu vehicula volutpat. Phasellus volutpat augue mauris, non fringilla nibh gravida eu. Aliquam dignissim non nibh eu ultrices. Vestibulum molestie sollicitudin condimentum. Phasellus laoreet nulla et diam facilisis efficitur. Nam et nisi sit amet tellus euismod pretium non sed nulla. Ut ultrices pulvinar pellentesque. Suspendisse eu turpis venenatis, porta lorem non, ultrices lacus. Pellentesque tincidunt hendrerit felis nec vulputate. Donec pharetra, elit et iaculis faucibus, ex est faucibus nisi, at pulvinar neque dui non massa.",
                  textAlign: TextAlign.left,
                  textScaleFactor: 1,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: "Nunito",
                      color: Colors.black),
                  expandText: 'show more',
                  collapseText: 'show less',
                  maxLines: 2,
                  linkColor: Colors.orange,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                child: Container(
                  alignment: Alignment.center,
                  width: 200,
                  child: GradientButton(
                    title: "Purchase (\$50)",
                    clrs: [Colors.yellow, Colors.orange],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "People Also Liked",
                  style: TextStyle(
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              ),
              Container(
                height: 300,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, left: 20, top: 20),
                      child: GigViewThree(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
