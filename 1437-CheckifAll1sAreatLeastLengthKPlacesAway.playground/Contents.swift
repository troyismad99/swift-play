/*
 Given an array nums of 0s and 1s and an integer k, return True if all 1's are at least k places away from each other, otherwise return False.

Example 1:
 Input: nums = [1,0,0,0,1,0,0,1], k = 2
 Output: true
 Explanation: Each of the 1s are at least 2 places away from each other.

Example 2:
 Input: nums = [1,0,0,1,0,1], k = 2
 Output: false
 Explanation: The second 1 and third 1 are only one apart from each other.

Example 3:
 Input: nums = [1,1,1,1,1], k = 0
 Output: true

Example 4:
 Input: nums = [0,1,0,1], k = 1
 Output: true

Constraints:
     1 <= nums.length <= 105
     0 <= k <= nums.length
     nums[i] is 0 or 1
 */
func kLengthApart(_ nums: [Int], _ k: Int) -> Bool {

    var lastOneIndex: Int?
    
    for i in 0..<nums.count {
        
        // we only care about the 1s
        if nums[i] == 1 {

            // is the first 1 we have found?
            if lastOneIndex == nil {
                lastOneIndex = i
            }
            else {
                
                // the distance between the two 1s...
                // ... the - 1 is to get the zero count
                if k > (i - lastOneIndex! - 1) {
                    return false
                }
                
                // this one is now the last one
                lastOneIndex = i
            }
        }
    }
    
    return true
}

print(kLengthApart([1,0,0,0,1,0,0,1], 2)) // true
print(kLengthApart([1,0,0,1,0,1], 2))     // false
print(kLengthApart([1,1,1,1,1], 0))       // true
print(kLengthApart([0,1,0,1], 1))         // true

print(kLengthApart([1,1,1,1,1], 2))

/*
 Runtime: 412 ms Your runtime beats 100.00 % of swift submissions.
 Memory Usage: 17.3 MB
 */
