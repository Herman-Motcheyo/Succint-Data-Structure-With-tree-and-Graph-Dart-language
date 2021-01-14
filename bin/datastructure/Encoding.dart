import '../util/Rank.dart';
import '../util/Select.dart';

class Encoding {
	
	static int parentOfANode(int k , List<int> S) {
		int y = Select.select1(S, k);
		int j = Rank.rank0(S, y);
		return j;
	}

	static List<int> getChildrenOfNode(List<int> S,int index){
    List tabChildren = <int>[];
		int y = Select.select0(S, index);
		int p = 1;
		for (int i = y; i < S.length; i++) {
			if (S[i] == 1) {	
        tabChildren.add(Rank.rank1(S,y+p));
				p++;
			}else{
				break;
			}
		}
    return tabChildren;
	}

}
