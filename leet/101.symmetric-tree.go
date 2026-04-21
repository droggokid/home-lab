package main

/*
 * @lc app=leetcode id=101 lang=golang
 *
 * [101] Symmetric Tree
 */

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

// @lc code=start
/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func isSymmetric(root *TreeNode) bool {
	if root == nil {
		return true
	}

	queueLeft := []*TreeNode{root.Left}
	queueRight := []*TreeNode{root.Right}

	for len(queueLeft) > 0 && len(queueRight) > 0 {
		x, y := queueLeft[0], queueRight[0]
		queueLeft = queueLeft[1:]
		queueRight = queueRight[1:]

		if x == nil && y == nil {
			continue
		} else if x == nil || y == nil {
			return false
		} else if x.Val != y.Val {
			return false
		} else {
			queueLeft = append(queueLeft, x.Left, x.Right)
			queueRight = append(queueRight, y.Right, y.Left)
		}
	}
	return true
}

// @lc code=end
