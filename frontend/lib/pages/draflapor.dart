import 'package:flutter/material.dart';
import 'package:balapin/provider/laporan_provider.dart';
import 'package:balapin/services/draftservices.dart';
import 'package:balapin/widgets/buatlaporan/dialogcallbackbuatlapor.dart';
import 'package:balapin/widgets/draftlaporan/buttondeload.dart';
import 'package:balapin/widgets/draftlaporan/listdraflapor.dart';
import 'package:provider/provider.dart';

class DrafLaporScreen extends StatefulWidget {
  const DrafLaporScreen({super.key});

  @override
  State<DrafLaporScreen> createState() => _DrafLaporScreenState();
}

class _DrafLaporScreenState extends State<DrafLaporScreen> {
  int? selectedIndex;
  Color colorSelected = const Color.fromRGBO(17, 84, 237, 1);
  Color colorNotSelected = const Color.fromRGBO(202, 213, 226, 1);
  dynamic selectedId;

  late Future<List<Map<String, dynamic>>> futureDraf;

  @override
  void initState() {
    super.initState();
    futureDraf = ambilSemuaDrafLaporan();
  }

  void handleSelected(int index, List<Map<String, dynamic>> daftarDraf) {
    setState(() {
      selectedIndex = index;
      selectedId = daftarDraf[index]['id'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.92,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 16),
              alignment: Alignment.topCenter,
              child: Container(
                alignment: AlignmentDirectional.centerStart,
                width: MediaQuery.of(context).size.width * 0.2,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(202, 213, 226, 1),
                  borderRadius: BorderRadius.circular(200),
                ),
              ),
            ),

            const SizedBox(height: 12),

            selectedIndex == null
                ? textDrlaporanda()
                : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    butdel(() async {
                      final hapus = await hapusDrafLaporan(selectedId);
                      if (hapus == true) {
                        dialogCallbackBuatLapor(context, 'del_draf');
                      }
                      setState(() {
                        futureDraf = ambilSemuaDrafLaporan();
                        selectedIndex = null;
                      });
                    }),
                    textDrlaporanda(),
                    butload(() async {
                      final draf = await loadDrafLaporan(selectedId);
                      if (draf != null) {
                        final provider = Provider.of<LaporanProvider>(
                          context,
                          listen: false,
                        );
                        provider.loadDrafProvider(draf);
                        Navigator.pop(context);
                        dialogCallbackBuatLapor(context, 'load_draf');
                      }
                    }),
                  ],
                ),

            const SizedBox(height: 12),

            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: futureDraf,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("Belum ada draf tersimpan"),
                    );
                  }

                  final daftarDraf = snapshot.data!;

                  return Scrollbar(
                    radius: const Radius.circular(100),
                    child: ListView.builder(
                      itemCount: daftarDraf.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: GestureDetector(
                            onTap: () {
                              handleSelected(index, daftarDraf);
                            },
                            child: ListDrafLapor(
                              indexlaporan: daftarDraf[index],
                              colorSelected:
                                  index == selectedIndex
                                      ? colorSelected
                                      : colorNotSelected,
                              isSelected: index == selectedIndex,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget butload(VoidCallback onpress) {
    return ButtonDeLoadDraft(
      iconRequired: const Icon(Icons.check),
      colorButton: Colors.green,
      onPress: onpress,
    );
  }

  Widget butdel(VoidCallback onpress) {
    return ButtonDeLoadDraft(
      iconRequired: const Icon(Icons.delete),
      colorButton: const Color.fromARGB(255, 207, 36, 24),
      onPress: onpress,
    );
  }

  Widget textDrlaporanda() {
    return const Text(
      'Draf laporan anda',
      style: TextStyle(
        fontFamily: 'Instrument-Sans',
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
