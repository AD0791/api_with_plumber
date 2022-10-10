library("plumber")



#* @get /query/parameters
#* @serializer text
#* @param name:str
#* @param age:[int]
#* @tag hookie
function(name, age) {
  # Explicit conversion is required for query parameters
  age <- as.integer(age)
  sprintf("%s is %i years old", name, max(age))
}

#* @get /dyn/<name:str>/<age:[int]>/route
#* @serializer text
#* @parser none
#* @response 200 A sentence
#* @tag hookie
function(name, age) {
  sprintf("%s is %i years old", name, age)
}

#* @post /upload_file
#* @serializer rds
#* @parser multi
#* @parser rds
#* @param f:file A file
#* Upload an rds file and return the object
#* @tag hookie
function(f) {
  as_attachment(f[[1]], names(f)[1])
}
