
library(httr)
library(CSS)

function(listPageUrl){
  res <- GET(listPageUrl,set_cookies(over18=1))
  node = content(res, encoding = "utf8")
  node[cssToXpath(".title a")]
  postUrls = cssApply(node,".title a",function(node){
    sprintf("https://www.ptt.cc%s",xmlAttrs(node)["href"])
  })
}



####################################################
# getPostUrls via GET Method with cookie
####################################################
getPostUrls<-function(x){
listPageUrl = allListUrls[10]
res <- GET(listPageUrl,set_cookies(over18=1))
node = content(res, encoding = "utf8")
node[cssToXpath(".title a")]
postUrls = cssApply(node,".title a",function(node){
  sprintf("https://www.ptt.cc%s",xmlAttrs(node)["href"])
})
}


resWithoutCookie <-"https://www.ptt.cc/bbs/Gossiping/index.html"
getPostUrls(resWithoutCookie)



