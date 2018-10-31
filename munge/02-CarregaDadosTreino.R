info( logger, "HM_CLASSIFICATION::carrega imagens treino" )

train_paths <- list.files('data/images_train', 
                          recursive = TRUE, 
                          full.names = TRUE)

gender_images_train <- foreach( i = train_paths ) %dopar% {
  
  im <- image_load(i, target_size = c(86,85)) %>% 
    image_to_array()
  
  im <- array_reshape(im[,,1], c(1, 86, 85))
  
} 

gender_images_train <- do.call( abind::abind, 
                                c(gender_images_train, 
                                  list(along = 1) ) )



info( logger, "HM_CLASSIFICATION::carrega labels treino" )

index_train <- list.files('data/images_train', 
                          recursive = TRUE, 
                          full.names = TRUE) %>% 
  str_extract_all( pattern = '\\d+' ) %>% 
  do.call( rbind, .) %>% 
  as.numeric()

index_train <- data_frame( index = index_train ) %>% 
  left_join( ., dados_index,
             by = c("index" = "Num") ) %>% 
  mutate( gender_dummy = as.integer( ifelse( Gender == 'M', 1, 0 ) ) )

gender_labels_train <- index_train$gender_dummy

gender_labels_train <- to_categorical(gender_labels_train, 
                                      num_classes = 2)

rm(train_paths, index_train)
