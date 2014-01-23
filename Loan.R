library(caret)
pp<-preProcess(train, method=c("BoxCox", "medianImpute"))
ntrain<-predict(pp, train)
ntest<-predict(pp, test)
nzv<-nearZeroVar(ntrain)
fntrain<-ntrain[,-nzv]
fntest<-ntest[, -nzv]
traincorr<-cor(fntrain)
hcorr<-findCorrelation(traincorr)
fnt<-fntrain[, -hcorr]
fntest<-fntest[,-hcorr]
loss<-train$loss
trn<-cbind(fnt, loss)