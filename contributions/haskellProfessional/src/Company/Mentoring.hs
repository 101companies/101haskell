{-| Access mentors, mentees, and check consistency of mentoring -}

module Company.Mentoring (
  mentoring,
  byName,
  mentor,
  mentees,
  danglingMentoringSample,
  selfMentoringSample
) where

import Company.Data

-- | Check mentoring consistency
mentoring :: Company -> Bool
mentoring c = resolvable c && not (selfish c)

-- | Look up employee by name
byName :: Company -> Name -> Employee
byName c n = head [ e |
    e <- employees c,
    let (Employee n' _ _ _) = e,
    n == n'
  ]

-- | Retrieve mentor of an employee
mentor :: Company -> Name -> Maybe Name
mentor c n = let (Employee _ _ _ m) = byName c n in m

-- | Retrieve mentees of an employee
mentees :: Company -> Name -> [Name]
mentees c n = [ n' |
    e <- employees c,
    let (Employee n' _ _ m) = e,
    m == Just n
  ]

-- The list of employees in a company
employees :: Company -> [Employee]
employees (Company _ ds) = deps ds
  where
    deps :: [Department] -> [Employee]
    deps = concat . map dep
      where
       dep :: Department -> [Employee]
       dep (Department _ m ds es) = [m] ++ deps ds ++ es
    
-- Names of employees in a company
employeeNames :: Company -> [Name]   
employeeNames c = [ n | e <- employees c, let (Employee n _ _ _) = e ]

-- Names of mentors in a company
mentorNames :: Company -> [Name]
mentorNames c = concat (map getMentorName (employees c))
  where
    getMentorName (Employee _ _ _ (Just m)) = [m]
    getMentorName _ = []

-- Checker whether all mentor names are resolvable
resolvable :: Company -> Bool
resolvable c = and [ elem m (employeeNames c) | m <- mentorNames c ] 

-- Check whether someone mentors him/herself
selfish :: Company -> Bool
selfish = or . map selfish' . employees
  where
    selfish' (Employee n _ _ (Just n')) = n == n'
    selfish' _ = False

-- | An inconsistent company with an unresolvable mentor name
danglingMentoringSample = Company
  "Fail Industries"
  [ Department "Failure"
      (Employee "Joe Programmer" "Basement" 1000 (Just "Joanna Programmina"))
      []
      []
  ]

-- | An inconsistent company with an employee mentoring himself
selfMentoringSample = Company
  "Fail Industries"
  [ Department "Failure"
      (Employee "Joe Programmer" "Basement" 1000 (Just "Joe Programmer"))
      []
      []
  ]
