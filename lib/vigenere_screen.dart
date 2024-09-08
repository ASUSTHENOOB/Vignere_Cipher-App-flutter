import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class VigenereScreen extends StatefulWidget {
  @override
  _VigenereScreenState createState() => _VigenereScreenState();
}

class _VigenereScreenState extends State<VigenereScreen> {
  final _textController = TextEditingController();
  final _keyController = TextEditingController();
  String _result = '';

  String vigenereEncrypt(String text, String key) {
    key = key.toUpperCase();
    text = text.toUpperCase();
    String result = '';
    for (int i = 0; i < text.length; i++) {
      int charCode =
          (text.codeUnitAt(i) + key.codeUnitAt(i % key.length) - 2 * 65) % 26 +
              65;
      result += String.fromCharCode(charCode);
    }
    return result;
  }

  String vigenereDecrypt(String text, String key) {
    key = key.toUpperCase();
    text = text.toUpperCase();
    String result = '';
    for (int i = 0; i < text.length; i++) {
      int charCode =
          (text.codeUnitAt(i) - key.codeUnitAt(i % key.length) + 26) % 26 + 65;
      result += String.fromCharCode(charCode);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 154, 86, 156),
        title: Text('Vigenère Cipher',
            style:
                GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                    labelText: 'Enter Plain Text',
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 95, 159, 129)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[500])),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _keyController,
                decoration: InputDecoration(
                    labelText: 'Key',
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 95, 159, 129)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[500])),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _result = vigenereEncrypt(
                            _textController.text, _keyController.text);
                      });
                    },
                    child: Text('Encrypt'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _result = vigenereDecrypt(
                            _textController.text, _keyController.text);
                      });
                    },
                    child: Text('Decrypt'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('Result: $_result'),
              ElevatedButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: _result));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Result Copied')),
                  );
                },
                child: Text('Copy the Results'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
