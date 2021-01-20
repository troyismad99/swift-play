/*
 Given a sorted array nums, remove the duplicates in-place such that each element appears only once and returns the new length.

 Do not allocate extra space for another array, you must do this by modifying the input array in-place with O(1) extra memory.

 Clarification:
 Confused why the returned value is an integer but your answer is an array?
 Note that the input array is passed in by reference, which means a modification to the input array will be known to the caller as well.
 Internally you can think of this:

 // nums is passed in by reference. (i.e., without making a copy)
 int len = removeDuplicates(nums);

 // any modification to nums in your function would be known by the caller.
 // using the length returned by your function, it prints the first len elements.
 for (int i = 0; i < len; i++) {
     print(nums[i]);
 }

 Example 1:
 Input: nums = [1,1,2]
 Output: 2, nums = [1,2]
 Explanation: Your function should return length = 2, with the first two elements of nums being 1 and 2 respectively. It doesn't matter what you leave beyond the returned length.

 Example 2:
 Input: nums = [0,0,1,1,1,2,2,3,3,4]
 Output: 5, nums = [0,1,2,3,4]
 Explanation: Your function should return length = 5, with the first five elements of nums being modified to 0, 1, 2, 3, and 4 respectively. It doesn't matter what values are set beyond the returned length.

 Constraints:
     0 <= nums.length <= 3 * 104
     -104 <= nums[i] <= 104
     nums is sorted in ascending order.
 */

func removeDuplicates(_ nums: inout [Int]) -> Int {

    // check that we have at least one integer
    guard nums.count > 0 else { return 0 }
    
    // two pointer approach
    // i  -> keeps the position of the last found unique value
    // ii -> iterates over the array
    
    var i = 0 // unique values start at the first position (index 0)
    
    // start at index 1 (second position)
    for ii in 1..<nums.count {
        
        // if they are not equal we have a new unique value
        if nums[i] != nums[ii] {
            i += 1
            nums[i] = nums[ii]
        }
    }
    
    return i + 1
}

var exampleOne = [1,1,2]
var exampleTwo = [0,0,1,1,1,2,2,3,3,4]

print(removeDuplicates(&exampleOne))
print(removeDuplicates(&exampleTwo))

print(exampleOne)
print(exampleTwo)

var exampleThree = [5]

print(removeDuplicates(&exampleThree))

/*
 Runtime: 60 ms Your runtime beats 95.82 % of swift submissions.
 Memory Usage: 14.7 MB Your memory usage beats 86.73 % of swift submissions.
 */

