/*
 * select b (S, k) function gives the position of the k th b. In other words, select b (S, k) gives
 * the minimum i such that rank b (S, i) = k. Mathematically, this function is expressed as
 * follow:
 * 
 *  select b (S, k) = min i {i ∈ [1, |S|], (rank b (S, i) = k)}.
 * */
class Select {
  /*
	 * 
	 * return index of 0 in  Keme bit 
	 * */
  // ignore: missing_return
  static int select0(List S, int k) {
    int select = 0;
    if (k < 0 || k >= S.length) {
      return -1;
    }
    for (int i = 0; i < S.length; i++) {
      if (S[i] == 0) select++;
      if (select == k) return i+1;
    }
    return -1;
  }
  /*
	 * 
	 * return number of 1  in k eme bit 
	 * */
  static int select1(List S, int k) {
    int select = 0;
    if (k < 0 || k >= S.length) {
      return -1;
    }
    for (int i = 0; i < S.length; i++) {
      if (S[i] == 1) {
        select++;
      }
      if (select == k) {
        return i+1;
      }
    }
    return -1;
  }

}
