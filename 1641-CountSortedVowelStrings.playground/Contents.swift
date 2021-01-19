/*
 Given an integer n, return the number of strings of length n that consist only of vowels (a, e, i, o, u) and are lexicographically sorted.

 A string s is lexicographically sorted if for all valid i, s[i] is the same as or comes before s[i+1] in the alphabet.

 Example 1:
 Input: n = 1
 Output: 5
 Explanation: The 5 sorted strings that consist of vowels only are ["a","e","i","o","u"].

 Example 2:
 Input: n = 2
 Output: 15
 Explanation: The 15 sorted strings that consist of vowels only are
 ["aa","ae","ai","ao","au","ee","ei","eo","eu","ii","io","iu","oo","ou","uu"].
 Note that "ea" is not a valid string since 'e' comes after 'a' in the alphabet.

 Example 3:
 Input: n = 33
 Output: 66045

 Constraints:
     1 <= n <= 50

 */

func countVowelStrings(_ n: Int) -> Int {

    /* Combinations vs Permutations
       - With combinations the order is not important
       - With permutations the order is important.
 
      This is a combination problem because the vowels are sorted...
      ... meaning that when n=2 we care about "ae", but not "ea"
     
     Since we allow repeating vowels our problem is:
        "combination of n objects taken r at a time with repetition"
     or "Combinations with Repetition"
     
    */

    /* Lexicographically Sorted
     * The vowels part is irrelevant, think of integers 1 through 5
     * for n=2 the possibilities are:
     *                   11, 12, 13, 14, 15
     *                       22, 23, 24, 25
     *                           33, 34, 35
     *                               44, 45
     *                                   55
     */
     
     /* Formula (I googled)
        C = (n+r−1)! / r!(n−1)!
     
        NOTE: n is 5 (the vowels), the n function argument is r in the formula
     
        C = (5+n-1)! / (n!(5-1)!) simplifies to => (n+1)*(n+2)*(n+3)*(n+4) / 24
     
     */
     
    return ( (n+1) * (n+2) * (n+3) * (n+4)) / 24
}

print(countVowelStrings(1))
print(countVowelStrings(2))
print(countVowelStrings(33))

/*
 Runtime: 0 ms, Your runtime beats 100.00 % of swift submissions.
 Memory Usage: 14 MB, Your memory usage beats 16.67 % of swift submissions.
 */
