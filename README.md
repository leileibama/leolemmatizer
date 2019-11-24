# leolemmatizer

## Description

A package that postags and lemmatizes English texts in a folder (https://github.com/leileibama/leolemmatizer)

Based on udpipe (https://github.com/bnosac/udpipe)

##
## Developer
Leo Lei Lei

Professor of Applied Linguistics, Huazhong University of Science and Technology

Contact: leileicn@qq.com

##
### Please kindly cite the following articles if you use leolemmatizer in your research:

Lei, L., & Wen, J. (2019). Is dependency distance experiencing a process of minimization? A diachronic study based on the State of the Union addresses. Lingua, S002438411930511X. https://doi.org/10.1016/j.lingua.2019.102762

Lei, L., & Jockers, M. L. (2018). Normalized Dependency Distance: Proposing a New Measure. Journal of Quantitative Linguistics, 1–18. https://doi.org/10.1080/09296174.2018.1504615

##
The package is based on udpipe.

Refer to the fowlloing for udpipe, the R package

https://github.com/bnosac/udpipe


##
## Installation

#install.packages("devtools")

library(devtools) 

install_github("leileibama/leolemmatizer")

##
## Examples

#use the function postag_lemmatize()

#with default folders

#or set your own language_model_folder and texts_folder


#
#put the language model in the language_model_folder

#put your to-be-processed text files in the texts_folder

#and run the function

#
#a new folder named "mytexts_results" will be created

#three resulting files will be created in the new folder

#_token_tagpos.txt, in "token_pos" format

#_lemmatized.txt, in "lemma" format

#_postag_lemma.csv, .csv file, with detailed information such as paragraph id, sentence id, token, lemma, and postag

#

postag_lemmatize(language_model_folder = 'C:/',
                 texts_folder = 'C:/mytexts/'))


##
### IMPORTANT

#before use the package and the function

#read the following

#1. install the following packages

#2. download the language model


##
### 1. install the following packages

#install the package "udpipe"

#install.packages("udpipe")

#install.packages('dplyr')

#install.packages('dplyr')

#install.packages('devtools')

#install.packages('data.table')  #needed for 'udpipe'

#install.packages('chron')   #needed for 'udpipe'

#install_github("bnosac/udpipe", build_vignettes = TRUE)

##
### 2. download the language model

#download the English language model

#english-ewt-ud-2.4-190531.udpipe

#from https://github.com/jwijffels/udpipe.models.ud.2.4/tree/master/inst/udpipe-ud-2.4-190531

#and move it to the C disk root foloder "C:/"

#'C:/english-ewt-ud-2.4-190531.udpipe'


