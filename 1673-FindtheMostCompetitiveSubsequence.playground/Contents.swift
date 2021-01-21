/*
 Given an integer array nums and a positive integer k, return the most competitive subsequence of nums of size k.

 An array's subsequence is a resulting sequence obtained by erasing some (possibly zero) elements from the array.

 We define that a subsequence a is more competitive than a subsequence b (of the same length) if in the first position where a and b differ, subsequence a has a number less than the corresponding number in b. For example, [1,3,4] is more competitive than [1,3,5] because the first position they differ is at the final number, and 4 is less than 5.

 Example 1:
 Input: nums = [3,5,2,6], k = 2
 Output: [2,6]
 Explanation: Among the set of every possible subsequence: {[3,5], [3,2], [3,6], [5,2], [5,6], [2,6]}
              [2,6] is the most competitive.

 Example 2:
 Input: nums = [2,4,3,3,5,4,9,6], k = 4
 Output: [2,3,3,4]

 Constraints:
     1 <= nums.length <= 105
     0 <= nums[i] <= 109
     1 <= k <= nums.length

 */
func mostCompetitive(_ nums: [Int], _ k: Int) -> [Int] {

    guard nums.count > k else { return nums }
    
    var result: [Int] = []
    
    for (i, value) in nums.enumerated() {
        
        // look for a smaller number
        while (   !result.isEmpty
                && result.last! > value // new value is smaller than current last value
                && result.count - 1 + nums.count - i >= k //only while there are more than k elements in the array
              ) {
            // found a smaller so remove the last number
            result.removeLast()
        }
        
        // push the new smaller number (up to k elements)
        if result.count < k {
            result.append(value)
        }
        
    }
    
    return result
}

print(mostCompetitive([3,5,2,6], 2))
print(mostCompetitive([2,4,3,3,5,4,9,6], 4))

print(mostCompetitive([0,1], 1))
print(mostCompetitive([3,5], 2))
print(mostCompetitive([0,1,2,4,3,3,5,4,9,6,1], 5))

/*
 Runtime: 1948 ms Your runtime beats 42.86 % of swift submissions.
 Memory Usage: 21.2 MB Your memory usage beats 33.33 % of swift submissions.
 */
