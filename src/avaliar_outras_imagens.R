# carrega modelo treinado
network <- load_model_hdf5("src/hm_classification_model.h5")


# Ver a imagem
imagem <- image_load(path = "data/outros_exemplos/scarllet.jpg",
                     grayscale = FALSE,
                     target_size = c(86, 85) )

imagem <- image_to_array( imagem )

imagem %>% 
  as.raster( max = max(imagem) ) %>% 
  plot()

imagem <- imagem[,,1]


# previsao
testar_imagem <- array_reshape(imagem, c(1, 86 * 85))
testar_imagem <- testar_imagem / 255

ifelse( network %>% 
          predict_classes(testar_imagem) == 1, "Mulher", "Homem" )

probs <- network %>% 
  predict_proba(testar_imagem)
colnames(probs) <- c("Homem", "Mulher")
probs

