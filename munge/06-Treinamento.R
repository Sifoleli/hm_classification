info( logger, "HM_CLASSIFICATION::treina modelo" )

# preparacao
gender_images_train <- array_reshape(gender_images_train, c(278, 86 * 85))
gender_images_train <- gender_images_train / 255


gender_images_valid <- array_reshape(gender_images_valid, c(64, 86 * 85))
gender_images_valid <- gender_images_valid / 255


# treinamento modelo 1
network %>% fit(gender_images_train,
                gender_labels_train,
                epochs = 50,
                batch_size = 180,
                validation_data = list(gender_images_valid,
                                       gender_labels_valid),
                shuffle = FALSE )
