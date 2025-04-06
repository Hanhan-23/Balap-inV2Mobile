import 'package:flutter/material.dart';
import 'package:frontend/widgets/draftlaporan/buttondeload.dart';
import 'package:frontend/widgets/draftlaporan/listdraflapor.dart';

class DrafLaporScreen extends StatefulWidget {
  const DrafLaporScreen({super.key});

  @override
  State<DrafLaporScreen> createState() => _DrafLaporScreenState();
}

class _DrafLaporScreenState extends State<DrafLaporScreen> {
  int? selectedIndex;
  Color colorSelected = Color.fromRGBO(17, 84, 237, 1);
  Color colorNotSelected = Color.fromRGBO(202, 213, 226, 1);

  void handleSelected(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.92,
        child: Column(
          spacing: 10,
          children: [
            Container(
              padding: EdgeInsets.only(top: 16),
              alignment: Alignment.topCenter,
              child: Container(
                alignment: AlignmentDirectional.centerStart,
                width: MediaQuery.of(context).size.width * 0.2,
                height: 5,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(202, 213, 226, 1),
                  borderRadius: BorderRadius.circular(200),
                ),
              ),
            ),

            selectedIndex == null
                ? textDrlaporanda()
                : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    butdel(), 
                    textDrlaporanda(), 
                    butload()
                  ],
                ),

            Expanded(
              child: Scrollbar(
                radius: Radius.circular(100),
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: GestureDetector(
                        onTap: () {
                          handleSelected(index);
                        },
                        child: ListDrafLapor(
                          indexlaporan: index,
                          colorSelected:
                              index == selectedIndex
                                  ? colorSelected
                                  : colorNotSelected,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

butload() {
  return ButtonDeLoadDraft(
    iconRequired: Icon(Icons.check),
    colorButton: Colors.green,
    onPress: null,
  );
}

butdel() {
  return ButtonDeLoadDraft(
    iconRequired: Icon(Icons.delete),
    colorButton: const Color.fromARGB(255, 207, 36, 24),
    onPress: null,
  );
}

textDrlaporanda() {
  return Text(
    'Draf laporan anda',
    style: TextStyle(
      fontFamily: 'Instrument-Sans',
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
  );
}
