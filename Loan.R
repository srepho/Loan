library(caret)
loss<-train$loss
train$loss<-NULL
pp<-preProcess(train, method=c("BoxCox", "medianImpute", "scale", "center"))
ntrain<-predict(pp, train)
ntest<-predict(pp, test)
nzv<-nearZeroVar(ntrain)
fntrain<-ntrain[,-nzv]
fntest<-ntest[, -nzv]
traincorr<-cor(fntrain)
hcorr<-findCorrelation(traincorr)
fnt<-fntrain[, -hcorr]
fntest<-fntest[,-hcorr]
trn<-cbind(fnt, loss)
trnIndex<-createDataPartition()
model<-train(trn$loss~., data=trn, method="enet", trControl=trainControl(method="repeatedcv", repeats=5))