##############################################################################
#                                                                            # 
#   SCRIPT FOR FORMATTING A MATRIX FOR USING IN DIFFERENT NETWORK PROGRAMS   #
#                                                                            # 
##############################################################################

##### Ecological Synthesis Lab (SintECO)
##### https://marcomellolab.wordpress.com
##### Author: Gabriel Félix
##### E-mail: gabriel.felixf@hotmail.com 
##### How to cite: Félix G.M. 2016. How to format a matrix to be used in
##### different network programs. Ecological Synthesis Lab at the University
##### of São Paulo, Brazil.
##### Published on April 25th, 2017 (English version).
##### Run in R 3.3.3 (2017-03-06) -- "Another Canoe"

##### Disclaimer: You may use this script freely for non-comercial purposes
##### at your own risk. We assume no responsibility or liability
##### for the use of this software, convey no license or title under
##### any patent, copyright, or mask work right to the product. We
##### reserve the right to make changes in the software without notification. 
##### We also make no representation or warranty that such application will 
##### be suitable for the specified use without further testing or modification. 
##### If this script helps you carry out any academic work (paper, book,
##### chapter, dissertation etc.), please acknowledge the authors and cite the source.


inputs=function (dir, files_type=".txt") {
  
  if(!require(xlsx)){install.packages("xlsx");library(xlsx)}
  if(!require(reshape2)){install.packages("reshape2");library(reshape2)}
  
  
#Create output directories
  
  dir.create(paste(dir,"/MATRIX", sep=""))
  
  if (files_type==".txt") {
    
    dir.create(paste(dir,"/MATRIX/BINARY/", sep=""))
    dir.create(paste(dir,"/MATRIX/QUANTITATIVE/", sep=""))
  }
  
  dir.create(paste(dir,"/TXT_MODULAR_ATAQUE", sep=""))
  dir.create(paste(dir,"/TXT_PAJEK", sep=""))
  dir.create(paste(dir,"/TXT_PAJEK/QUANTITATIVE", sep=""))
  dir.create(paste(dir,"/TXT_PAJEK/BINARY", sep=""))
  dir.create(paste(dir,"/NESTEDNESS", sep=""))
  dir.create(paste(dir,"/NESTEDNESS/TXT_ANINHADO", sep=""))
  dir.create(paste(dir,"/NESTEDNESS/TXT_NTC", sep=""))
  
  
#Creating a list of edge lists in the working directory
  
  if (files_type==".txt") {
    
    files=list.files(path = dir, pattern="*.txt")
  }
  
  if (files_type==".xlsx") {
    
    files=list.files(path = dir, pattern="*.xlsx")
  }
  
#Creating the output files
  
  for (i in files) {
    
    NC <- T
    
    if (files_type==".txt") {
      
      j=gsub(".txt","",i) 
      a  = read.table(file=paste(dir,"/",i,sep=""),h=T)
      colnames(a) <- c("PARTNER_1","PARTNER_2","WEIGHT")
    }
    
    if (files_type==".xlsx") {
      
      j=gsub(".xlsx","",i) 
      a  = read.xlsx(file=paste(dir,"/",i,sep=""),sheetIndex = 1, header = T)
      colnames(a) <- c("PARTNER_1","PARTNER_2","WEIGHT")
    }  
    
    b=acast(a, PARTNER_1 ~ PARTNER_2, value.var="WEIGHT") 
    
    b[is.na(b)]=0  
    
    c=ifelse(b==0,0,1) 
    
    e=matrix(b, nrow=nrow(b), ncol=ncol(b)) 
    
    f=matrix(c, nrow=nrow(c), ncol=ncol(c)) 
    

#Exporting the matrix 
    
    if (files_type==".txt"){
      
      write.table(c,file=paste(dir,"/MATRIX/BINARY/",i,sep=""), sep = "\t") #Exporting the binary matrix
      write.table(b,file=paste(dir,"/MATRIX/QUANTITATIVE/",i,sep=""), sep = "\t") #Exporting the quantitative matrix
    }
    
    if (files_type==".xlsx"){
      
      write.xlsx(c,file=paste(dir,"/MATRIX/",i,sep=""),sheetName = "BINARY_MATRIX") #Exporting the binary matrix
      write.xlsx(b,file=paste(dir,"/MATRIX/",i,sep=""),sheetName = "QUANTITATIVE_MATRIX", append = T) #Exporting the quantitative matrix
    }
    
    
#Exporting files for Modular and Ataque
    
    write.table(f, file=paste(dir,"/TXT_MODULAR_ATAQUE/",j,".txt", sep=""), row.names = F, col.names = F, sep="\t")
    

#Exporting files for Pajek
    
    vert=paste("*Vertices",nrow(b) + ncol(b), nrow(b), sep=" ") #Creating string "*Vertices"
    mat="*Matrix" #Creating string "*Matrix"
    cat(vert,mat, file=paste(dir,"/TXT_PAJEK/QUANTITATIVE/",j,".txt", sep=""), sep="\n") #Creating txt with the strings above
    cat(vert,mat, file=paste(dir,"/TXT_PAJEK/BINARY/",j,".txt", sep=""), sep="\n") #Creating txt with the strings above
    write.table(e, file=paste(dir,"/TXT_PAJEK/QUANTITATIVE/",j,".txt", sep=""), row.names = F, col.names = F, append = T) #add the quantitative matrix to the txt
    write.table(f, file=paste(dir,"/TXT_PAJEK/BINARY/",j,".txt", sep=""), row.names = F, col.names = F, append = T) #add the binary matrix to the txt
    

#Export files for Aninhado
    
    cat(j, file=paste(dir,"/NESTEDNESS/TXT_ANINHADO/",j,".txt", sep=""), sep="\n") 
    write.table(f, file=paste(dir,"/NESTEDNESS/TXT_ANINHADO/",j,".txt", sep=""), row.names = F, col.names = F, sep="\t", append=T) 
    

#Export files for NTC
    
    cat(j, file=paste(dir,"/NESTEDNESS/TXT_NTC/",j,".txt", sep=""), sep="\n")
    write.table(f, file=paste(dir,"/NESTEDNESS/TXT_NTC/",j,".txt", sep=""), row.names = F, col.names = F, sep="", append=T)
    
#Export files for the package bipartite
    
    assign(paste(j,"bin",sep="_"),c)
    assign(paste(j,"quan",sep="_"),b)
    
  }
  
}

