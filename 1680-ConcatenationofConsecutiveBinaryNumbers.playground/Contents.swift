/*
Given an integer n, return the decimal value of the binary string formed by concatenating the binary representations of 1 to n in order, modulo 109 + 7.

Example 1:
 Input: n = 1
 Output: 1
 Explanation: "1" in binary corresponds to the decimal value 1.

Example 2:
 Input: n = 3
 Output: 27
 Explanation: In binary, 1, 2, and 3 corresponds to "1", "10", and "11".
 After concatenating them, we have "11011", which corresponds to the decimal value 27.

Example 3:
 Input: n = 12
 Output: 505379714
 Explanation: The concatenation results in "1101110010111011110001001101010111100".
 The decimal value of that is 118505380540.
 After modulo 10^9 + 7, the result is 505379714.

Constraints:
     1 <= n <= 105

 */
func concatenatedBinary(_ n: Int) -> Int {

    // modulo 10^9 + 7
    let bigPrime = 1000000007
    /*
     Modulo with a ten digit prime number.
     
     Modulo is the remainder after a division.
     Swift has a Remainder Operator. From swift.org:
     --
         The remainder operator (%) is also known as a modulo operator in other languages.
         However, its behavior in Swift for negative numbers means that, strictly speaking,
         it’s a remainder rather than a modulo operation.
     --
     
     While not returning an exact answer, the modulo allows us to work with very large integers without overflow errors.
     Eliminating the overflow errors lets us to use a bigger n while still having an answer that fits in our return int
     
     Modulo mathematical distributive properties:
         ( a + b ) % c = ( ( a % c ) + ( b % c ) ) % c
         ( a * b ) % c = ( ( a % c ) * ( b % c ) ) % c
         ( a – b ) % c = ( ( a % c ) - ( b % c ) ) % c
         ( a / b ) % c NOT EQUAL TO ( ( a % c ) / ( b % c ) ) % c
            ** If you need division look up multiplicative inverse
     
     In a nushell, we can modulo at each step instead of waiting until the end (and possibly overflowing)
     so ( a * b * c * d * e ) % bigPrime
     is the same as ((((((( a * b ) % bigPrime ) * c ) % bigPrime ) * d ) % bigPrime ) * e ) % bigPrime

    -- overflow error code :(
     var a = 1
     for i in 2...100 {
         a = a * i
     }
     print(a % bigPrime)

     -- good code :) ( a will never exceed bigPrime )
     var a = 1
     for i in 2...100 {
         a = ( a * i ) % bigPrime
     }
     print(a) // 437918130

     Prime Number
     This is important! The modulo result could become zero if it's not a prime number, and that will mess everything up
     
     Fun fact: 1000000007 is also an emirp.
               An emirp (prime spelled backwards) is a prime that gives you a different prime when its digits are reversed.
     */
    
    var result = 1
    
    for i in stride(from: 2, through: n, by: 1) {
        result = ((result << (i.bitWidth - i.leadingZeroBitCount)) + i) % bigPrime
    }
    
    return result
}

print(concatenatedBinary(1))
print(concatenatedBinary(3))
print(concatenatedBinary(12))

/*
 Runtime: 2568 ms Your runtime beats 15.79 % of swift submissions.
 Memory Usage: 13.5 MB Your memory usage beats 97.37 % of swift submissions.
 */
