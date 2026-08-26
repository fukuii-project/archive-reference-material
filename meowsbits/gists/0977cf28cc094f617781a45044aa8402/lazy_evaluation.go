package main

import (
	"time"
)

type LazyInt chan func() int

// Can't use pointer receiver: invalid operation: l <- (func literal) (send to non-chan type *LazyInt)
func (l LazyInt) Future(i int) {
	l <- func() int {
		time.Sleep(3 * time.Second)
		return i
	}
}

func (l LazyInt) Add(i int) {
	old := <-l
	l <- func() int { return old() + i }
}

func addLazily(x LazyInt, y LazyInt) int {
	return (<-x)() + (<-y)()
}

func main() {
	var i = 1
	var a = make(LazyInt, 1)
	var b = make(LazyInt, 1)
	a <- func() int { return i }
	b <- func() int { return i }
	sum := addLazily(a, b)
	println(sum)
	var c = make(LazyInt, 1)
	c.Future(5)
	c.Add(3)
	println((<-c)())
}
