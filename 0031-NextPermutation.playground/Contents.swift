/*
 Implement next permutation, which rearranges numbers into the lexicographically next greater permutation of numbers.

 If such an arrangement is not possible, it must rearrange it as the lowest possible order (i.e., sorted in ascending order).

 The replacement must be in place and use only constant extra memory.

Example 1:
 Input: nums = [1,2,3]
 Output: [1,3,2]

Example 2:
 Input: nums = [3,2,1]
 Output: [1,2,3]

Example 3:
 Input: nums = [1,1,5]
 Output: [1,5,1]

Example 4:
 Input: nums = [1]
 Output: [1]

Constraints:
     1 <= nums.length <= 100
     0 <= nums[i] <= 100

 */
func nextPermutation(_ nums: inout [Int]) {

    // find the last value that is smaller that the next
    let i = (0..<nums.count-1).last(where: {nums[$0] < nums[$0+1] })
    
    if i != nil {
        
        // find the last value that is larger than i
        let ii = (i!+1..<nums.count).lastIndex(where: { nums[$0] > nums[i!] })!
        
        // swap
        nums.swapAt(i!, ii)
        
        // sort the end
        nums[(i!+1)...].sort()
        return
    }
    
    // else nothing found
    nums.sort()
}


var nums1 = [1,2]
nextPermutation(&nums1)
print(nums1, "[2,1]")

nums1 = [1,2,3]
nextPermutation(&nums1)
print(nums1, "[1,3,2]")

nums1 = [3,2,1]
nextPermutation(&nums1)
print(nums1, "[1,2,3]")

nums1 = [1,1,5]
nextPermutation(&nums1)
print(nums1, "[1,5,1]")

nums1 = [1]
nextPermutation(&nums1)
print(nums1)

nums1 = [1,3,2]
nextPermutation(&nums1)
print(nums1, "[2,1,3]")

nums1 = [1,3,4,5,3,8,9,2,2]
nextPermutation(&nums1)
print(nums1, "[1,3,4,5,3,9,2,2,8]")

/*
 Runtime: 16 ms Your runtime beats 79.49 % of swift submissions.
 Memory Usage: 14.5 MB
 */
