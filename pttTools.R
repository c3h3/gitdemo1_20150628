
library(httr)
library(XML)
library(CSS)

getPostData = function(postUrl){
  res <- GET(postUrl,set_cookies(over18=1))
  node = htmlParse(content(res, "text", encoding = "utf8"))
  
  ############ Exploratory Selector Analysis ############
  # Board
  node[cssToXpath(".article-metaline-right > .article-meta-value")]
  # Author, Title, Time
  node[cssToXpath(".article-metaline > .article-meta-value")]
  # Post Text
  node[cssToXpath("#main-content")]
  # Post Pushes
  node[cssToXpath("div.push")]
  
  
  
  ############ Data Parser ############
  
  postData = list()
  postData$Board = cssApply(node,".article-metaline-right > .article-meta-value",cssCharacter)
  
  metaTemp = cssApply(node,".article-metaline > .article-meta-value",cssCharacter)
  
  postData$Author = metaTemp[1]
  postData$Title = metaTemp[2]
  postData$Time = metaTemp[3]
  
  removeNodes(node[cssToXpath(".article-metaline-right > .article-meta-value")])
  removeNodes(node[cssToXpath(".article-metaline > .article-meta-value")])
  
  node[cssToXpath(".article-metaline-right > .article-meta-value")]
  node[cssToXpath(".article-metaline > .article-meta-value")]
  
  print(xmlValue(node[cssToXpath("#main-content")][[1]]))
  cat(xmlValue(node[cssToXpath("#main-content")][[1]]))
  
  postData$Text = xmlValue(node[cssToXpath("#main-content")][[1]])
  
  postData$postUrl = postUrl
  postData$postId = gsub("[/]|.html","",unlist(strsplit(postUrl,postData$Board))[2])
  
  
  node[cssToXpath("div.push")]
  
  lapply(node[cssToXpath("div.push")],function(test){
    list(pushTag=xmlValue(test["span"][[1]]),
         userId=xmlValue(test["span"][[2]]),
         text=xmlValue(test["span"][[3]]),
         time=xmlValue(test["span"][[4]]))
  })
  
  pustData = lapply(node[cssToXpath("div.push")],function(test){
    list(pushTag=xmlValue(test["span"][[1]]),
         userId=xmlValue(test["span"][[2]]),
         text=xmlValue(test["span"][[3]]),
         time=xmlValue(test["span"][[4]]))
  })
  
  
  pushDf = data.frame(postId = postData$postId,
                      postUrl = postUrl,
                      do.call(rbind,pustData),stringsAsFactors = FALSE)
  
  return(list(postData=postData,pushDf=pushDf))
  
}

testpostUrl <- "https://www.ptt.cc/bbs/Gossiping/M.1431338763.A.1BF.html"
getPostData(testpostUrl)

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



