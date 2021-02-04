/*
 We define a harmonious array as an array where the difference between its maximum value and its minimum value is exactly 1.

 Given an integer array nums, return the length of its longest harmonious subsequence among all its possible subsequences.

 A subsequence of array is a sequence that can be derived from the array by deleting some or no elements without changing the order of the remaining elements.

Example 1:
 Input: nums = [1,3,2,2,5,2,3,7]
 Output: 5
 Explanation: The longest harmonious subsequence is [3,2,2,2,3].

Example 2:
 Input: nums = [1,2,3,4]
 Output: 2

Example 3:
 Input: nums = [1,1,1,1]
 Output: 0

 Constraints:
     1 <= nums.length <= 2 * 104
     -109 <= nums[i] <= 109

 */
func findLHS(_ nums: [Int]) -> Int {

    // make sure we have at least 2 elements
    guard nums.count > 1 else { return 0 }
    
    var result = 0
    
    // since order is not important we can map the distribution of values
    var numDistribution = [Int:Int]()
    
    for n in nums {
        
        // count how many times this value occurs
        numDistribution[n, default:0] += 1
    
        // check the count of the number above
        if let nAbove = numDistribution[n+1] {
            result = max(result, nAbove + numDistribution[n]!)
        }
        
        // check the number below
        if let nBelow = numDistribution[n-1] {
            result = max(result, nBelow + numDistribution[n]!)
        }
    }
    
    return result
}

print(findLHS([1,3,2,2,5,2,3,7]))
print(findLHS([1,2,3,4]))
print(findLHS([1,1,1,1]))

print(findLHS([]))
print(findLHS([1]))
print(findLHS([1,2]))

/*
 Runtime: 464 ms Your runtime beats 30.00 % of swift submissions.
 Memory Usage: 14.5 MB Your memory usage beats 80.00 % of swift submissions.
 */
