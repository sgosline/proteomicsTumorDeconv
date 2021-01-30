#!/usr/bin/env cwltool
class: Workflow
label: call-deconv-and-cor
id: call-deconv-and-cor
cwlVersion: v1.2

requirements:
  - class: SubworkflowFeatureRequirement
  - class: MultipleInputFeatureRequirement
  - class: StepInputExpressionRequirement

inputs:
   signature: File
   mrna-alg: string
   prot-alg: string
   cancerType: string

outputs:
  pat-cor-file:
     type: File
     outputSource: patient-cor/corr
  cell-cor-file:
     type: File
     outputSource: celltype-cor/corr

steps:
  deconv-mrna:
     run: mrna-deconv.cwl
     in:
       cancerType: cancerType
       mrnaAlg: mrna-alg
       signature: signature
     out: [deconvoluted]
  deconv-prot:
     run: prot-deconv.cwl
     in:
       cancerType: cancerType
       protAlg: prot-alg
       signature: signature
     out: [deconvoluted]
  patient-cor:
     run: ./correlations/deconv-corr-cwl-tool.cwl
     in:
       cancerType: cancerType
       mrnaAlg: mrna-alg
       protAlg: prot-alg
       signature: signature
       proteomics:
         valueFrom: deconv-prot/deconvoluted
       transcriptomics:
         valueFrom: deconv-mrna/deconvoluted
     out: [corr]
  celltype-cor:
     run: ./correlations/deconv-corrXcelltypes-cwl-tool.cwl
     in:
       cancerType: cancerType
       mrnaAlg: mrna-alg
       protAlg: prot-alg
       signature: signature
       proteomics:
         valueFrom: deconv-prot/deconvoluted
       transcriptomics:
         valueFrom: deconv-mrna/deconvoluted
     out: [corr]
