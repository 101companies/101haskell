module Company.Cut where

import Control.Concurrent
import Control.Monad

import Company.Data
import Company.Utils

cutCompany :: Company -> IO Company
cutCompany (Company n depts) = do
    mvars <- forM depts $ \d -> do
        mvar' <- newEmptyMVar
        forkIO $ cutDept mvar' d
        return mvar'
    cutDepts <- takeAllMVars mvars
    return $ Company n cutDepts

cutDept :: MVar Department -> Department -> IO ()
cutDept mvar (Department n m dus eus) = do
    mvars <- forM dus $ \d -> do
        mvar' <- newEmptyMVar
        forkIO $ cutDept mvar' d
        return mvar'
    cutDus <- takeAllMVars mvars
    putMVar mvar $ Department n (cutEmployee m) 
                                (cutDus) 
                                (map cutEmployee eus)   
  
cutEmployee :: Employee -> Employee
cutEmployee (Employee n a s) = Employee n a (s/2)
