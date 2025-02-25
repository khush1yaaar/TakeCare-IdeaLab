import 'package:flutter/material.dart';

class LanguagePopup extends StatelessWidget {
  final List<String> languages;
  final Function(String) onSelected;

  LanguagePopup({required this.languages, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Language'),
      content: Container(
        width: double.minPositive,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: languages.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(languages[index]),
              onTap: () {
                onSelected(languages[index]);
                Navigator.of(context).pop();
              },
            );
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}