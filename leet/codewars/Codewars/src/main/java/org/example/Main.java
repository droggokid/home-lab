package org.example;

import java.util.LinkedList;
import java.util.Queue;

public class Main {


    public static void main(String[] args) {
        int[] nums = {1, 2, 3, 4, 5};
        System.out.println(nums[4]);
    }

    class Pair {
        int row, col;
        Pair(int r, int c) { row = r; col = c; }
    }


    public int numIslands(char[][] grid) {
        if (grid == null) {
            return 0;
        }
        int islands = 0;
        int rows = grid.length;
        int columns = grid[0].length;
        boolean[][] visited = new boolean[rows][columns];
        Queue<Pair> queue = new LinkedList<>();

        for (int i = 0; i < rows; i++) {
            for (int p = 0; p < columns; p++) {
                if (!visited[i][p] && grid[i][p] == '1') {
                    visited[i][p] = true;
                    queue.offer(new Pair(i,p));
                    while(!queue.isEmpty()) {
                        Pair location = queue.poll();
                        int[] dr = {-1,1,0,0};
                        int[] dc = {0,0,-1,1};
                        for (int d = 0; d < 4; d++) {
                            int newRow = location.row + dr[d];
                            int newColumn = location.col + dc[d];
                            if (newRow >= 0 && newRow < rows && newColumn >= 0 &&
                                    newColumn < columns && grid[newRow][newColumn] == '1' &&
                                    !visited[newRow][newColumn]) {
                                queue.offer(new Pair(newRow, newColumn));
                                visited[newRow][newColumn] = true;
                            }
                        }
                    }
                    islands++;
                }
            }
        }
        return islands;
    }


/*    public int[][] merge(int[][] intervals) {
        Arrays.sort(intervals, Comparator.comparingInt(a -> a[0]));
        List<int[]> merged = new ArrayList<>();
        int[] current = intervals[0];
        for (int i = 1; i < intervals.length; i++) {
            if (intervals[i][0] <= current[1]) {
                current[1] = Math.max(current[1], intervals[i][1]);
            } else {
                merged.add(current);
                current = intervals[i];
            }
        }
        merged.add(current);
        return merged.toArray(new int[merged.size()][]);
    }
*)
//    public int compress(char[] chars) {
//        int read = 0;
//        int write = 0;
//        while (read < chars.length) {
//            int start = read;
//
//            while (read < chars.length && chars[start] == chars[read]) {
//                read++;
//            }
//
//            int length = read - start;
//
//            chars[write] = chars[start];
//            write++;
//
//            if (length > 1) {
//                for (char c : String.valueOf(length).toCharArray()) {
//                    chars[write] = c;
//                    write++;
//                }
//            }
//        }
//        return write;
//    }

//    public class ListNode {
//        int val;
//        ListNode next;
//        ListNode() {}
//        ListNode(int val) { this.val = val; }
//        ListNode(int val, ListNode next) { this.val = val; this.next = next; }
//    }
//
//    class Solution {
//        public ListNode addTwoNumbers(ListNode l1, ListNode l2) {
//            ListNode head = new ListNode(0);
//            ListNode current = head;
//            int carry = 0;
//
//            while (l1 != null || l2 != null || carry != 0) {
//                int x = (l1 != null) ? l1.val : 0;
//                int y = (l2 != null) ? l2.val : 0;
//
//                int sum = x + y + carry;
//                carry = sum / 10;
//                current.next = new ListNode(sum % 10);
//
//                current = current.next;
//
//                if (l1 != null) l1 = l1.next;
//                if (l2 != null) l2 = l2.next;
//            }
//            return head.next;
//        }
//    }


    /*public static String createPhoneNumber(int[] numbers) {
        String prefix = "";
        String mid = "";
        String end = "";
        for(int i = 0; i < 10; i++){
            int nr = numbers[i];
            if(i < 3) {
                prefix = prefix.concat(String.valueOf(nr));
            } else if (i < 5) {
                mid = mid.concat(String.valueOf(nr));
            } else {
                end = end.concat(String.valueOf(nr));
            }

            return String.format("(%s) %s-%s", prefix, mid, end);
        }
    }*/

    /*public static String makeReadable(int seconds) {
        Duration duration = Duration.ofSeconds(seconds);
        int hours = (int) duration.toHours()% 100;
        int minutes = (int) duration.toMinutes() % 60;
        int second = (int) duration.toSeconds() % 60;
        return String.format("%02d:%02d:%02d", hours, minutes, second);
    }*/

    /*public static int sumIntervals(int[][] intervals) {
        if (intervals == null || intervals.length == 0) return 0;

        Arrays.sort(intervals, (a, b) -> Integer.compare(a[0], b[0]));

        int sum = 0;
        int[] current = intervals[0];

        for(int i = 1; i < intervals.length; i++) {
            if(intervals[i][0] <= current[1]) {
                current[1] = Math.max(current[1], intervals[i][1]);
            } else {
                sum += current[1] - current[0];
                current = intervals[i];
            }
        }
        sum += current[1] - current[0];

        return sum;
    }*/

    // tic tac toe
    /*public static int isSolved(int[][] board) {
        boolean isZero = false;
        int[] columnArray = new int[board.length];
        int[] mainDiagonalArray = new int[board.length];
        int[] secondDiagonalArray = new int[board.length];
        int[] xArray = new int[]{1,1,1};
        int[] oArray = new int[]{2,2,2};

        for(int i = 0; i < board.length; i++) {
            mainDiagonalArray[i] = board[i][i];
            secondDiagonalArray[i] = board[i][board.length-1-i];
            if(Arrays.equals(board[i], xArray)) {
                return 1;
            } else if (Arrays.equals(board[i], oArray)) {
                return 2;
            }

            for(int j = 0; j < board[i].length; j++) {
                columnArray[j] = board[j][i];
                if(board[i][j] == 0) {
                    isZero = true;
                }
            }
            if (Arrays.equals(columnArray, xArray)) {
                return 1;
            } else if (Arrays.equals(columnArray, oArray)) {
                return 2;
            }
        }

        if (Arrays.equals(mainDiagonalArray, xArray)) {
            return 1;
        } else if (Arrays.equals(mainDiagonalArray, oArray)) {
            return 2;
        }
        if (Arrays.equals(secondDiagonalArray, xArray)) {
            return 1;
        } else if(Arrays.equals(secondDiagonalArray, oArray)) {
            return 2;
        }
        return isZero ? -1 : 0;
    }*/

    // string to camel case
    /*public static String camelCase(String str) {
        if(str == null || str == ""){
            return "";
        }
        str = str.trim().replaceAll("\\s+", " ");
        String[] res = str.split(" ");
        StringBuilder result = new StringBuilder();
        for(int i = 0; i < res.length; i++){
            result.append(res[i].substring(0, 1).toUpperCase()).append(res[i].substring(1));
        }
        return result.toString();
    }*/
}