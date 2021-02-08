/*
 Given an Iterator class interface with methods: next() and hasNext(), design and implement a PeekingIterator that support the peek() operation -- it essentially peek() at the element that will be returned by the next call to next().

 Example:
 Assume that the iterator is initialized to the beginning of the list: [1,2,3].

 Call next() gets you 1, the first element in the list.
 Now you call peek() and it returns 2, the next element. Calling next() after that still return 2.
 You call next() the final time and it returns 3, the last element.
 Calling hasNext() after that should return false.

 Follow up: How would you extend your design to be generic and work with all types, not just integer?
 */

// Swift IndexingIterator refernence:
// https://developer.apple.com/documentation/swift/indexingiterator

class PeekingIterator {
    
    private var elements: IndexingIterator<Array<Int>>
    private var currentElement: Int?
    
    init(_ arr: IndexingIterator<Array<Int>>) {
        elements = arr
        currentElement = elements.next()
    }
    
    func next() -> Int {
        let returnElement = currentElement
        currentElement = elements.next()
        return returnElement ?? 0
    }
    
    /*
     func next() -> Int {
         defer {
             self.current = self.arr.next()
         }
         return current!
     }
     */
    
    func peek() -> Int {
        return currentElement ?? 0
    }
    
    func hasNext() -> Bool {
        return currentElement != nil
    }
}

/**
 * Your PeekingIterator object will be instantiated and called as such:
 * let obj = PeekingIterator(arr)
 * let ret_1: Int = obj.next()
 * let ret_2: Int = obj.peek()
 * let ret_3: Bool = obj.hasNext()
 */

var ii: IndexingIterator<[Int]> = [1,2,3].makeIterator()
let obj = PeekingIterator(ii)
print(obj.next())
print(obj.peek())
print(obj.next())
print(obj.hasNext())
print(obj.next())
print(obj.hasNext())
print(obj.next())

/*
 Runtime: 8 ms Your runtime beats 79.31 % of swift submissions.
 Memory Usage: 14.9 MB
 */


