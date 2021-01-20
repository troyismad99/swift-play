/*
 Given a binary array, find the maximum number of consecutive 1s in this array.

 Example 1:
 Input: [1,1,0,1,1,1]
 Output: 3
 Explanation: The first two digits or the last three digits are consecutive 1s.
     The maximum number of consecutive 1s is 3.

 Note:
     The input array will only contain 0 and 1.
     The length of input array is a positive integer and will not exceed 10,000

 */
func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {

    var max = 0
    var theCount = 0
    
    for n in nums {
        
        // increment our counter while we find 1
        if n == 1 {
            theCount += 1
        }
        else {
            theCount = 0
        }

        // a new max?
        if theCount > max {
            max = theCount
        }

    }
    
    return max
}

print(findMaxConsecutiveOnes([1,1,0,1,1,1]))

print(findMaxConsecutiveOnes([0,0,0]))
print(findMaxConsecutiveOnes([1,1,1]))
print(findMaxConsecutiveOnes([0]))
print(findMaxConsecutiveOnes([1]))

/*
 Runtime: 264 ms Your runtime beats 44.85 % of swift submissions.
 Memory Usage: 14.5 MB Your memory usage beats 17.61 % of swift submissions.
 */
