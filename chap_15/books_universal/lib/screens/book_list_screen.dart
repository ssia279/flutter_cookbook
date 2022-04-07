import 'dart:io';

import 'package:books_universal/data/http_helper.dart';
import 'package:flutter/material.dart';

import '../models/book.dart';

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() {
    return _BookListScreenState();
  }

}

class _BookListScreenState extends State<BookListScreen> {
  List<Book> books = [];
  late bool isLargeScreen;

  @override
  void initState() {
    loadBooks().then((value) {
      setState(() {
        books = value;
      });
    });
    super.initState();
  }

  Future<List<Book>> loadBooks() async {
    HttpHelper helper = HttpHelper();
    List<Book> myBooks = <Book>[];
    await helper.getBooks('flutter').then((value) => myBooks = value);

    return myBooks;
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 600) {
      isLargeScreen = true;
    } else {
      isLargeScreen = false;
    }
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Books')),
      body: GridView.count(
        childAspectRatio: isLargeScreen ? 8 : 5,
        crossAxisCount: isLargeScreen ? 2 : 1,
        children: List.generate(books.length, (index) {
          return ListTile(
            title: Text(books[index].title),
            subtitle: Text(books[index].authors),
            leading: CircleAvatar(
              backgroundImage: (books[index].thumbnail) == '' ? null : NetworkImage(books[index].thumbnail),
            ),
          );
        }),
      ),
    );
  }

}