import 'package:flutter/material.dart';

class MassengerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/34492145?v=4'),
            ),
            SizedBox(
              width: 15.0,
            ),
            Text(
              'chats',
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        actions: [
          IconButton(
            icon: CircleAvatar(
              radius: 16.5,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.camera_alt,
                size: 16.0,
                color: Colors.white,
              ),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: CircleAvatar(
              radius: 16.5,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.edit,
                size: 16.0,
                color: Colors.white,
              ),
            ),
            onPressed: () {},
          ),
        ],
        titleSpacing: 18.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.grey[300],
              ),
              child: Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text('Search'),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              width: 50.0,
              child: Column(
                children: [
                  Stack(alignment: AlignmentDirectional.bottomEnd, children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          'https://avatars.githubusercontent.com/u/34492145?v=4'),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          bottom: 3.0, end: 3.0),
                      child: CircleAvatar(
                        radius: 7.0,
                        backgroundColor: Colors.green,
                      ),
                    )
                  ]),
                  SizedBox(height: 6.0),
                  Text(
                    'khaled fathy amer',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
