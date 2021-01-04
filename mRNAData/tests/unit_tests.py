import unittest

import os, sys
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

import pandas as pd

from mRNADataSetsCLI import get_cptac_df

class TestmRNADataSetRetrieval(unittest.TestCase):

    def test_get_cptac_df_returns_df(self):
        cptac_df = get_cptac_df('brca')
        self.assertTrue(isinstance(cptac_df, pd.DataFrame))



if __name__ == '__main__':
    unittest.main()
