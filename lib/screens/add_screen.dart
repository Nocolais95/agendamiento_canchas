// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/providers/stepper_provider.dart';
import 'package:test_flutter/services/weather_services.dart';
import 'package:test_flutter/share_preferences/preferences.dart';
import 'package:test_flutter/style/text_style.dart';
import 'package:test_flutter/widgets/cancha_card.dart';
import 'package:intl/intl.dart';

import '../models/turno_model.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StepperProvider(),
      lazy: false,
      child:  _AddStepper(),
    );
  }
}

class _AddStepper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stepperProvider = Provider.of<StepperProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar nuevo turno'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Stepper(
        currentStep: stepperProvider.getCurrentStep,
        elevation: 0,
        type: StepperType.vertical,
        steps: [
          Step(
            title: const Text('Seleccione cancha'),
            state: stepperProvider.getCurrentStep > 0 ? StepState.complete : StepState.editing,
            isActive: stepperProvider.getCurrentStep >= 0,
            content: StepCancha(stepperProvider: stepperProvider),
          ),
          Step(
            title: const Text('Ingresar nombre'),
            state: stepperProvider.getCurrentStep > 1 ? StepState.complete : StepState.editing,
            isActive: stepperProvider.getCurrentStep >= 1,
            content: StepName(stepperProvider: stepperProvider),
          ),
          Step(
            title: const Text('Ingresar fecha'),
            state: stepperProvider.getCurrentStep > 2 ? StepState.complete : StepState.editing,
            isActive: stepperProvider.getCurrentStep >= 2,
            content: StepFecha(stepperProvider: stepperProvider),
          ),
          Step(
            title: const Text('Confirmar datos'), 
            state: stepperProvider.getCurrentStep > 3 ? StepState.complete : StepState.editing,
            isActive: stepperProvider.getCurrentStep >= 3,
            content: StepConfirmar(stepperProvider: stepperProvider),
          ),
        ],
        controlsBuilder: (context, details) {
          return Container();
        },
      )
   );
  }
}

class StepConfirmar extends StatelessWidget {
  final StepperProvider stepperProvider;
  const StepConfirmar({
    Key? key, required this.stepperProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 25, color: Colors.black, thickness: 1, endIndent: 150),
        Row(
          children: [
            Text('Cancha elegida: ', style: style()),
            Text(stepperProvider.getCancha, style: style())
          ],
        ),
        const Divider(height: 25, endIndent: 150),
        Row(
          children: [
            Text('Nombre: ', style: style()),
            Text(stepperProvider.getName, style: style())
          ],
        ),
        const Divider(height: 25, endIndent: 150),
        Row(
          children: [
            Text('Fecha: ', style: style()),
            Text(stepperProvider.getFecha, style: style())
          ],
        ),
        const Divider(height: 25, endIndent: 150),
        Row(
          children: [
            Text('Probabilidad lluvia: ', style: style()),
            Text(stepperProvider.getRain, style: style())
          ],
        ),
        const Divider(height: 25, color: Colors.black, thickness: 1, endIndent: 150),
        Row(
          children: [
            TextButton(
              onPressed: (){
                  stepperProvider.setCurrentStep = 2;
              }, 
              child: const Text('Volver'),
            ),
            TextButton(
              onPressed: (){
                TurnoClass newTurno = TurnoClass(
                  court: stepperProvider.getCancha,
                  fecha: stepperProvider.getFecha,
                  name: stepperProvider.getName,
                  lluvia: stepperProvider.getRain,
                  idTurno: stepperProvider.getIdTurno
                  // idTurno: stepperProvider.
                );
                Turno t = Turno(
                  id: "${newTurno.court}/${newTurno.fecha}/${newTurno.idTurno}",
                  turno: newTurno
                );
                stepperProvider.setTurnos = t;
                Navigator.popAndPushNamed(context, 'home');
              },
              child: const Text('Confirmar')),
          ],
        )
      ],
    );
  }
}

