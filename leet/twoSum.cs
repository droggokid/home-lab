public class Solution { // brute force
    public int[] TwoSum(int[] nums, int target) {
        for(int i = 0; i < nums.Length; i++) {
            for(int p = 0; p < nums.Length; p++) {
                if(nums[i] + nums[p] == target && i != p) {
                    return new int[] { i, p };
                }

            }
        }
        return null;
    }
}

using System.Collections.Generic;
public class Solution {
    public int[] TwoSum(int[] nums, int target) {
        List<int> list = nums.ToList<int>();

        foreach (int x in list) {
            if (list.Contains(target - x)) {
                int index1 = list.IndexOf(x);
                int index2 = list.IndexOf(target - x);
                
                if (index1 != index2) {
                    return new int[] { index1, index2 };
                }
            }
        }
        return null; 
    }
}
