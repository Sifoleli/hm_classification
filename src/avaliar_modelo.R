## Teste do modelo

# preparacao
gender_images_test <- array_reshape(gender_images_test, c(6, 86 * 85))
gender_images_test <- gender_images_test / 255

# teste
network %>% evaluate(gender_images_test, gender_labels_test)


# confusion matrix
classes_pred <- network %>% 
  predict_classes(gender_images_test[1:6,])

data_frame( real = gender_labels_test[,2],
            previsto = classes_pred ) %>% 
  count( real, previsto ) %>% 
  spread( key = real, value = n, fill = 0 )

# Ver a imagem
imagem <- image_load(path = "data/images_test/368c.jpg",
                     grayscale = FALSE,
                     target_size = c(86, 85) )

imagem <- image_to_array( imagem )

imagem %>% 
  as.raster( max = max(imagem) ) %>% 
  plot()

imagem <- imagem[,,1]

dados_index %>% 
  filter( Num == 368 )

ifelse( classes_pred[4] == 1,  "Mulher", "Homem" )
