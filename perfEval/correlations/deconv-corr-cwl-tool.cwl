#!/usr/bin/env cwltool

label: deconv-corr-cwl-tool
id:  deconv-corr-cwl-tool
cwlVersion: v1.0
class: CommandLineTool
baseCommand: python

arguments:
  - /bin/correlation.py

requirements:
  - class: DockerRequirement
    dockerPull: tumordeconv/correlation
  - class: StepInputExpressionRequirement
  - class: InlineJavascriptRequirement

inputs:
  matrixA:
    type: File
    inputBinding:
      prefix: --matrixA
  matrixB:
    type: File
    inputBinding:
      prefix: --matrixB
  method:
    type: string
    inputBinding:
      prefix: --method
    default: "spearman"

outputs:
  corr:
    type: File
    outputBinding:
      glob: "corr.tsv" 
      outputEval: |
        ${
          var aName = inputs.matrixA.nameroot
          var bName = inputs.matrixB.nameroot
          var name = aName + '-vs-' + bName + '-' + inputs.method + '-corr.tsv'
          self[0].basename = name;
          return self[0]
         }
