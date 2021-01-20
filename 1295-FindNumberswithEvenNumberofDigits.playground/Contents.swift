/*
 Given an array nums of integers, return how many of them contain an even number of digits.

 Example 1:
 Input: nums = [12,345,2,6,7896]
 Output: 2
 Explanation:
 12 contains 2 digits (even number of digits).
 345 contains 3 digits (odd number of digits).
 2 contains 1 digit (odd number of digits).
 6 contains 1 digit (odd number of digits).
 7896 contains 4 digits (even number of digits).
 Therefore only 12 and 7896 contain an even number of digits.

 Example 2:
 Input: nums = [555,901,482,1771]
 Output: 1
 Explanation:
 Only 1771 contains an even number of digits.

 Constraints:
     1 <= nums.length <= 500
     1 <= nums[i] <= 10^5

 */

func evenDigits(_ num: Int) -> Bool {
    
    var digits = 0
    var n = num
    
    while n > 0 {
        n = n / 10
        digits += 1
    }
    
    return digits % 2 == 0
}

func findNumbers(_ nums: [Int]) -> Int {

    var theCount = 0
    
    for n in nums {
        if evenDigits(n) {
            theCount += 1
        }
    }
    
    return theCount
}

print(findNumbers([12,345,2,6,7896]))
print(findNumbers([555,901,482,1771]))

/*
 Runtime: 32 ms Your runtime beats 95.06 % of swift submissions.
 Memory Usage: 14.3 MB Your memory usage beats 23.87 % of swift submissions.
 */
