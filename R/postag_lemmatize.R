# leolemmatizer
#
# This is the function named postag_lemmatize()
# which postag and lemmatize English texts in a folder
#


#########
# IMPORTANT
# before use the package and the function
# read the following
# 1. install the following packages
# 2. download the language model


# 1. install the following packages
# install the package "udpipe"
#install.packages("udpipe")

#install.packages('dplyr')
#install.packages('dplyr')

#install.packages('devtools')
#install.packages('data.table')  #needed for 'udpipe'
#install.packages('chron')   #needed for 'udpipe'
#install_github("bnosac/udpipe", build_vignettes = TRUE)

# 2. download the language model
# download the English language model
# english-ewt-ud-2.4-190531.udpipe
#from https://github.com/jwijffels/udpipe.models.ud.2.4/tree/master/inst/udpipe-ud-2.4-190531
# and move it to the C disk root foloder "C:/"
#'C:/english-ewt-ud-2.4-190531.udpipe'


library(udpipe)
library(dplyr)
library(readr)


postag_lemmatize <- function(language_model_folder = 'C:/',
                             texts_folder = 'C:/mytexts/'){

  # load the language model
  udmodel_eng <- udpipe_load_model(file = paste0(language_model_folder, 'english-ewt-ud-2.4-190531.udpipe'))

  files <- list.files(texts_folder, full.names = T)

  # read in files in the folder
  for (file in files){

    myfile <- read_file(file)

    # postag and lemmatize the text
    pos <- udpipe_annotate(udmodel_eng,
                           myfile,
                           tagger = 'default',
                           parser = 'none')
    #glimpse(pos)

    # change it into a dataframe
    pos_df <- as.data.frame(pos)

    #glimpse(pos_df)

    #select columns
    pos_df_mini <- pos_df %>%
      select(pid = paragraph_id,
             sid = sentence_id,
             tid = token_id,
             token,
             lemma,
             upos,
             xpos)

    ########## write out files

    results_folder <- paste0(gsub('/$', '', texts_folder), '_results/')
    dir.create(results_folder)

    # prepare the output file names
    output_filename1 <- gsub('^.*/', '', file)
    output_filename2 <- gsub('\\.txt', '', output_filename1)

    # for the postag_lemma csv
    output_filename3 <- paste0(output_filename2, '_postag_lemma.csv')

    # for the lemmatized file
    output_filename4 <- paste0(output_filename2, '_lemmatized.txt')

    # for the token_pos file
    output_filename5 <- paste0(output_filename2, '_token_tagpos.txt')

    #####
    # write out the postag lemma csv
    write_csv(pos_df_mini, paste0(results_folder, output_filename3))

    #####
    #write out lemmatized text
    lemma_df <- pos_df_mini %>%
      select(sid, lemma)

    lemma_vector_list <- split(lemma_df$lemma,
                               lemma_df$sid)

    for (i in 1:length(lemma_vector_list)){

      lemma_v <- lemma_vector_list[[i]]
      lemma_string <- paste(lemma_v,
                            sep = ' ', collapse = ' ')

      lemma_string <- paste0(lemma_string, '\n')

      #print(lemma_string)
      write_file(lemma_string, paste0(results_folder, output_filename4), append = T)
    }


    #####
    #write out postagged text
    token_xpos_df <- pos_df_mini %>%
      mutate(token_xpos = paste0(token, '_', xpos)) %>%
      select(sid, token_xpos)

    token_xpos_vector_list <- split(token_xpos_df$token_xpos,
                                    token_xpos_df$sid)

    for (i in 1:length(token_xpos_vector_list)){

      token_xpos_v <- token_xpos_vector_list[[i]]
      token_xpos_string <- paste(token_xpos_v,
                                 sep = ' ', collapse = ' ')

      token_xpos_string <- paste0(token_xpos_string, '\n')

      #print(token_xpos_string)
      write_file(token_xpos_string, paste0(results_folder, output_filename5), append = T)
    }

  }

}
