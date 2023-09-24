import 'package:app_imc_flutter/classes/imc.dart';
import 'package:app_imc_flutter/repositories/imc_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _listaImcCalculado = <IMC>[];
  var imcRepository = ImcRepository();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  TextEditingController dataHoraController = TextEditingController(
      text: DateFormat('MMM dd, HH:mm').format(DateTime.now()));

  @override
  void initState() {
    super.initState();
    ObterListaImc();
  }

  void ObterListaImc() async {
    _listaImcCalculado = await imcRepository.listarIMCs();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            pesoController.text = "99";
            alturaController.text = "176";
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                context: context,
                builder: (BuildContext bc) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: ListView(
                      children: [
                        const Text(
                          "Informe os dados",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        const Text("Peso"),
                        TextField(
                          controller: pesoController,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text("Altura"),
                        TextField(
                          controller: alturaController,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 215, 187, 6))),
                              onPressed: () async {
                                await imcRepository.adicionar(IMC(
                                  double.parse(pesoController.text),
                                  int.parse(alturaController.text),
                                  dataHoraController.text,
                                ));
                                Navigator.pop(context);
                                setState(() {});
                              },
                              child: const Text(
                                "Adicionar e Calcular",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800),
                              )),
                        )
                      ],
                    ),
                  );
                });
          },
          child: const Icon(Icons.calculate),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: _listaImcCalculado.length,
                    itemBuilder: (BuildContext bc, int index) {
                      var listaImcCalculado = _listaImcCalculado[index];
                      return Dismissible(
                          onDismissed:
                              (DismissDirection dismissDirection) async {
                            await imcRepository.remover(listaImcCalculado.id);
                            ObterListaImc();
                          },
                          key: Key(listaImcCalculado.id),
                          child: ListTile(
                            tileColor: Color.fromARGB(24, 233, 233, 5),
                            leading: Text(
                              listaImcCalculado
                                  .calculaImc(listaImcCalculado.peso,
                                      listaImcCalculado.altura)
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                            title: Text(
                              listaImcCalculado.informaFaixaImc(
                                  listaImcCalculado.peso,
                                  listaImcCalculado.altura),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(0, 0, 0, 0.98)),
                            ),
                            subtitle: Container(
                              alignment: Alignment.topLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Altura: ${listaImcCalculado.altura} cm",
                                      textAlign: TextAlign.left),
                                  Text("Peso: ${listaImcCalculado.peso} kg",
                                      textAlign: TextAlign.left),
                                ],
                              ),
                            ),
                            trailing: Text(listaImcCalculado.dataHora),
                          ));
                    }),
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: const Row(
            children: [
              Icon(Icons.calculate_rounded),
              Text(
                "Calculadora de Indice de Massa Corporal",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
