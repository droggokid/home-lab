public class Solution {
    public int[] ApplyOperations(int[] nums) { // O(n)
        for(int i = 0; i < nums.Length-1; i++) {
            if(nums[i] == nums[i+1]) {
                nums[i] = nums[i] * 2;
                nums[i+1] = 0;
            }
        }
        int m = 0;
        for(int i = 0; i < nums.Length; i++) {
            if(nums[i] != 0) {
                nums[m] = nums[i];
                m++;
            }
        }
        for(int k = m; k < nums.Length; k++){
            nums[k] = 0;
        }
        return nums;
    }
}