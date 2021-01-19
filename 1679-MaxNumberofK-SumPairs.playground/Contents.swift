/*
 You are given an integer array nums and an integer k.

 In one operation, you can pick two numbers from the array whose sum equals k and remove them from the array.

 Return the maximum number of operations you can perform on the array.

Example 1:
 Input: nums = [1,2,3,4], k = 5
 Output: 2
 Explanation: Starting with nums = [1,2,3,4]:
 - Remove numbers 1 and 4, then nums = [2,3]
 - Remove numbers 2 and 3, then nums = []
 There are no more pairs that sum up to 5, hence a total of 2 operations.

Example 2:
 Input: nums = [3,1,3,4,3], k = 6
 Output: 1
 Explanation: Starting with nums = [3,1,3,4,3]:
 - Remove the first two 3's, then nums = [1,4,3]
 There are no more pairs that sum up to 6, hence a total of 1 operation.

Constraints:
     1 <= nums.length <= 105
     1 <= nums[i] <= 109
     1 <= k <= 109

 */

func maxOperations(_ nums: [Int], _ k: Int) -> Int {

    var operationCount = 0 // result
    
    // dictionary for our hashmap
    var integerMap: [Int: Int] = [:]
    
    for i in nums {
        
        // Hint 2: For each possible value x, it can be paired up with k - x.
        let pairedValue = k - i
        
        // have we tracked that paired value?
        let pairCount = integerMap[pairedValue, default: 0]
        
        if pairCount == 0 {
            // no pair in the map, add our value (or increment the counter for the value) and move on
            integerMap[i, default: 0] += 1
        }
        else {
            // we have a pair (an operation) so remove from the map
            integerMap[pairedValue] = pairCount - 1
            operationCount += 1
        }
    }
    
    return operationCount
}

print(maxOperations([1,2,3,4], 5))   // 2
print(maxOperations([3,1,3,4,3], 6)) // 1

print(maxOperations([37,55,12,99], 2)) // 0
print(maxOperations([1,9,9,1,2,2,3,4,7,7,7,7,7,7,6,9,8,99,3], 10)) //


/*
 Runtime: 924 ms, your runtime beats 75.61 % of swift submissions.
 Memory Usage: 18.5 MB, your memory usage beats 48.78 % of swift submissions.
 */
