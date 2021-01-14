import 'dart:io';

import 'datastructure/Encoding.dart';
import 'datastructure/Graph.dart';

void main(List<String> arguments) {
  var choice;
  var nbreSommets = 0, nbreMaxArret;
  String value, value1, value2, root;
  int rep = 1;
  print(
      '                         ****************Bienvenue sur le Tp301 Structure DataStructure**************');
  print(
      '\n                                     SUCCINT DATA STRUCTURE                         ');
  print('                                        ********* 1 Arbre  *********');
  print(
      '                                       ********* 2 Graphe  ********* ');
  print('             //// Faites un choix //// \t ');

  choice = int.parse(stdin.readLineSync());
  switch (choice) {
    case 1:
      print(
          '                                       ********* Arbre  *********');

      do {
        print(
            '******************* Entrer le nombre de sommets de votre Arbre **************************');
        nbreSommets = int.parse(stdin.readLineSync());
      } while (nbreSommets <= 0);
      Graph<String> g = new Graph<String>(nbreSommets, true);
      for (int i = 0; i < nbreSommets; i++) {
        if (i == 0) {
          print(
              '************************ Entrer la valeur de la racine [${(i + 1)}] **************************');
          value = stdin.readLineSync();
          g.addRoot(value);
        } else {
          print(
              '                    ******* Entrer la valeur du noeud [${(i + 1)}] ******* ');
          value = stdin.readLineSync();
          g.addNode(value);
        }
      }

      nbreMaxArret = nbreSommets * (nbreSommets - 1) / 2;
      print(
          '*************************** les sommets du graphe sont: **************************************');
      for (int j = 0; j < g.tabSommet.length; j++) {
        stdout.write('[${g.tabSommet[j].value} ; ${g.tabSommet[j].index}] ');
      }

      stdout.write('\n');
      print(
          '           ************ Maintenant il faut creer les arretes ********       ');

      for (int i = 0; i < nbreMaxArret; i++) {
        print(
            '**********************************************************************************');
        print('Entrer la valeur du père');
        value1 = stdin.readLineSync();
        print('Entrer la valeur du fils');
        value2 = stdin.readLineSync();
        g.addEdge(value1, value2);
        do {
          print(
              '        ** voulez vous ajouter un nouveau arret oui = 1 non = 0 **           ');
          rep = int.parse(stdin.readLineSync());
        } while (rep != 0 && rep != 1);
        if (rep == 0) break;
      }
      print(
          '************************************ l\'Arbre entré est **************************************');
      g.printGraphe();
      print(
          '********************** le parcours en largeur de  l\'arbre est ********************************');
      List<String> parcours = g.breathFirstSearch(g.root.value);
      print(parcours);
      print(
          '*****************************le codage de l\'arbre est:****************************************');
      List<int> code = g.GloudEncoding(g.root.value);
      print(code);
      do {
        print(
            '*****************entrer le sommet dont vous volez connaitre le père ************************');
        String sommet = stdin.readLineSync();
        var index = Encoding.parentOfANode(g.getIndexInGraphe(sommet), code);
        for (var i = 0; i < g.tabSommet.length; i++) {
          if (g.tabSommet[i].indexInGraphe == index) {
            print('le père du sommet $sommet est ${g.tabSommet[i].value}');
          }
        }
        do {
          print(
              '**************** voulez vous connaitre le père d\'un autre sommet oui = 1 non = 0 **********');
          rep = int.parse(stdin.readLineSync());
        } while (rep != 0 && rep != 1);
      } while (rep == 1);

      do {
        print(
            '*****************entrer le sommet dont vous volez connaitre les enfants ********************');
        String sommet = stdin.readLineSync();
        List tabChildren =
            Encoding.getChildrenOfNode(code, g.getIndexInGraphe(sommet));
        stdout.write('les enfants de [$sommet] sont : ');
        for (var i = 0; i < tabChildren.length; i++) {
          for (var j = 0; j < g.tabSommet.length; j++) {
            if (g.tabSommet[j].indexInGraphe == tabChildren[i]) {
              stdout.write('[${g.tabSommet[j].value}] ');
            }
          }
        }
        stdout.write('\n');
        do {
          print(
              '**************** voulez vous connaitre les fils d\'un autre sommet oui = 1 non = 0 **********');
          rep = int.parse(stdin.readLineSync());
        } while (rep != 0 && rep != 1);
      } while (rep == 1);
      break;
    case 0:
      do {
        print(
            '******************* entrer le nombre de sommets de votre graphe **************************');
        nbreSommets = int.parse(stdin.readLineSync());
      } while (nbreSommets <= 0);
      Graph<String> g = new Graph<String>(nbreSommets, false);
      for (int i = 0; i < nbreSommets; i++) {
        print(
            '***************************entrer la valeur du noeud [${(i + 1)}] **************************');
        value = stdin.readLineSync();
        g.addNode(value);
      }

      nbreMaxArret = nbreSommets * (nbreSommets - 1) / 2;
      print(
          '*************************** le graphe entrer est **************************************');
      for (int j = 0; j < g.tabSommet.length; j++) {
        stdout.write('[${g.tabSommet[j].value} ; ${g.tabSommet[j].index}] ');
      }
      stdout.write('\n');
      for (int i = 0; i < nbreMaxArret; i++) {
        print(
            '**********************************************************************************');
        print('entrer la valeur du premier sommet');
        value1 = stdin.readLineSync();
        print('entrer la valeur du deuxieme sommet');
        value2 = stdin.readLineSync();
        g.addEdge(value1, value2);
        do {
          print(
              '**********voulez vous ajouter un nouveau arret oui = 1 non = 0*********************');
          rep = int.parse(stdin.readLineSync());
        } while (rep != 0 && rep != 1);
        if (rep == 0) break;
      }

      g.printGraphe();
      do {
        print(
            '*************************************entrer la recine**************************************');
        root = stdin.readLineSync();
        if (g.getIndex(root) == -1) {
          print(
              '*******************ce sommet n\'est pas inclu dans ce graphe****************************');
        }
      } while (g.getIndex(root) == -1);

      print(
          '*******************le parcours en largeur de  ce graphe est************************************');
      if (g.getIndex(root) != -1) {
        List<String> parcours = g.breathFirstSearch(root);
        print(parcours);

        List<int> code = g.GloudEncoding(root);
        print(code);
      }
      break;
    default:
  }

  // Graph<String> g = new Graph<String>(10, true);
  // g.addRoot("a");
  // g.addNode("b");
  // g.addNode("c");
  // g.addNode("d");
  // g.addNode("e");
  // g.addNode("f");
  // g.addNode("g");
  // g.addNode("h");
  // g.addNode("i");
  // g.addNode("j");

  // g.addEdge("a", "b");
  // g.addEdge("a", "c");
  // g.addEdge("a", "d");
  // g.addEdge("b", "e");
  // g.addEdge("b", "f");
  // g.addEdge("d", "g");
  // g.addEdge("d", "h");
  // g.addEdge("d", "i");
  // g.addEdge("h", "j");
  // g.printGraphe();
  // List<String> parcours = g.breathFirstSearch(g.root.value);
  // print(parcours);

  // List<int> code = g.GloudEncoding(g.root.value);
  // print(code);
  //stdout.write('les enfants de ${tabChildren[i]} sont :');
}
