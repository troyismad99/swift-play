/*
 You are given an array nums of n positive integers.

 You can perform two types of operations on any element of the array any number of times:
     If the element is even, divide it by 2.
         For example, if the array is [1,2,3,4], then you can do this operation on the last element, and the array will be [1,2,3,2].
     If the element is odd, multiply it by 2.
         For example, if the array is [1,2,3,4], then you can do this operation on the first element, and the array will be [2,2,3,4].

 The deviation of the array is the maximum difference between any two elements in the array.

 Return the minimum deviation the array can have after performing some number of operations.

Example 1:
 Input: nums = [1,2,3,4]
 Output: 1
 Explanation: You can transform the array to [1,2,3,2], then to [2,2,3,2], then the deviation will be 3 - 2 = 1.

Example 2:
 Input: nums = [4,1,5,20,3]
 Output: 3
 Explanation: You can transform the array after two operations to [4,2,5,5,3], then the deviation will be 5 - 2 = 3.

Example 3:
 Input: nums = [2,10,8]
 Output: 3

Constraints:
     n == nums.length
     2 <= n <= 105
     1 <= nums[i] <= 109
 
Hint 1:
 Assume you start with the minimum possible value for each number so you can only multiply a number by 2 till it reaches its maximum possible value.

Hint 2:
 If there is a better solution than the current one, then it must have either its maximum value less than the current maximum value, or the minimum value larger than the current minimum value.

 Hint 3:
 Since that we only increase numbers (multiply them by 2), we cannot decrease the current maximum value, so we must multiply the current minimum number by 2.
 
 */
func minimumDeviation(_ nums: [Int]) -> Int {

    /*
     Fantastic problem analysis by YueZoeLi on leetcode (Title: Mathematical solution, reduced complexity)
     https://leetcode.com/problems/minimize-deviation-in-array/discuss/952990/Mathematical-solution-reduced-complexity
     Swift interpretation of his python solution
     */
    
    // Step 1 -> Find the maximal odd factor
    var maxOdd = 0
    
    // only the even numbers get smaller
    for i in nums {
        var ii = i
        while ii % 2 == 0 {
            ii = ii / 2
        }
        maxOdd = max(maxOdd, ii)
    }

    // Step 2 -> Calculating the [(xi, yi)] list
    /*
     dev = []
     for i in nums:
         if i%2 == 1:
             if 2*i>max_odd:
                 dev.append((2*i-max_odd, max_odd-i))
             else:
                 dev.append((float('inf'), max_odd-2*i))
         else:
             if i < max_odd:
                 dev.append((float('inf'), max_odd-i))
             else:
                 while i%2==0 and i>max_odd:
                     i = i//2
                 if i < max_odd:
                     dev.append((2*i-max_odd, max_odd-i))
     */
    var pairsList: [(Int, Int)] = []
    
    for i in nums {
        
        if i % 2 == 1 {
            if 2 * i > maxOdd {
                pairsList.append((2 * i - maxOdd, maxOdd - i))
            }
            else {
                pairsList.append((Int.max, maxOdd - 2 * i))
            }
        }
        else {
            if i < maxOdd {
                pairsList.append((Int.max, maxOdd - i))
            }
            else {
                var j = i
                while j % 2 == 0 && j > maxOdd {
                    j = j / 2
                }
                
                if j < maxOdd {
                    pairsList.append((2 * j - maxOdd, maxOdd - j))
                }
            }
        }
    }
    
    // Step 3 -> Minimal sum of picked xi's and yi's
    /*
     dev.sort(reverse=True)
     if not dev: return 0
     max_down = [0] * len(dev)
     cur = 0
     for i in range(len(max_down)):
         cur = max(cur, dev[i][1])
         max_down[i] = cur
     mm = min(max_down[-1], dev[0][0])
     for i in range(len(max_down)-1):
         mm = min(mm
     */

    pairsList.sort{ $0 > $1}

    if pairsList.count == 0 {
        return 0
    }
 
    var maxDown = Array(repeating: 0, count: pairsList.count)
    var cur = 0
    
    for i in 0..<maxDown.count {
        cur = max(cur, pairsList[i].1)
        maxDown[i] = cur
    }

    var mm = min(maxDown.last!, pairsList[0].0)

    for i in 0..<maxDown.count - 1 {
        // guard against an overflow
        if pairsList[i+1].0 == Int.max { continue }
        mm = min(mm, maxDown[i] + pairsList[i+1].0)
    }
    
    return mm
}

print(minimumDeviation([1,2,3,4]))
print(minimumDeviation([4,1,5,20,3]))
print(minimumDeviation([2,10,8]))

/*
 Runtime: 2708 ms
 Memory Usage: 19.3 MB
 
 Sorry. We do not have enough accepted submissions to show distribution chart.
 */
