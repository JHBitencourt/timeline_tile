import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/atelier-sulphurpool-dark.dart';
import 'package:google_fonts/google_fonts.dart';

import 'example/example_1.dart';
import 'example/example_10.dart';
import 'example/example_2.dart';
import 'example/example_3.dart';
import 'example/example_4.dart';
import 'example/example_5.dart';
import 'example/example_6.dart';
import 'example/example_7.dart';
import 'example/example_8.dart';
import 'example/example_9.dart';

class ShowcaseTimeline extends StatelessWidget {
  const ShowcaseTimeline({Key? key, required this.example}) : super(key: key);

  final Example example;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF004E92),
            Color(0xFF000428),
          ],
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Text(
                    example.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverList(
                          delegate: SliverChildListDelegate(
                            <Widget>[
                              _Description(
                                description: example.description,
                                code: example.code,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Vertical Axis:',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                        const SliverPadding(padding: EdgeInsets.only(top: 20)),
                        example.childVertical,
                        const SliverPadding(padding: EdgeInsets.only(top: 20)),
                        SliverList(
                          delegate: SliverChildListDelegate(
                            <Widget>[
                              const Text(
                                'Horizontal Axis:',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                        const SliverPadding(padding: EdgeInsets.only(top: 20)),
                        example.childHorizontal,
                        const SliverPadding(padding: EdgeInsets.only(top: 40)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Code extends StatelessWidget {
  const _Code({Key? key, required this.code}) : super(key: key);

  final String code;

  @override
  Widget build(BuildContext context) {
    return HighlightView(
      code,
      language: 'dart',
      theme: atelierSulphurpoolDarkTheme,
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    Key? key,
    required this.description,
    required this.code,
  }) : super(key: key);

  final String description;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        color: Colors.white.withOpacity(0.2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              description,
              style: GoogleFonts.jura(fontSize: 18),
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(
              accentColor: Colors.white,
              dividerColor: Colors.transparent,
              unselectedWidgetColor: Colors.white,
            ),
            child: ExpansionTile(
              title: Text(
                '</> SOURCE CODE',
                style: GoogleFonts.lato(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
              children: <Widget>[
                _Code(code: code),
                OutlinedButton(
                  onPressed: () {
                    showCodeDialog(context);
                  },
                  child: Text(
                    'FULL SCREEN',
                    style: GoogleFonts.lato(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      BorderSide(
                        color: Colors.white.withOpacity(0.7),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showCodeDialog(BuildContext context) {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SingleChildScrollView(
            child: _Code(code: code),
          ),
        );
      },
    );
  }
}

class Example {
  const Example({
    required this.name,
    required this.description,
    required this.code,
    required this.childHorizontal,
    required this.childVertical,
  });

  final String name;
  final String description;
  final String code;
  final Widget childVertical;
  final Widget childHorizontal;
}

const examples = <Example>[
  example1,
  example2,
  example3,
  example4,
  example5,
  example6,
  example7,
  example8,
  example9,
  example10,
];
