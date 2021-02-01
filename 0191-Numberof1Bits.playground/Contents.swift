/*
 Write a function that takes an unsigned integer and returns the number of '1' bits it has (also known as the Hamming weight).
 
 https://en.wikipedia.org/wiki/Hamming_weight
 
 Note:
     Note that in some languages such as Java, there is no unsigned integer type. In this case, the input will be given as a signed integer type. It should not affect your implementation, as the integer's internal binary representation is the same, whether it is signed or unsigned.
     In Java, the compiler represents the signed integers using 2's complement notation. Therefore, in Example 3 above, the input represents the signed integer. -3.

 Follow up: If this function is called many times, how would you optimize it?

Example 1:
 Input: n = 00000000000000000000000000001011
 Output: 3
 Explanation: The input binary string 00000000000000000000000000001011 has a total of three '1' bits.

Example 2:
 Input: n = 00000000000000000000000010000000
 Output: 1
 Explanation: The input binary string 00000000000000000000000010000000 has a total of one '1' bit.

Example 3:
 Input: n = 11111111111111111111111111111101
 Output: 31
 Explanation: The input binary string 11111111111111111111111111111101 has a total of thirty one '1' bits.

  

Constraints:
     The input must be a binary string of length 32
 */
func hammingWeight(_ n: Int) -> Int {

    // easy peasy, but probably not what they are looking for
    return n.nonzeroBitCount
    
    /*
     Runtime: 12 ms Your runtime beats 21.37 % of swift submissions.
     Memory Usage: 13.3 MB Your memory usage beats 99.24 % of swift submissions.
     */
    
    
    /*
    // brute force
    var oneCountBrute = 0
    var bitNumber = n
    
    for _ in 0..<32 {
        // and the number with 1 to check the right most bit
        let bit = bitNumber & 1
        
        // add the result, either 0 or 1
        oneCountBrute += bit

        // shift our number
        bitNumber >>= 1
    }
    
    return oneCountBrute
     */
    
    // this is probably what they are looking for    
    var oneCount = 0
    var n = n
    
    while n > 0 {
        
        // this will remove the rightmost 1 from the binary representation
        n &= n - 1
        oneCount += 1
    }
    
    return oneCount
    /*
     Runtime: 4 ms Your runtime beats 90.08 % of swift submissions.
     Memory Usage: 13.6 MB Your memory usage beats 63.36 % of swift submissions.
     */
}

print(hammingWeight(11))

print(hammingWeight(128))

print(hammingWeight(4294967293))
