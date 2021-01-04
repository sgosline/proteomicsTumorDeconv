#!/usr/local/bin/python
'''
Basic CLI to import CPTAC proteomic data
'''
import argparse
import cptac


def parse_cancer_type():
    parser = argparse.ArgumentParser()
    parser.add_argument('--cancerType', dest='type',
                        help='Cancer type to be collected')
    return parser.parse_args().type.lower()

def get_cptac_df(cancer_type):
    if cancer_type == 'brca':
        dat = cptac.Brca()
    elif cancer_type == 'ccrcc':
        dat = cptac.Ccrcc()
    elif cancer_type == 'coad':
        dat = cptac.Colon()
    elif cancer_type == 'ovca':
        dat = cptac.Ovarian()
    elif cancer_type == 'endometrial':
        dat = cptac.Endometrial()
    elif cancer_type == 'gbm':
        dat = cptac.Gbm()
    elif cancer_type == 'hnscc':
        dat = cptac.Hnscc()
    elif cancer_type == 'lscc':
        dat = cptac.Lscc()
    elif cancer_type == 'luad':
        dat = cptac.Luad()
    else:
        exit()
    df = dat.get_transcriptomics()

    return df

def write_file(cancer_type):
    cptac_df = get_cptac_df(cancer_type)
    cptac_df.transpose().to_csv(path_or_buf="file.tsv", sep='\t')


if __name__ == '__main__':
    write_file(cancer_type=parse_cancer_type())
