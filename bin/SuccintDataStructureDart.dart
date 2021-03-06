import 'dart:io';

import 'datastructure/Encoding.dart';
import 'datastructure/Graph.dart';
import 'datastructure/Tree.dart';

void main(List<String> arguments) {
  var choice;
  var nbreSommets = 0, nbreMaxArret;
  String value, value1, value2, root;
  int rep = 1;
  var reponse;
  do {
    print(
        '                         ****************Bienvenue sur le Tp301 Succint DataStructure Groupe 24**************');
    print(
        '\n                                                SUCCINT DATA STRUCTURE   Dart                          ');
    print(
        '\n                                                ********* 1 Arbre   *********  ');
    print(
        '                                                ********* 2 Graphe  ********* ');
    print(
        '\n             /// Faites un choix  svp 1 = arbre et 2 = graphe// \t ');

    choice = int.parse(stdin.readLineSync());
    switch (choice) {
      case 1:
        do {
          print(
              '                                                ********* Arbre  ********* \n');

          do {
            print(
                '******************* Entrer le nombre de sommets de votre Arbre **************************');
            nbreSommets = int.parse(stdin.readLineSync());
          } while (nbreSommets <= 0);
          Tree<String> tree = new Tree<String>(nbreSommets);
          for (int i = 0; i < nbreSommets; i++) {
            if (i == 0) {
              print(
                  '************************ Entrer la valeur de la racine [${(i + 1)}] **************************');
              value = stdin.readLineSync();
              tree.addRoot(value);
            } else {
              print(
                  '                    ******* Entrer la valeur du noeud [${(i + 1)}] ******* ');
              value = stdin.readLineSync();
              tree.addNode(value);
            }
          }

          nbreMaxArret = nbreSommets * (nbreSommets - 1) / 2;
          print(
              '*************************** Les sommets du graphe sont: **************************************');
          for (int j = 0; j < tree.tabSommet.length; j++) {
            stdout.write('[${tree.tabSommet[j].value}] ');
          }

          stdout.write('\n');
          print(
              '  \n         ************ Maintenant il faut creer les arretes ********      \n ');

          for (int i = 0; i < nbreMaxArret; i++) {
            print('Entrer la valeur du père');
            value1 = stdin.readLineSync();
            print('Entrer la valeur du fils');
            value2 = stdin.readLineSync();
            tree.addEdge(value1, value2);
            do {
              print(
                  '        ** voulez vous ajouter un nouveau arret oui = 1 non = 0 **           ');
              rep = int.parse(stdin.readLineSync());
            } while (rep != 0 && rep != 1);
            if (rep == 0) break;
          }
          print(
              '                          **** Representation de l\' Arbre sous forme de Liste d \' adjascence ****                        \n  ');
          tree.printGraphe();
          print(
              '\n********************** Le Parcours en largeur de  l\'arbre est ********************************');
          List<String> parcours = tree.breathFirstSearch(tree.root.value);
          print('              $parcours  ');
          print(
              '*****************************Le codage de l\'arbre avec Lound Encoding est:********************');

          List<int> code = tree.loudEncoding(tree.root.value);
          print('              $code              ');
          print(
              "  \n              **Operation à effectuer sur  l 'arbre n- aire**");
          print('                   1- Parent d\' un noeud            ');
          print('                   2- Les enfants d\' un noeud            ');
          choice = int.parse(stdin.readLineSync());
          switch (choice) {
            case 1:
              do {
                print(
                    '*****************Entrer le sommet dont vous volez connaitre le père ************************');
                String sommet = stdin.readLineSync();
                var index =
                    Encoding.parentOfANode(tree.getIndexInGraphe(sommet), code);
                for (var i = 0; i < tree.tabSommet.length; i++) {
                  if (tree.tabSommet[i].indexInGraphe == index) {
                    print(
                        'le père du sommet $sommet est ${tree.tabSommet[i].value}');
                  }
                }
                do {
                  print(
                      '** voulez vous connaitre le père d\'un autre sommet oui = 1 non = 0 **');
                  rep = int.parse(stdin.readLineSync());
                } while (rep != 0 && rep != 1);
              } while (rep == 1);

              break;

            case 2:
              do {
                print(
                    '   *** Entrer le sommet dont vous volez connaitre les enfants *** ');
                String sommet = stdin.readLineSync();
                List tabChildren = Encoding.getChildrenOfNode(
                    code, tree.getIndexInGraphe(sommet));
                stdout.write('les enfants de [$sommet] sont : ');
                for (var i = 0; i < tabChildren.length; i++) {
                  for (var j = 0; j < tree.tabSommet.length; j++) {
                    if (tree.tabSommet[j].indexInGraphe == tabChildren[i]) {
                      stdout.write('[${tree.tabSommet[j].value}] ');
                    }
                  }
                }
                stdout.write('\n');
                do {
                  print(
                      ' ** voulez vous connaitre les fils d\'un autre sommet oui = 1 non = 0 **');
                  rep = int.parse(stdin.readLineSync());
                } while (rep != 0 && rep != 1);
              } while (rep == 1);
              break;
            default:
              print('choix incorrect');
              break;
          }
          print(
              ' ** voulez vous continuer à evaluer ce module sur l\'arbre ?? oui = 1 non = 0 **');
          rep = int.parse(stdin.readLineSync());
        } while (rep != 0);
        break;
      case 2:
        print(
            '                                       ********* Graphe  ********* \n');
        do {
          print(
              '              ** Entrer le nombre de sommets de votre graphe **');
          nbreSommets = int.parse(stdin.readLineSync());
        } while (nbreSommets <= 0);
        Graph<String> g = new Graph<String>(nbreSommets);
        for (int i = 0; i < nbreSommets; i++) {
          print('   Entrer la valeur du noeud [${(i + 1)}] ');
          value = stdin.readLineSync();
          g.addNode(value);
        }

        nbreMaxArret = nbreSommets * (nbreSommets - 1) / 2;
        print('                    ** Les sommets entres sont **');
        for (int j = 0; j < g.tabSommet.length; j++) {
          stdout.write('[${g.tabSommet[j].value}] ');
        }
        stdout.write('\n');
        for (int i = 0; i < nbreMaxArret; i++) {
          print(
              '**********************************************************************************');
          print('Entrer la valeur du premier sommet');
          value1 = stdin.readLineSync();
          print('Entrer la valeur du deuxieme sommet');
          value2 = stdin.readLineSync();
          g.addEdge(value1, value2);
          do {
            print('**voulez vous ajouter un nouveau arret oui = 1 non = 0**');
            rep = int.parse(stdin.readLineSync());
          } while (rep != 0 && rep != 1);
          if (rep == 0) break;
        }

        g.printGraphe();
        do {
          print('********* Entrer la racine *********');
          root = stdin.readLineSync();
          if (g.getIndex(root) == -1) {
            print('****Ce sommet n\'est pas inclu dans ce graphe****');
          }
        } while (g.getIndex(root) == -1);

        print('****Le parcours en largeur de  ce graphe est****');
        if (g.getIndex(root) != -1) {
          List<String> parcours = g.breathFirstSearch(root);
          print(parcours);
          print(
              '                     ****Le Codage de ce graphe avec Glound est ****');
          List<int> code = g.GloudEncoding(root);
          print(code);
        }
        break;
      default:
        break;
    }
    print('Voulez vous revenir au menu principal ? (1= oui et 0 = non)');
    reponse = int.parse(stdin.readLineSync());
  } while (reponse != 0);
}
