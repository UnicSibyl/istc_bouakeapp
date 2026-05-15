import 'package:flutter_test/flutter_test.dart';
import 'package:istc_bouakeapp/main.dart';

void main() {
  testWidgets('Vérification du chargement de l\'application',
      (WidgetTester tester) async {
    // On charge l'application
    await tester.pumpWidget(const MyApp());

    // On vérifie que l'accueil s'affiche (par exemple en cherchant le texte 'Accueil')
    expect(find.text('Accueil'), findsWidgets);
  });
}
