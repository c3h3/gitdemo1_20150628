<<<<<<< HEAD
print ("test")

=======
>>>>>>> add func1

library(httr)
library(XML)

<<<<<<< HEAD
####################################################
# getTown via POST cityid
####################################################
# connector
URL="http://emap.pcsc.com.tw/EMapSDK.aspx"
getTown<-function(x){
res = POST("http://emap.pcsc.com.tw/EMapSDK.aspx",
           body=list(commandid="GetTown",cityid="01"))

# parser
node = xmlParse(content(res,as="text"))
View(xmlToDataFrame(node["//GeoPosition"]))
}

=======
func1 = function(city="台北市",town="大安區"){
  res = POST("http://emap.pcsc.com.tw/EMapSDK.aspx",
             body=list(commandid="SearchStore",city=city,town=town))
  
  # parser
  node = xmlParse(content(res,as="text"))
  xmlToDataFrame(node["//GeoPosition"])  
}

# func1()
>>>>>>> add func1
