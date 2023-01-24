import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plenka/widgets/photo_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String imageUrl = '';
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User? loggedUser;
  int _selectedIndex = 0;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() {
    loggedUser = _auth.currentUser;
    print(loggedUser?.email);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.home)),
              IconButton(
                  onPressed: () async {
                    XFile? image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    if (image == null) return;
                    String uniqueName =
                        DateTime.now().millisecondsSinceEpoch.toString();
                    Reference reference = FirebaseStorage.instance.ref();
                    Reference referenceFolder = reference.child('images');
                    Reference referenceImage =
                        referenceFolder.child(uniqueName);
                    try {
                      await referenceImage.putFile(File(image.path));
                      imageUrl = await referenceImage.getDownloadURL();
                      _firestore.collection('images').add({
                        'name': uniqueName,
                        'url': imageUrl,
                      });
                    } catch (e) {}
                  },
                  icon: Icon(Icons.add)),
              IconButton(onPressed: () {}, icon: Icon(Icons.person)),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: ImagesStream(firestore: _firestore),
      ),
    );
  }
}

class ImagesStream extends StatelessWidget {
  const ImagesStream({
    Key? key,
    required FirebaseFirestore firestore,
  })  : _firestore = firestore,
        super(key: key);

  final FirebaseFirestore _firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firestore.collection('images').snapshots(),
        builder: (context, snapshot) {
          List<PhotoCard> posts = [];
          final images;
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.deepPurple,
            ));
          }
          if (snapshot.data != null) {
            images = snapshot.data!.docs.reversed;
            for (var message in images) {
              final image = message.get('url');
              final newPost = PhotoCard(image: Image.network(image));
              posts.add(newPost);
            }
          }
          return Expanded(
              child: ListView(
            children: posts,
          ));
        });
  }
}
