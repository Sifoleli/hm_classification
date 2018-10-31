info( logger, "HM_CLASSIFICATION::modelo" )

network <- keras_model_sequential() %>%
  layer_dense( units = 512,
               activation = "relu",
               input_shape = c(86 * 85),
               kernel_initializer = initializer_random_uniform( minval = -0.01, 
                                                                maxval = 0.01, 
                                                                seed = 104) ) %>%
  layer_dense( units = 2,
               activation = "softmax" )

# metodo de treinamento
opt <- optimizer_rmsprop(lr = 0.00001, decay = 1e-6)

network %>% compile(
  loss = "categorical_crossentropy",
  optimizer = opt,
  metrics = "accuracy"
)
