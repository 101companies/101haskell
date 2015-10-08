{-| Tests for the 101companies System -}

module Company.Tests where

-- The tests neither depend on representation nor implementation.
import Company.Signature
import Company.Invariants
import Company.Axioms
import Company.Sample
import Test.HUnit ((@=?))
import Test.Framework.Providers.HUnit (testCase)
import Test.Framework.Providers.QuickCheck2 (testProperty)

-- | The list of tests
tests i
  = [
 
      -- HUnit test cases involving the sample company
      testSample "company1" i prop_company True,
      testSample "no_employees1" i prop_total_no_employees True,
      testSample "position1" i (\i' c -> prop_cut_at_position i c 3) True,
      testSample "total" i total 399747.0,
      testSample "cut1" i prop_cut True,
      testSample "serialization" i prop_serialization True,

      -- QuickCheck properties on arbitrary input
      testProperty "employee" (prop_employee i),
      testProperty "company2" (prop_company i),
      testProperty "no_employees2" (prop_total_no_employees i),
      testProperty "position2" (prop_cut_at_position i),
      testProperty "cut2" (prop_cut i),
      testProperty "setSalary" (prop_setSalary i),
      testProperty "add_commutative" (prop_add_commutative i),
      testProperty "zero_unit" (prop_zero_unit i),
      testProperty "halve" (prop_halve i)
    ]

  where
    -- HUnit test case involving the sample company
    testSample l i p b = testCase l (b @=? p i (sampleCompany i))
