public class Solution {
    public string LongestCommonPrefix(string[] strs) {
        if (strs == null || strs.Length == 0) {
            return "";
        }
        string firstWord = strs[0];
        int pre = firstWord.Length;
        for(int i = 0; i < pre; i++) {
            for(int k = 1; k < strs.Length; k++) {
                if (i >= strs[k].Length || firstWord[i] != strs[k][i]) {
                    pre = i;
                    break;
                }
            }
        }
        return firstWord.Substring(0, pre);
    }
}
