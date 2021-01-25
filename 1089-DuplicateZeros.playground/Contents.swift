/*
 Given a fixed length array arr of integers, duplicate each occurrence of zero, shifting the remaining elements to the right.

 Note that elements beyond the length of the original array are not written.

 Do the above modifications to the input array in place, do not return anything from your function.

 Example 1:
 Input: [1,0,2,3,0,4,5,0]
 Output: null
 Explanation: After calling your function, the input array is modified to: [1,0,0,2,3,0,0,4]

Example 2:
 Input: [1,2,3]
 Output: null
 Explanation: After calling your function, the input array is modified to: [1,2,3]

Note:
     1 <= arr.length <= 10000
     0 <= arr[i] <= 9
 */

func duplicateZeros(_ arr: inout [Int]) {

    var i = 0
    let theCount = arr.count
    
    while i < theCount {
        
        if arr[i] == 0 {
            arr.removeLast()
            arr.insert(0, at: i)
            
            // an extra increment here to skip the newly inserted 0
            i += 1
        }
        
        i += 1
    }
    
}

var ex1 = [1,0,2,3,0,4,5,0]
duplicateZeros(&ex1)
print(ex1)

var ex2 = [1,2,3]
duplicateZeros(&ex2)
print(ex2)

/*
 Runtime: 36 ms Your runtime beats 91.96 % of swift submissions.
 Memory Usage: 14.9 MB Your memory usage beats 26.63 % of swift submissions.
 */
