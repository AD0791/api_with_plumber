library("plumber")
import::here(users,.from="./data.R")





# plumber.R

#* @filter cors
cors <- function(res) {
    res$setHeader("Access-Control-Allow-Origin", "*")
    plumber::forward()
}




#* @serializer contentType list(type="application/pdf")
#* @get /pdf
#* @tag plb
function(res){
  tmp <- tempfile()
  pdf(tmp)
  plot(1:10, type="b")
  text(4, 8, "PDF from plumber!")
  text(6, 2, paste("The time is", Sys.time()))
  dev.off()

  #filename = paste0('report','.pdf', sepp='')
  #locale_filename = paste0('notebooks/',filename, sepp= '')


  locale_filename = "plot.pdf"
  res$setHeader("Content-Disposition", paste0("attachment; filename=", basename(locale_filename)))

  readBin(tmp, "raw", n = file.info(tmp)$size)
}






#* Echo the parameter that was sent in
#* @param msg The message to echo back.
#* @get /echo
#* @tag plb
function(msg=""){
  list(msg = paste0("The message is: '", msg, "'"))
}

#* Plot out data from the iris dataset
#* @param spec If provided, filter the data to only this species (e.g. 'setosa')
#* @get /plot
#* @serializer png
#* @tag plb
function(spec){
  myData <- iris
  title <- "All Species"

  # Filter if the species was specified
  if (!missing(spec)){
    title <- paste0("Only the '", spec, "' Species")
    myData <- subset(iris, Species == spec)
  }

  plot(myData$Sepal.Length, myData$Petal.Length,
       main=title, xlab="Sepal Length", ylab="Petal Length")
}

#* Lookup a user
#* @get /users/<id>
#* @tag plb
function(id){
  subset(users, uid %in% id)
}

 
