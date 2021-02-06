import 'dart:collection';
import 'dart:core';

import 'dart:io';

import 'Node.dart';

class Graph<T> {
  var cmpt = 0;
  var nbrVertex;
  List<List<Node<T>>> tab;
  List<Node<T>> tabSommet;

  Graph(int nbrVertex) {
    this.nbrVertex = nbrVertex;
    tab = new List<List<Node<T>>>();
    tabSommet = new List<Node<T>>();
    for (var i = 0; i < nbrVertex; i++) {
      tab.add(new List<Node<T>>());
    }
  }

  void addNode(T value) {
    Node<T> node = new Node<T>();
    node.index = cmpt;
    node.value = value;
    this.tabSommet.add(node);
    this.cmpt += 1;
  }

  //dans le cas d'un graphe la value1 represente le père et value2 le fils
  void addEdge(T value1, T value2) {
    Node<T> temp1 = null;
    Node<T> temp2 = null;
    for (int i = 0; i < tabSommet.length; i++) {
      if (tabSommet[i].value == value1) temp1 = tabSommet[i];

      if (tabSommet[i].value == value2) temp2 = tabSommet[i];
    }
    // on verifie que les sommets entrer exitent et qu'il ne sont pas identiques
    if (temp1 != null && temp2 != null && temp1.index != temp2.index) {
      if (this.tab[temp2.index].contains(temp1) == false) {
        this.tab[temp2.index].add(temp1);
        this.tab[temp1.index].add(temp2);
      }
    } else {
      print("impossible de créer cette liaison");
    }
  }

  void printGraphe() {
    for (int i = 0; i < tabSommet.length; i++) {
      stdout.write('${tabSommet[i].value} --->');
      for (int j = 0; j < tab[i].length; j++) {
        stdout.write(' ${tab[i][j].value}');
      }
      stdout.write('\n');
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

  int getIndexInGraphe(T nodeValue) {
    for (int i = 0; i < tabSommet.length; i++) {
      if (nodeValue == tabSommet[i].value) {
        return tabSommet[i].indexInGraphe;
      }
    }
    return -1;
  }

  List<Node<T>> getNeighbors(int index) {
    if (index > this.nbrVertex) {
      return null;
    } else {
      return this.tab[index];
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
        List<Node<T>> neigbhors = getNeighbors(index);
        for (Node<T> node in neigbhors) {
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

  List<int> GloudEncoding(T root) {
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
        List<Node<T>> neigbhors = getNeighbors(index);
        for (Node<T> node in neigbhors) {
          if (node.marked == false) {
            node.indexInGraphe = cmpt;
            cmpt++;
            queue.add(node);
            node.marked = true;
            tabCode.add(1);
          } else {
            tabCode.add(2);
          }
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
