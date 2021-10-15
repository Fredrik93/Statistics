library(rethinking)


plot(m.OT)
precis(m.OT)


mean(OT)
sd(OT)

compare(m.OT,m.NT, FUNC=WAIC)

dataf