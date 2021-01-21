/*
 Given an integer array nums sorted in non-decreasing order, return an array of the squares of each number sorted in non-decreasing order.

 Example 1:
 Input: nums = [-4,-1,0,3,10]
 Output: [0,1,9,16,100]
 Explanation: After squaring, the array becomes [16,1,0,9,100].
 After sorting, it becomes [0,1,9,16,100].

 Example 2:
 Input: nums = [-7,-3,2,3,11]
 Output: [4,9,9,49,121]

 Constraints:
     1 <= nums.length <= 104
     -104 <= nums[i] <= 104
     nums is sorted in non-decreasing order.
 
 Follow up: Squaring each element and sorting the new array is very trivial, could you find an O(n) solution using a different approach?
 
 */
func sortedSquares(_ nums: [Int]) -> [Int] {

    //guard !nums.isEmpty else { return [Int]() }
    
    // two pointer solution
    var result: [Int] = []
    var left = 0
    var right = 0
    
    // find first positive value
    while right < nums.count && nums[right] < 0 {
        right += 1
    }
    left = right - 1;
    
    while left >= 0 && right < nums.count {
        let leftSquare = nums[left] * nums[left]
        let rightSquare = nums[right] * nums[right]
        
        // append the smaller value and adjust that pointer
        if leftSquare < rightSquare {
            result.append(leftSquare)
            left -= 1
        }
        else {
            result.append(rightSquare)
            right += 1
        }
    }

    // we've reached one of the bounds, add the rest for the other bound
    if left >= 0 {
        for i in stride(from: left, through: 0, by:-1) {
            result.append(nums[i] * nums[i])
        }
    }
    else {
        for i in right..<nums.count {
            result.append(nums[i] * nums[i])
        }
    }
    
    return result
}

print(sortedSquares([-7,-3,2,3,11]))
print(sortedSquares([-4,-1,0,3,10]))

print(sortedSquares([-16, -7, -4, -3, 1, 2, 3, 5, 12, 15]))

/*
 Runtime: 256 ms Your runtime beats 88.14 % of swift submissions.
 Memory Usage: 15.7 MB Your memory usage beats 60.95 % of swift submissions.
 */
