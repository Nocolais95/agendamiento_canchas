import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/providers/stepper_provider.dart';
import 'package:test_flutter/widgets/cancha_card.dart';
import 'package:test_flutter/widgets/show_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final stepperProvider = Provider.of<StepperProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mendoza Tennis Club'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: stepperProvider.getAgenda().turno.isEmpty
      ? const Center( child: Text('No hay turnos próximos'))
      : SingleChildScrollView(
        child: Column(
          children: stepperProvider.getAgenda().turno.map((data) => CanchaCard(
            nameTennis: data.turno!.court!,
            date: data.turno!.fecha,
            nameUser: data.turno!.name,
            rain: data.turno!.lluvia,
            idTurno: data.turno!.idTurno!,
            id: data.id,
            height: 130,
            width: double.infinity,
            onDelete: (){
              showData(context, data.id!);
            },
            )).toList(),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.blueAccent,
        notchMargin: 5,
        child: Container(height: 50),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, size: 35),
        onPressed: (){
          Navigator.of(context).pushNamed('add');
        },
        ),
   );
  }
}