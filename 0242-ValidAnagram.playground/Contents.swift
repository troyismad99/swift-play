/*
 Given two strings s and t , write a function to determine if t is an anagram of s.

Example 1:
 Input: s = "anagram", t = "nagaram"
 Output: true

Example 2:
 Input: s = "rat", t = "car"
 Output: false

Note:
 You may assume the string contains only lowercase alphabets.

 Follow up:
 What if the inputs contain unicode characters? How would you adapt your solution to such case?
 */

func isAnagram(_ s: String, _ t: String) -> Bool {

    guard s.count == t.count else { return false}
    
    return s.sorted() == t.sorted()
}

print(isAnagram("anagram", "nagaram"))
print(isAnagram("rat", "car"))

print(isAnagram("rat", "ra"))

/*
 Runtime: 352 ms Your runtime beats 10.14 % of swift submissions.
 Memory Usage: 16.6 MB Your memory usage beats 9.58 % of swift submissions.
 */
