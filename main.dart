import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  MyApp() {
    print('myapp yaratılıyor');
  }

  @override
  Widget build(BuildContext context) {
    print('myapp build');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key) {
    print('myhomepage yaratılıyor');
  }

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState() {
    print('myhomepagestate yaratılıyor');
  }

  @override
  void initState() {
    super.initState();
    ogrenciler.add('init');
  }

  var sinif = 5;
  var baslik = 'Öğrenciler';
  var ogrenciler = ['Ali', 'Ayşe', 'Can'];

  void yeniOgrenciEkle(String yeniOgrenci){
    setState(() {
      ogrenciler=[...ogrenciler,yeniOgrenci];
    });
  }
  void yeniOgrenciSil(){
    setState(() {
      ogrenciler.removeAt(ogrenciler.length-1);
    });
  }
  @override
  Widget build(BuildContext context) {
    print('myhomepagestate build');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SinifBilgisi(
          sinif: sinif,
          baslik: baslik,
          ogrenciler: ogrenciler,
          yeniOgrenciEkle :yeniOgrenciEkle,
          yeniOgrenciSil :yeniOgrenciSil,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Arkaplan(),
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: LayoutBuilder(
                  builder: (context, constrain) {
                    if(constrain.maxWidth > 450){
                      return Row(
                        children: [
                          Sinif(),
                          Expanded(child: Text('seçili olan öğrencilerin detaylaarı')),
                        ],
                      );
                    }else{
                      return Sinif();
                    }
                  }
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: OgrenciEkleme(),
            ),//çift tıkla +refactor+extract fluter widget
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: OgrenciSilme(),
            ),
          ],
        ),
      ),
    );
  }
}

class SinifBilgisi extends InheritedWidget {
  const SinifBilgisi({
    Key? key,
    required Widget child,
    required this.sinif,
    required this.baslik,
    required this.ogrenciler,
    required this.yeniOgrenciEkle,
    required this.yeniOgrenciSil,
  }) : super(key: key, child: child);

  final int sinif;
  final String baslik;
  final List<String> ogrenciler;
  final void Function(String yeniOgrenci) yeniOgrenciEkle;
  final void Function() yeniOgrenciSil;

  static SinifBilgisi of(BuildContext context) {
    final SinifBilgisi? result = context.dependOnInheritedWidgetOfExactType<SinifBilgisi>();
    assert(result != null, 'No SinifBilgisi found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(SinifBilgisi old) {
    return sinif != old.sinif ||
        baslik != old.baslik ||
        ogrenciler != old.ogrenciler ||
        yeniOgrenciEkle != old.yeniOgrenciEkle ||
        yeniOgrenciSil != old.yeniOgrenciSil ;
  }
}

class Sinif extends StatelessWidget {
  const Sinif({
    Key? key,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sinifBilgisi = SinifBilgisi.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.add_business_outlined,
              color : Colors.green,
            ),
            Text(
              '${sinifBilgisi.sinif}. Sınıf',
              textScaleFactor: 2,
            ),

          ],
        ),
        Text(
          sinifBilgisi.baslik,
          textScaleFactor: 1.5,
        ),
        OgrenciListesi(),
      ],
    );
  }
}

class OgrenciListesi extends StatelessWidget {
  const OgrenciListesi({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final sinifBilgisi = SinifBilgisi.of(context);
    return Column(
      children: [
        for(final o in sinifBilgisi.ogrenciler)
          Text(
              o
          ),
      ],
    );
  }
}

class OgrenciEkleme extends StatefulWidget {

  const OgrenciEkleme({
    Key? key,
  }) : super(key: key);


  @override
  State<OgrenciEkleme> createState() => _OgrenciEklemeState();
}

class _OgrenciEklemeState extends State<OgrenciEkleme> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sinifBilgisi = SinifBilgisi.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        TextField(
          controller: controller,
          onChanged: (value) {
            setState(() {

            });
          },
        ),
        Align(
          alignment: Alignment.centerLeft,

          child: ElevatedButton(
            onPressed: controller.text.isEmpty?null: () {
              print('yeniekleme builted');
              final yeniOgrenci = controller.text;
              if(yeniOgrenci.)
              sinifBilgisi.yeniOgrenciEkle(yeniOgrenci);
              controller.text = "";
             },
            child: Text(
              'Ekle',
            ),
          ),
        ),
      ],
    );
  }
}

class OgrenciSilme extends StatefulWidget {
  const OgrenciSilme({
    Key? key,
  }) : super(key: key);


  @override
  State<OgrenciSilme> createState() => _OgrenciSilmeState();
}

class _OgrenciSilmeState extends State<OgrenciSilme> {
  @override
  Widget build(BuildContext context) {
    final sinifBilgisi = SinifBilgisi.of(context);
    return Column(
      mainAxisSize:MainAxisSize.min ,
      children: [
        ElevatedButton(

          onPressed: (){
            print('tamtemizlik builted');
            sinifBilgisi.yeniOgrenciSil();
            //setState(() {
            //  ogrenciler.removeAt(ogrenciler.length-1);
            //});
          },
          child: Text(
              'Sil'
          ),
        ),
      ],
    );
  }
}

class Arkaplan extends StatelessWidget {
  const Arkaplan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          color: Colors.purple,
          width: 60,
          height: 100,
          child: Container(
            color: Colors.yellow,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
              child: Container(
                color: Colors.deepOrange,
                width: 30,
                height: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}