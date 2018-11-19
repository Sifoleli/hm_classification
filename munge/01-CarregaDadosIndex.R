info( logger, "HM_CLASSIFICATION::carrega indice das imagens" )

dados_index <- read_csv2( file = 'data/index.csv' )

registerDoFuture()
plan(multiprocess)