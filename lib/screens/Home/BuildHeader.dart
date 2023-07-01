import 'package:flutter/material.dart';

Widget buildHeader(BuildContext context) => Material(
      child: InkWell(
        onTap: () {},
        child: Container(
          color: const Color(0xff1d38ae),
          padding: EdgeInsets.only(
            top: 24 + MediaQuery.of(context).padding.top,
            bottom: 24,
          ),
          child: const Column(
            children: [
              CircleAvatar(
                radius: 52,
                backgroundImage: NetworkImage(
                    'https://cdn-icons-png.flaticon.com/128/1532/1532731.png'),
              ),
              SizedBox(height: 12),
              Text(
                '¡Hola florecita!',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                'bovinapp2023@gmail.com',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
