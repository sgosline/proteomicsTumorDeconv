#!/usr/bin/env cwltool

label: deconv-corrXcelltypes-cwl-tool
id:  deconv-corrXcelltypes-cwl-tool
cwlVersion: v1.0
class: CommandLineTool
baseCommand: python

arguments:
  - /bin/correlationXcelltypes.py

requirements:
  - class: DockerRequirement
    dockerPull: tumordeconv/correlation
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
      glob: "cellTypeCorr.tsv" #$(inputs.output)
      outputEval: |
        ${
          var aName = inputs.matrixA.nameroot
          var bName = inputs.matrixB.nameroot
          var name = aName + '-vs-' + bName + '-' + inputs.method + '-cellTypeCorr.tsv'
          self[0].basename = name;
          return self[0]
         }
