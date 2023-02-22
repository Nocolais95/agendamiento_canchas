// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:test_flutter/style/text_style.dart';

import '../utils/select_court.dart';

class CanchaCard extends StatelessWidget {
  final String nameTennis;
  final Function? onTap;
  final Function? onLognPress;
  final String? nameUser;
  final String? date;
  final int? idTurno;
  final String? id;
  final String? rain;
  final double? height;
  final double? width;

  const CanchaCard({
    Key? key, required this.nameTennis, this.onTap, this.nameUser, this.date, this.rain, this.height, this.width, this.onLognPress, this.idTurno, this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (onTap == null) {
            null;
          } else {
            onTap!();
          }
        },
        onLongPress: () {
          if (onLognPress == null) {
            null;
          } else {
            onLognPress!();
          }
        },
        child: Container(
          height: height ?? 130,
          width: width ?? MediaQuery.of(context).size.width * 0.9,
          decoration: _decoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(4),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    topLeft: Radius.circular(16)),
                  child: SizedBox(
                    height: double.infinity,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Image(
                      image: AssetImage(courtImage(nameTennis)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Cancha $nameTennis', style: style()),
                    (nameUser==null)
                    ? Container()
                    : Column(
                      children: [
                        Text('Nombre: ${nameUser!}', style: style()),
                        Text('Fecha: ${date!}', style: style()),
                        Text('% lluvia: ${rain!}', style: style()),
                        Text('Turno nro: ${idTurno.toString()}', style: style()),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  BoxDecoration _decoration() {
    return BoxDecoration(
        border: Border.all(color: Colors.black38),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(0, 4),
            blurRadius: 2,
          )
        ],
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.1, 0.8],
          colors: [
            Colors.white,
            Colors.blueAccent,
          ]
        )
      );
  }
}