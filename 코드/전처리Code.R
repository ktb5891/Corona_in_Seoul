getwd()
setwd("C:/Users/ktb58/OneDrive/바탕 화면/210308/코로나_미니프로젝트")

library(dplyr)
f = read.csv('2020_서울시_인구.csv')
head(f)

sel = select(f,'지역','인구')
head(sel)

w = read.csv('서울시 코로나19 확진자 현황.csv')
head(w)
View(w)

sel_w = select(w,'확진일','지역')

View(sel_w)

sel_w = rename(sel_w,
               date = '확진일',
               area = '지역'
               )
# 한글 변수명 영문으로 변경
head(sel_w)

sel_w = cbind(sel_w, dates = substr(sel_w$date,1,7))
# yyyy-mm의 구조만 받아 월별로 구분


areas= c(levels(sel_w[,'area']))
# 구별 이름 불러오기

for(i in (1:length(areas))){
  pick_area = data.frame(sel_w %>%
                           filter(area == areas[i]) %>%
                           group_by(dates) %>%
                           tally())
  print(areas[i])
  print(head(pick_area))
  
}
# 각 구의 월별 코로나 확진 현황

sel_sd = data.frame(sel_w %>%
                      filter(area == '성동구') %>%
                      group_by(dates) %>%
                      tally()
)
sel_sd
# 성동구의 월별 코로나 확진 현황

sel_gj = data.frame(sel_w %>%
                      filter(area == '광진구') %>%
                      group_by(dates) %>%
                      tally())
sel_gj
# 광진구의 월별 코로나 확진 현황

sel_sc = data.frame(sel_w %>%
                      filter(area == '서초구') %>%
                      group_by(dates) %>%
                      tally())
sel_sc
# 서초구의 월별 코로나 확진 현황

sel_ep = data.frame(sel_w %>%
                      filter(area == '은평구') %>%
                      group_by(dates) %>%
                      tally())
sel_ep
# 은평구의 월별 코로나 확진 현황

sel_sp = data.frame(sel_w %>%
                      filter(area == '송파구') %>%
                      group_by(dates) %>%
                      tally())

sel_sp
# 송파구의 월별 코로나 확진 현황

library(ggplot2)
ggplot(sel_ep,aes(x = dates ,y = n)) + geom_histogram(stat='identity') + ggtitle("은평구 코로나 동향")
ggplot(sel_gj,aes(x = dates ,y = n)) + geom_histogram(stat='identity') + ggtitle("광진구 코로나 동향")
ggplot(sel_sp,aes(x = dates ,y = n)) + geom_histogram(stat='identity') + ggtitle("송파구 코로나 동향")
ggplot(sel_sc,aes(x = dates ,y = n)) + geom_histogram(stat='identity') + ggtitle("서초구 코로나 동향")
ggplot(sel_sd,aes(x = dates ,y = n)) + geom_histogram(stat='identity') + ggtitle("성동구 코로나 동향")
# 각 구별 코로나 확진 현황 히스토그램 그래프
