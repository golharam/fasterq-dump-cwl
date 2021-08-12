#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  ScatterFeatureRequirement: {}

inputs:
  SRR_array: string[]
  progress_bar: boolean?

steps:
  fasterq-dump-scatter:
    run: fasterq-dump.cwl
    scatter: srr
    in:
      srr: SRR_array
      progress_bar: progress_bar
    out: 
      [fastq1, fastq2]

outputs: []
