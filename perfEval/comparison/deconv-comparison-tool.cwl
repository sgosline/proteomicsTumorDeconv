#!/usr/bin/env cwltool

label: deconv-comparison-tool
id:  deconv-comparison-tool
cwlVersion: v1.0
class: CommandLineTool
baseCommand: python

arguments:
  - /bin/comparison.py

requirements:
  - class: DockerRequirement
    dockerPull: tumordeconv/comparison
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
    default: "js"

outputs:
  dist:
    type: File
    outputBinding:
      glob: "dist.tsv" 
      outputEval: |
        ${
          var aName = inputs.matrixA.nameroot
          var bName = inputs.matrixB.nameroot
          var name = aName + '-vs-' + bName + '-' + inputs.method + '-dist.tsv'
          self[0].basename = name;
          return self[0]
         }
