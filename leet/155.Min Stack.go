package main

type MinStack struct {
	stack    []int
	auxStack []int
}

func Constructor() MinStack {
	var stack, auxStack []int
	return MinStack{stack, auxStack}
}

func (s *MinStack) Push(val int) {
	if len(s.auxStack) == 0 || val <= s.auxStack[len(s.auxStack)-1] {
		s.auxStack = append(s.auxStack, val)
	} else {
		s.auxStack = append(s.auxStack, s.auxStack[len(s.auxStack)-1])
	}
	s.stack = append(s.stack, val)
}

func (s *MinStack) Pop() {
	s.stack = s.stack[:len(s.stack)-1]
	s.auxStack = s.auxStack[:len(s.auxStack)-1]
}

func (s *MinStack) Top() int {
	return s.stack[len(s.stack)-1]
}

func (s *MinStack) GetMin() int {
	return s.auxStack[len(s.auxStack)-1]
}

/**
 * Your MinStack object will be instantiated and called as such:
 * obj := Constructor();
 * obj.Push(val);
 * obj.Pop();
 * param_3 := obj.Top();
 * param_4 := obj.GetMin();
 */
