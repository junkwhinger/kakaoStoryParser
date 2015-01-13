library("XML")
library("xlsx")
library("CSS")

name_of_file <- readline("type in the name of html file without .html: ")

file_name <- paste(name_of_file, ".html", sep="")

k_doc <- htmlParse(file_name, encoding="UTF-8")

k_root <- xmlRoot(k_doc)

time <- xpathSApply(k_doc, "//a[@class='time _linkPost']", xmlValue)

content <- cssApplyInNodeSet(k_doc, ".fd_cont", ".txt_wrap", cssCharacter)

likes <-cssApply(k_doc, "._likeCount", cssNumeric)

comments <-cssApply(k_doc, "._commentCount", cssNumeric)

shares <-cssApply(k_doc, "._shareCount", cssNumeric)

link <- xpathSApply(k_root, "//a[@class='time _linkPost']", xmlGetAttr, "href")

link_pasted <- paste("https://story.kakao.com", link, sep="")

final <- cbind(time, likes, comments, shares, link_pasted, content)

renamed_file <- paste("done", name_of_file, sep="_")

xlsx_file <- paste(renamed_file, ".xlsx", sep="")

write.xlsx(final, xlsx_file)
