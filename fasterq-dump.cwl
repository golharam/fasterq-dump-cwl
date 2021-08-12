#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: fasterq-dump 
hints:
  DockerRequirement:
    dockerPull: ncbi/sra-tools:2.11.0

requirements:
  # This is required because fasterq-dump looks for ~/.ncbi/user-settings.mkfg.
  # When this container is run as root, the directory is in the image's /root/
  # folder.  When this image is run via cwl-runner, the HOME directory is
  # specified to be something different hence this file doesn't exist, hence
  # fasterq-dump throws an error about vdg-config needing to be called.
  InitialWorkDirRequirement:
    listing:
      - entryname: .ncbi/user-settings.mkfg
        entry: |-
          /LIBS/IMAGE_GUID = "0df5ebb2-dcc0-4a83-b71f-b5d31e5bda3e"
          /libs/cloud/report_instance_identity = "true"

inputs:
  srr:
    type: string
    inputBinding:
      position: 1

  output_dir:
    type: File?
    inputBinding:
      position: 2
      prefix: -O

  tmp_dir:
    type: File?
    inputBinding:
      position: 2
      prefix: -t

  threads:
    type: int?
    inputBinding:
      position: 2
      prefix: -e

  progress_bar:
    type: boolean?
    inputBinding:
      position: 2
      prefix: -p

outputs:
  fastq1:
    type: File
    outputBinding:
      glob: '*_1.fastq'

  fastq2:
    type: File
    outputBinding:
      glob: '*_2.fastq'
