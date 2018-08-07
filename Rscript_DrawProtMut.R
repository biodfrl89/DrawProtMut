#!/usr/bin/env Rscript
library(optparse)

option_list <-  list(
  make_option( opt_str = c("-q", "--query"), type = "character", default = NULL,
               help = "The UniProt accession code of the protein(s) of interest", metavar = "IDs"),
  make_option( opt_str = c("-f", "--filename"), type = "character", default = NULL, 
               help = "The table with the information required to plot.", metavar = "filename"),
  make_option( opt_str = c("-o", "--output"), type = "character", default = "output.txt", 
               help = "The filename of the output [default = %default]", metavar = "filename")
) 

opt_parser <-  OptionParser(option_list = option_list)
opt <-  parse_args(opt_parser)

if (is.null(opt$query)) {
  if (is.null(opt$filename)) {
    stop("At least one argument must be supplied (query or filename).\n\n Look the help section with the argument -h or --help \n\n", call.=FALSE)
  } else {
    print("Filename submitted. Processing...")
  }
} else {
  print("Query submitted. Processing...")
}

library(drawProteins)
library(ggplot2)

if (!(is.null(opt$query))) {
  print("Getting features")
  samp <- get_features(opt$query)
  samp_data <- feature_to_dataframe(samp)
  
  p <- draw_canvas(data = samp_data) #Dibuja LIENZO
  p <- draw_chains(p, samp_data)
  p <- draw_domains(p, samp_data) #Dibuja DOMINOS
  p <- draw_regions(p, samp_data) # Dibuja REGIONES
  p <- draw_repeat(p, samp_data) #Dibuja REPETIDOS
  p <- draw_motif(p, samp_data) #Dibuja MOTIVOS
  p <- draw_phospho(p, samp_data, size = 8, fill = "red") #Dibuja SITIOS DE FOSFORILACIONES
  p <- p + theme_bw(base_size = 20) + # Delimita la zona del plot
    theme(panel.grid.minor=element_blank(), 
          panel.grid.major=element_blank()) + #Elimina las grids del fondo del area de plot
    theme(axis.ticks = element_blank(), #Elimina los tick de los ejes
          axis.text.y = element_blank()) + #Elimina el texto del eje y
    theme(panel.border = element_blank()) #Elimina los bordes del plot
  
}

s <- 1
if (s == 1) stop("TEST DONE")



#Añadir titulos y subtitulos
rel_subtitle <- paste0("circles = phosphorylation sites\n",
                       "RHD = Rel Homology Domain\nsource:Uniprot")
p <- p + labs(title = "Rel A/p65 and LEA45", subtitle = rel_subtitle)

#Mover leyenda
p <- p + theme(legend.position="none") + labs(fill="")
p
p <- p + scale_colour_manual(name="M33L-His",values=c("black", "green")) 
p
p + theme_bw()


AtLEA45 <- get_features("Q9FG31")
AtLEA45_data <- feature_to_dataframe(AtLEA45)

write.csv(AtLEA45_data, file = "atlea45_mut_drawprot", quote = FALSE)

AtLEA45_muts <- read.csv("muts.csv", header = TRUE)

p <- draw_canvas(AtLEA45_muts) #Dibuja LIENZO
p <- draw_chains(p, AtLEA45_muts, #Dibuja CADENA PRINCIPAL
                 fill = "lightsteelblue1", 
                 outline = "grey",
                 label_size = 5) 
p <- draw_regions(p, AtLEA45_muts)
p



