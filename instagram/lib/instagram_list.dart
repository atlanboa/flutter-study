import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram/instagram_stories.dart';

class InstaList extends StatelessWidget {
  const InstaList({super.key});

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => index == 0
          ? SizedBox(
              height: deviceSize.height * 0.15,
              child: InstaStories(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://ichef.bbci.co.uk/news/640/cpsprodpb/E172/production/_126241775_getty_cats.png',
                            ),
                          ),
                          SizedBox(width: 10),
                          Text('Username'),
                        ],
                      ),
                      const IconButton(
                        onPressed: null,
                        icon: Icon(Icons.more_vert),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Image.network(
                        'https://ichef.bbci.co.uk/news/640/cpsprodpb/E172/production/_126241775_getty_cats.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        IconButton(
                          onPressed: null,
                          icon: Icon(FontAwesomeIcons.heart),
                        ),
                        IconButton(
                          onPressed: null,
                          icon: Icon(FontAwesomeIcons.comment),
                        ),
                        IconButton(
                          onPressed: null,
                          icon: Icon(FontAwesomeIcons.paperPlane),
                        ),
                      ],
                    ),
                    const IconButton(
                      onPressed: null,
                      icon: Icon(FontAwesomeIcons.bookmark),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Liked by username and 528,999 others',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
    );
  }
}
