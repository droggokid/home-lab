public class Solution { // O(n)
    public void MoveZeroes(int[] nums) {
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
    }
}