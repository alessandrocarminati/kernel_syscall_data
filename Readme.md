# Kernel Syscall Data Repository
This repository contains data and scripts related to the static analysis
of kernel syscalls in a minimal test kernel.
While the kernel used for analysis is intentionally minimal, the data
derived from it remains representative of more feature-rich kernels.
The repository is organized into several directories, each serving a 
specific purpose:

## Directory Overview
* `source`
    * **Contents**: Static traces of all syscalls in the test
       kernel, represented as graphs in .dot format.
    * **Description**: These graphs depict the statically analyzed
      call tree for each syscall, where all possible execution paths
      are represented.
    * **How it was generated**: The data was produced using ks-nav,
      applied to the test kernel.
* `stats`
    * **Contents**: Detailed statistical analysis of functions within
      each syscall's call tree.
    * **Description**: For each function, it reports how many arcs contain
      the subgraph derived from exploring the syscall call tree starting from
      that function.
    * **Key Finding**: Analysis reveals a set of 1,512 core functions that are
      commonly present across many call tree traces.
* `pngs`
    * **Contents**: Visual summaries of the data in the form of PNG images.
    * **Description**: Each image highlights the core kernel functions for
      individual syscalls, illustrating the relationships and commonality of
      these functions across different call trees.
* `cored_graphs`
    * **Contents**: Modified versions of the syscall call trees.
    * **Description**: Each call tree has been transformed by replacing the
      core subgraph (the common set of core functions) with a single `__core__`
      node. These graphs illustrate how the call tree structure simplifies when
      core functions are aggregated.

## Key Insights
The analysis demonstrates the existence of core functions that are shared across multiple
syscall call trees, that are potentially interconnected.
In this kernel, 1,512 core functions form the backbone of the system, underscoring their
importance and ubiquity in syscall execution.

## Scripts
The repository also includes scripts to process, analyze, and visualize the syscall data.
Refer to comments within the scripts for usage details.

