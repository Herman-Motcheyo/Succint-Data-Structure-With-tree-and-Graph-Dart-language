import 'dart:collection';
import 'dart:io';

import 'Node.dart';

class Tree<T> {
  var cmpt = 0;
  var nbrVertex;
  List<List<Node<T>>> tab;
  List<Node<T>> tabSommet;
  bool tree;
  Node<T> root;

  Tree(int nbrVertex) {
    this.nbrVertex = nbrVertex;
    tab = new List<List<Node<T>>>();
    tabSommet = new List<Node<T>>();
    for (var i = 0; i < nbrVertex; i++) {
      tab.add(new List<Node<T>>());
    }
  }

  void addRoot(T root) {
    if (cmpt == 0) {
      this.root = new Node<T>();
      this.root.index = cmpt;
      this.root.value = root;
      this.tabSommet.add(this.root);
      this.cmpt += 1;
    } else if (this.tree == true) {
      addNode(root);
      print(
          'impossible d\'ajouter une nouvelle racine , la racine est: [ ${this.root.value} ]');
    } else {
      addNode(root);
    }
  }

  void addNode(T value) {
    if (cmpt == 0) {
      this.root = new Node<T>();
      this.root.index = cmpt;
      this.root.value = value;
      this.tabSommet.add(this.root);
      this.cmpt += 1;
    } else {
      Node<T> node = new Node<T>();
      node.index = cmpt;
      node.value = value;
      this.tabSommet.add(node);
      this.cmpt += 1;
    }
  }

  void printGraphe() {
    for (int i = 0; i < tabSommet.length; i++) {
      if (tabSommet[i].index == 0) {
        stdout.write('root: ${tabSommet[i].value} --->');
      } else {
        stdout.write('${tabSommet[i].value} --->');
      }
      for (int j = 0; j < tab[i].length; j++) {
        stdout.write(' ${tab[i][j].value}');
      }
      stdout.write('\n');
    }
  }

  int getIndexInGraphe(T nodeValue) {
    for (int i = 0; i < tabSommet.length; i++) {
      if (nodeValue == tabSommet[i].value) {
        return tabSommet[i].indexInGraphe;
      }
    }
    return -1;
  }

  List<Node<T>> getChildren(int index) {
    if (index > this.nbrVertex) {
      return null;
    } else {
      return this.tab[index];
    }
  }

  int getIndex(T node) {
    for (int i = 0; i < tabSommet.length; i++) {
      if (node == tabSommet[i].value) {
        return tabSommet[i].index;
      }
    }
    return -1;
  }

  void addEdge(T value1, T value2) {
    Node<T> temp1 = null;
    Node<T> temp2 = null;
    for (int i = 0; i < tabSommet.length; i++) {
      if (tabSommet[i].value == value1) temp1 = tabSommet[i];

      if (tabSommet[i].value == value2) temp2 = tabSommet[i];
    }

    // on verifie que les sommets entrer exitent et qu'il ne sont pas identiques
    if (temp1 != null && temp2 != null && temp1.index != temp2.index) {
      /*
			 * dans le cas d'un arbre la on verifie que la racine n'est pas le fils du
			 * sommet dont on veut creer la liaison
			 */
      if (temp2.index != this.root.index) {
        /*
				 * dans le cas d'un arbre on verifie que le fils qu'on passe en parametre n'est
				 * pas deja le père de celui qui est passé en paramètre
				 */
        if (this.tab[temp2.index].contains(temp1) == false) {
          /**
						 * on verifie si le fils qu'on veu inserer n'est pas deja contenu dans la liste
						 * des fils du nœud parent
						 */
          if (this.tab[temp1.index].contains(temp2) == false) {
            this.tab[temp1.index].add(temp2);
          }
        } else {
          print(
              'impossible de créer cette liaison [ ${temp1.value}] est deja le fils de [ ${temp2.value} ]');
        }
      } else {
        print(
            'la racine [ ${this.root.value} ] ne peut pas etre le fils d\'un sommet');
      }
    } else {
      print('impossible de créer cette liaison');
    }
  }

  List<T> breathFirstSearch(T root) {
    int indexRoot = getIndex(root);
    int index = 0;
    List<T> tabParcours = new List<T>();
    Queue<Node<T>> queue = new Queue<Node<T>>();
    if (indexRoot != -1) {
      queue.add(tabSommet[indexRoot]);
      tabSommet[indexRoot].marked = true;
      while (queue.isEmpty == false) {
        Node<T> temp = queue.removeFirst();
        index = getIndex(temp.value);
        tabSommet[index].marked = true;
        List<Node<T>> children = getChildren(index);
        for (Node<T> node in children) {
          if (node.marked == false) {
            queue.add(node);
            node.marked = true;
          }
        }
        tabParcours.add(temp.value);
      }
    }

    for (int i = 0; i < tabSommet.length; i++) {
      tabSommet[i].marked = false;
    }
    return tabParcours;
  }

  List<int> loudEncoding(T root) {
    int indexRoot = getIndex(root);
    int index = 0, cmpt = 1;
    List<int> tabCode = new List<int>();
    Queue<Node<T>> queue = new Queue<Node<T>>();
    if (indexRoot != -1) {
      tabCode.add(1);
      tabCode.add(0);
      queue.add(tabSommet[indexRoot]);
      tabSommet[indexRoot].indexInGraphe = cmpt;
      cmpt++;
      tabSommet[indexRoot].marked = true;
      while (queue.isEmpty == false) {
        Node<T> temp = queue.removeFirst();
        index = getIndex(temp.value);
        List<Node<T>> children = getChildren(index);
        for (Node<T> node in children) {
          node.indexInGraphe = cmpt;
          cmpt++;
          queue.add(node);
          node.marked = true;
          tabCode.add(1);
        }
        tabCode.add(0);
      }
    }
    for (int i = 0; i < tabSommet.length; i++) {
      tabSommet[i].marked = false;
    }
    return tabCode;
  }
}
