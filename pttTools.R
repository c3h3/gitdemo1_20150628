
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
