public class Solution {
    public int RemoveElement(int[] nums, int val) { // O(n)
        if (nums.Length == 0) return 0;
        int k = 0;
        for(int i = 0; i < nums.Length; i++) {
            if(nums[i] != val) {
                nums[k] = nums[i];
                k++;
            }
        }
        return k;
    }
}

public class Solution { // more effiecient also O(n)
    public int RemoveElement(int[] nums, int val) {
        int n = nums.Length;
        int k = 0;
        while (k < n) {
            if(nums[k] == val) {
                nums[k] = nums[n-1];
                n--;
            } else {
                k++;
            }
        }
        return k;
    }
}