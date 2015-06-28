print ("test")


library(httr)
library(XML)

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

