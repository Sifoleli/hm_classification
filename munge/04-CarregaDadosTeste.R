info( logger, "HM_CLASSIFICATION::carrega imagens teste" )

test_paths <- list.files('data/images_test', 
                          recursive = TRUE, 
                          full.names = TRUE)

gender_images_test <- foreach( i = test_paths ) %dopar% {
  
  im <- image_load(i, target_size = c(86,85)) %>% 
    image_to_array()
  
  im <- array_reshape(im[,,1], c(1, 86, 85))
  
} 

gender_images_test <- do.call( abind::abind, 
                                c(gender_images_test, 
                                  list(along = 1) ) )



info( logger, "HM_CLASSIFICATION::carrega labels teste" )

index_test <- list.files('data/images_test', 
                          recursive = TRUE, 
                          full.names = TRUE) %>% 
  str_extract_all( pattern = '\\d+' ) %>% 
  do.call( rbind, .) %>% 
  as.numeric()

index_test <- data_frame( index = index_test ) %>% 
  left_join( ., dados_index,
             by = c("index" = "Num") ) %>% 
  mutate( gender_dummy = as.integer( ifelse( Gender == 'M', 1, 0 ) ) )

gender_labels_test <- index_test$gender_dummy

gender_labels_test <- to_categorical(gender_labels_test, 
                                      num_classes = 2)

rm(test_paths, index_test)
