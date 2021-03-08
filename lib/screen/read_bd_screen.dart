import 'package:flutter/material.dart';
import 'package:ncomics/helper/imageBdhleper.dart';
import 'package:ncomics/model/ImageBd.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ReadBdScreen extends StatefulWidget {
  static const routeName = 'read-bd-screen';
  @override
  _ReadBdScreenState createState() => _ReadBdScreenState();
}

class _ReadBdScreenState extends State<ReadBdScreen> {
  List<ImageBd> imagesBd = [];
  @override
  void initState() {
    super.initState();
    AllImageBd.getImageBd().then((value) {
      setState(() {
        imagesBd = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Images'),
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2 / 3.1,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
            ),
            itemCount: imagesBd.length,
            itemBuilder: (ctx, i) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PhotoViewGallery.builder(
                      loadingBuilder: (context, event) => Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                          ],
                        ),
                      ),
                      scrollPhysics: const BouncingScrollPhysics(),
                      builder: (BuildContext context, int index) {
                        return PhotoViewGalleryPageOptions(
                          imageProvider: NetworkImage(
                            'http://bad-event.com/ncomic/uploadedImage/${imagesBd[index].fileName}',
                          ),
                          initialScale: PhotoViewComputedScale.contained * 1,
                          minScale: PhotoViewComputedScale.contained * 1,
                          maxScale: PhotoViewComputedScale.covered * 2,
                          heroAttributes: PhotoViewHeroAttributes(
                            tag: i,
                          ),
                        );
                      },
                      itemCount: imagesBd.length,
                    ),
                  ),
                );
              },
              child: Container(
                child: Column(
                  children: [
                    Card(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: Image.network(
                          'http://bad-event.com/ncomic/uploadedImage/${imagesBd[i].fileName}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      '${i + 1}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: TextStyle(
            color: Colors.white,
          ),
          backgroundColor: Colors.black,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.info,
                color: Colors.white,
              ),
              label: 'Infos',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              label: 'Infos',
            ),
          ],
        ),
      ),
    );
  }
}
