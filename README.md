# DrawProtMut

## Description

This package is a modified version of the package drawProteins¹ that is used to draw the sequence of a protein as a box with different elements (domains, regions, repeats, motifs, phosphorilation sites etc). The modifications include the creation of new functions to resize the box of the protein main chain and the location of the phoshoilation symbols to reflect many other features that can be overlapped. New function are also incorporated to draw DNA as boxes, which are at the end, modification of the previous functions present in drawProtens

## General Syntax

The script is designated to work with many sequences at the time (preferably not more than 8). It takes the UNIProt Entry name of the genes of interest, download them and make a table with the required information to plot the result.

## Manual construction of data

If the desired protein has no accesion entry at UniProt, a CSV file can be generated that contains the following information:

| type | description | begin | end | length | accession | entryName | order |
| --- | --- | --- | --- | --- | --- | --- | --- |
| CHAIN | A description of the polypeptide chain to be plotted | 1 | 150 | 149 | A geneID | A common name | inverse order of plotting |

The elements of the table are:
1. **type:** is the type of the element to be plotted. It can be CHAIN, DOMAIN, REION, MOTIF, STRAND, HELIX, TURN, MOD_RES.
2. **description:** is a description of the element to be plotted. If the same color is wanted to be plotted in different elements, they must have the same description.
3. **begin:** the beginning position of the element.
4. **end:** the end position of the element.
5. **length:** the end position minus the begin position.
6. **accession:** a code that identifies the protein and all of his elements
7. **entryName:** as above but a more common name to identify the protein. The entryName of the CHAIN element will be used as the label of the protein.
8. **order:** a number to identify all the elements of the same protein. The plotting will procede with the highest number on top of the plotting area.
