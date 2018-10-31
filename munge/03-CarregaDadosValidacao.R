info( logger, "HM_CLASSIFICATION::carrega imagens validacao" )

valid_paths <- list.files('data/images_valid/', 
                          recursive = TRUE, 
                          full.names = TRUE)

gender_images_valid <- foreach( i = valid_paths ) %dopar% {
  
  im <- image_load(i, target_size = c(86,85)) %>% 
    image_to_array()
  
  im <- array_reshape(im[,,1], c(1, 86, 85))
  
} 

gender_images_valid <- do.call( abind::abind, 
                                c(gender_images_valid, 
                                  list(along = 1) ) )



info( logger, "HM_CLASSIFICATION::carrega labels treino" )

index_valid <- list.files('data/images_valid', 
                          recursive = TRUE, 
                          full.names = TRUE) %>% 
  str_extract_all( pattern = '\\d+' ) %>% 
  do.call( rbind, .) %>% 
  as.numeric()

index_valid <- data_frame( index = index_valid ) %>% 
  left_join( ., dados_index,
             by = c("index" = "Num") ) %>% 
  mutate( gender_dummy = as.integer( ifelse( Gender == 'M', 1, 0 ) ) )

gender_labels_valid <- index_valid$gender_dummy

gender_labels_valid <- to_categorical(gender_labels_valid, 
                                      num_classes = 2)

rm(valid_paths, index_valid)
