pragma circom 2.0.0;

include "comparators.circom";

template AgeCheck(minAge) {
    signal input birthYear;
    signal input currentYear;
    signal output isOldEnough;

    // Constraint: currentYear - birthYear >= minAge
    component gte = GreaterEqThan(32);
    gte.in[0] <== currentYear - birthYear;
    gte.in[1] <== minAge;

    isOldEnough <== gte.out;
    isOldEnough === 1; // Proof fails if user is not old enough
}

component main {public [currentYear]} = AgeCheck(18);
