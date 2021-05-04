#!/usr/local/bin/python

import pandas as pd
import argparse


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--matrixA', dest='matrixA',
                        help='Deconvoluted matrix A')
    parser.add_argument('--matrixB', dest='matrixB',
                        help='Deconvoluted matrix B')
    parser.add_argument('--method', dest='method', help='Use spearman or pearson correlation',
                        default='spearman')
    opts = parser.parse_args()

    rna = pd.read_csv(opts.rnafile, sep='\t', index_col=0)
    pro = pd.read_csv(opts.profile, sep='\t', index_col=0)

    rnaCols = list(rna.columns)
    proCols = list(pro.columns)
    rnaRows = list(rna.index)
    proRows = list(pro.index)
    intersectCols = list(set(rnaCols) & set(proCols))
    intersectRows = list(set(rnaRows) & set(proRows))

    pro = pro.loc[intersectRows, intersectCols]
    rna = rna.loc[intersectRows, intersectCols]

    rna = rna.transpose()
    pro = pro.transpose()

    if opts.method == 'pearson':
        corrList = [pro[sample].corr(rna[sample]) for sample in intersectRows]
    else:
        corrList = [pro[sample].corr(rna[sample], method='spearman')
                    for sample in intersectRows]

    correlations = pd.Series(corrList)
    correlations.index = intersectRows
    correlations.to_csv("cellTypeCorr.tsv", sep='\t', header=False)


if __name__ == '__main__':
    main()
