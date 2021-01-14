/*
 * 
 * rank b (S, k) function counts the number of elements b (most often bits) in the prefix of
 * an array S up to some index k. In other words, this function tells us the number of "b"
 * we have from the first position to k th position. Mathematically, this function is expressed
 * as follow:
 *         rank b (S, k) = |{i, i ∈ [1, k] and S[i] = b}|.
 *         */
class Rank {
  /*
	 * 
	 * return number of  0 in  K eme bit
	 * */
  static int rank0(List S, int k) {
    int rank = 0;

    if (k < 0 || k >= S.length) {
      print("invalid index position  $k ");
    }

    for (int i = 0; i < k; i++) {
      if (S[i] == 0) {
        rank++;
      }
    }
    return rank;
  }


  /*
	 * 
	 * return number of 1  in k eme bit
	 * */
  static int rank1(List S, int k) {
    int rank = 0;

    if (k < 0 || k >= S.length) {
      print("invalid index position  $k ");
    }

    for (int i = 0; i < k; i++) {
      if (S[i] == 1) {
        rank++;
      }
    }
    return rank;
  }
}