class StepFecha extends StatelessWidget {
  final StepperProvider stepperProvider;
  const StepFecha({
    Key? key, required this.stepperProvider,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Agenda agenda = Preferences.turnos == '' ? Agenda(turno: []) : Agenda.fromJson(Preferences.turnos);
    final weatherServices = Provider.of<WeatherServices>(context);
    DateTime f = DateTime.parse(stepperProvider.getFecha);
    int index = weatherServices.days.indexWhere((e) => e.date == DateFormat('dd/MM/yyyy').format(f));
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            var f;
            f = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(3000),
            );
            if(f != null){
              String fecha = DateFormat('yyyy-MM-dd').format(f);
              stepperProvider.setFecha = fecha;
            }
            stepperProvider.setIsOkeyFecha = false;
          },
          child: const Text('Ingresar fecha'),
        ),
        const Divider(height: 25),
        Text('Fecha elegida: ${stepperProvider.getFecha.toString()}', 
        style: style()),
        const Divider(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Probabilidad de lluvia:', style: style()),
            ( index >= 0 && index <= 6 )
            ? Text(weatherServices.days[index].probPrecipPct.toString(), style: style())
            : Text('No existe', style: style())
          ],
        ),
        const Divider(height: 25),
        Text('Seleccione un turno disponible:', style: style()),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: (agenda.turno.any((e) => e.id == "${stepperProvider.getCancha}/${stepperProvider.getFecha}/${1}"))
              ? null
              : (){
                stepperProvider.setIsOkeyFecha = true;
                stepperProvider.setIdTurno = 1;
              }, 
              child: const Text('Turno 1'),
            ),
            ElevatedButton(
              onPressed: (agenda.turno.any((e) => e.id == "${stepperProvider.getCancha}/${stepperProvider.getFecha}/${2}"))
              ? null
              : (){
                stepperProvider.setIsOkeyFecha = true;
                stepperProvider.setIdTurno = 2;
              }, 
              child: const Text('Turno 2'),
            ),
            ElevatedButton(
              onPressed: (agenda.turno.any((e) => e.id == "${stepperProvider.getCancha}/${stepperProvider.getFecha}/${3}"))
              ? null
              : (){
                stepperProvider.setIsOkeyFecha = true;
                stepperProvider.setIdTurno = 3;
              }, 
              child: const Text('Turno 3'),
            ),
            
          ],
        ),
        Row(
          children: [
            TextButton(
              onPressed: (){
                  stepperProvider.setCurrentStep = 1;
              }, 
              child: const Text('Volver'),
            ),
            TextButton(
              onPressed: (!stepperProvider.getIsOkeyFecha)
              ? null
              : (){
                stepperProvider.setCurrentStep = 3;
                stepperProvider.setRain = ( index >= 0 && index <= 6 )
                  ? weatherServices.days[index].probPrecipPct.toString()
                  : 'No existe info';
              },
              child: const Text('Continuar')),
          ],
        )
      ],
    );
  }
  
}

class StepCancha extends StatelessWidget {
  final StepperProvider stepperProvider;
  const StepCancha({
    Key? key, required this.stepperProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CanchaCard(
          nameTennis: 'A',
          onTap: () {
              stepperProvider.setCurrentStep = 1;
              stepperProvider.setCancha = 'A';
          },
        ),
        CanchaCard(
          nameTennis: 'B',
          onTap: () {
              stepperProvider.setCurrentStep = 1;
              stepperProvider.setCancha = 'B';
          },
        ),
        CanchaCard(
          nameTennis: 'C',
          onTap: () {
              stepperProvider.setCurrentStep = 1;
              stepperProvider.setCancha = 'C';
          },
        ),
      ],
    );
  }
}

class StepName extends StatelessWidget {
  final StepperProvider stepperProvider;
  const StepName({Key? key, required this.stepperProvider,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            const SizedBox(height: 10),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textCapitalization: TextCapitalization.words,
              autofocus: true,
              validator: (value) {
                if (value == null || value.length < 2) {
                  stepperProvider.setIsOkey = false;
                  return 'El nombre es obligatorio';
                } else {
                  stepperProvider.setIsOkey = true;
                }
                return null;
              },
              onChanged: (value) {
                stepperProvider.setName = value;
              },
              decoration: const InputDecoration(
                hintText: 'Ingrese el nombre',
                labelText: 'Nombre: ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )
                )
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                TextButton(
                  onPressed: (){
                      stepperProvider.setCurrentStep = 0;
                      FocusScope.of(context).requestFocus(FocusNode());
                  }, 
                  child: const Text('Volver'),
                ),
                TextButton(
                  onPressed: (stepperProvider.getIsOkey)
                  ? (){
                      stepperProvider.setCurrentStep = 2;
                      FocusScope.of(context).requestFocus(FocusNode());
                  }
                  : null,
                  child: const Text('Continuar')),
              ],
            )
          ],
        ),
      ],
    );
  }
}