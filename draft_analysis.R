library(forecast)
rm(list=ls())

load("drafts.rdata")

### Reduce to first 254 picks
drafts <- drafts[drafts$pick<255,]

### Add 1 for later aggregation
drafts$ones <- 1

### Creating Team NAV data
### Total NAV
teams <- aggregate(NAV ~ tm, data = drafts, FUN = "sum")
teams$nums <- 1:length(teams$tm)

### Mean NAV
teams.m <- aggregate(NAV ~ tm, data = drafts, FUN = "mean")
teams.m$nums <- 1:length(teams.m$tm)

### Ordered Total NAV
teams.order <- teams
teams.order <- teams.order[order(teams.order$NAV, decreasing = T),]
teams.order$nums <- 1:length(teams.order$tm)

### Ordered Mean NAV
teams.orderm <- teams.m
teams.orderm <- teams.orderm[order(teams.orderm$NAV, decreasing = T),]
teams.orderm$nums <- 1:length(teams.orderm$tm)

### Figure 1
png("teams.fig1.png", width = 750, height = 600)
plot(teams.order$nums,teams.order$NAV, axes = F, ylim = c(-800,2000), pch = 16, cex = 1, xlab = "", ylab = "Combined Value of Next Alternative")
axis(1, seq(1:length(teams.order$tm)), labels = teams.order$tm,las=2)
axis(2, seq(-800,2000, by = 200), las = 1)
abline(h=0, col = "gray")
abline(h=median(teams.order$NAV), col = "firebrick")
points(teams.order$nums,teams.order$NAV, pch = 16, cex = 1.5)
dev.off()

### Figure 2
png("teams.fig2.png", width = 750, height = 600)
plot(teams.orderm$nums,teams.orderm$NAV, axes = F, ylim = c(-3,7), pch = 16, cex = 1.5, xlab = "", ylab = "Mean Value of Next Alternative")
axis(1, seq(1:length(teams.orderm$tm)), labels = teams.order$Tm,las=2)
axis(2, seq(-3,7, by = 1), las = 1)
abline(h=0, col = "gray")
abline(h=median(teams.orderm$NAV), col = "firebrick")
points(teams.orderm$nums,teams.orderm$NAV, pch = 16, cex = 1.5)
dev.off()

### Mean Offensive vs Defensive NAV
### Create List of positions
table(drafts$pos, useNA = "always")
offense <- c("C","FB","G","OL","OT","QB","RB","T","TE","WR")
defense <- c("CB","DB","DE","DL","ILB","NT","OLB","S","DT","LB")
specialteams <- c("K","LS","P")

### Code each position by side of the ball
drafts$side <- NA
drafts$side[drafts$pos %in% offense] <- "offense"
drafts$side[drafts$pos %in% defense] <- "defense"
table(drafts$side, useNA = "always")

### Aggregate NAV by position and team
team.o <- aggregate(NAV ~ tm + side, data = drafts[drafts$side=="offense",], FUN = "mean")
colnames(team.o) <- c("tm","offense","o.diff")
team.o <- team.o[c("tm","o.diff")]
team.d <- aggregate(NAV ~ tm + side, data = drafts[drafts$side=="defense",], FUN = "mean")
colnames(team.d) <- c("tm","defense","d.diff")
team.d <- team.d[c("tm","d.diff")]

### Merge with teams data
teams <- merge(teams, team.o, by = "tm")
teams <- merge(teams, team.d, by = "tm")

### Each position by team (not analyzed)
team.pos <- aggregate(NAV ~ tm + pos, data = drafts, FUN = "mean")

### Create labels for figure
plotteams <- teams$tm

png("teams.fig3.png", width = 800, height = 600)
plot(teams$o.diff, teams$d.diff, ylim = c(-10, 10), xlim = c(-10,10), axes = F, pch = 16, cex = 1.5, ylab = "Defensive Next Alternative", xlab = "Offensive Next Alternative", type = "n")
abline(v = 0, h = 0, col = "gray")
abline(0,1, col = "gray", lty = 3)
axis(1, seq(-10,10, by = 2),las=1)
axis(2, seq(-10,10, by = 2), las = 1)
text(teams$o.diff, teams$d.diff, labels = plotteams)
dev.off()

### Cleaning up
rm(team.d, team.o, defense, offense, specialteams, plotteams)

### Analysis by Pick
### Aggregation of NAV by Pick
picks <- aggregate(NAV ~ pick, data = drafts, FUN = "sum")
picks.m <- aggregate(NAV ~ pick, data = drafts, FUN = "mean")
picks.av <- aggregate(av ~ pick, data = drafts, FUN = "mean")
picks.av$av <- round(picks.av$av, digits = 3)
colnames(picks.av) <- c("pick","av")
picks.m$NAV <- round(picks.m$NAV, digits = 3)
colnames(picks.m) <- c("pick","mNAV")
picks <- merge(picks, picks.m, by = "pick")
picks <- merge(picks, picks.av, by = "pick")

### Getting graphing points
bp <- max(barplot(picks$av))

### Figure 4
png("teams.fig4.png", width = 1500, height = 1200)
barplot(picks$av, axes = F, ylim = c(0,70), ylab = "Mean AV of Picks", xlab = "")
axis(1, seq(0.7,bp, by = 1.2), labels = 1:length(picks$pick), las = 2)
axis(2, seq(0,70, by = 5), las = 1)
dev.off()

### Figure 5
bp <- max(barplot(picks.small$av))
picks.small <- picks[picks$pick<65,]
png("teams.fig5.png", width = 1000, height = 800)
barplot(picks.small$av, axes = F, ylim = c(0,70), ylab = "Mean AV of Picks", xlab = "")
axis(1, seq(0.7,bp, by = 1.2), labels = 1:length(picks.small$pick), las = 2)
axis(2, seq(0,70, by = 5), las = 1)
dev.off()

### Figure 6
bp <- max(barplot(picks.small$av))
picks.small <- picks[picks$pick<65,]
png("teams.fig6.png", width = 1000, height = 800)
barplot(picks.small$mNAV, axes = F, ylim = c(-12,20), ylab = "Mean Value of Next Alternative", xlab = "")
axis(1, seq(0.7,76.3, by = 1.2), labels = 1:length(picks.small$pick), las = 2)
axis(2, seq(-12,20, by = 4), las = 1)
dev.off()

### Cleaning up
rm(picks.av, picks.m,bp)

### NAV By position
### Aggregate Total NAV by position
pos <- aggregate(NAV ~ pos, data = drafts, FUN = "sum")
pos$nums <- 1:length(pos$NAV)

### Aggregate Mean NAV by position
pos.m <- aggregate(NAV ~ pos, data = drafts, FUN = "mean")
pos.m$nums <- 1:length(pos.m$NAV)

### Ordered NAV by Levels
pos.order <- pos.m
pos.order$nums <- factor(pos.order$nums, levels = c(1, 14, 6, 17, 15, 5, 18, 19, 11, 7, 4, 3, 9, 12, 16, 2, 8, 13, 10))
pos.order <- pos.order[order(pos.order$nums),]
pos.order$nums <- 1:length(pos.order$pos)

### Figure 7
png("teams.fig7.png", width = 800, height = 600)
plot(pos.order$nums,pos.order$NAV, axes = F, ylim = c(0,16), pch = 16, cex = 1.5, xlab = "Positions", ylab = "Combined Value of Next Alternative")
axis(1, seq(1:length(pos.order$pos)), labels = pos.order$pos,las=2)
axis(2, seq(0,14, by = 2), las = 1)
abline(v=8.5, col = "black", lty = 3)
abline(v=16.5, col = "black", lty = 3)
points(pos.order$nums,pos.order$NAV, pch = 16, cex = 1.5)
text(x = 4.5, y = 16, labels = "Offense")
text(x = 12.5, y = 16, labels = "Defense")
text(x = 18.5, y = 16, labels = "ST")
dev.off()

### Best and Worst Drafts
head(drafts[order(drafts$NAV),])
head(drafts[order(drafts$NAV, decreasing = T),])

### Most AV between picks
drafts$sum <- drafts$av + drafts$nextPav
head(drafts[order(drafts$sum, decreasing = T),])

### College Analysis
### Aggregate mean NAV
schools.m <- aggregate(NAV ~ school, data = drafts, FUN = "mean")
schools.m$nums <- 1:length(schools.m$school)
school.count <- aggregate(ones ~ school, data = drafts, FUN = "sum")
schools.m <- merge(schools.m, school.count, by = "school", all.x = T, all.y = F)

### Reduce to schools with at least 5 picks
schools.short <- schools.m[schools.m$ones>4,]
schools.short <- schools.short[order(schools.short$NAV, decreasing = T),]
schools.short$nums <- 1:length(schools.short$school)

### Figure 8
png("teams.fig8.png", width = 800, height = 600)
par(mar=c(9.1, 4.1, 4.1, 2.1))
plot(schools.short$nums,schools.short$NAV, axes = F, ylim = c(-40,40), pch = 16, cex = .75, ylab = "Mean Value of Next Alternative", xlab = "")
axis(1, seq(1:length(schools.short$school)), labels = schools.short$school,las=2)
axis(2, seq(-40,40, by = 4), las = 1)
abline(h=0, col = "gray")
abline(h=median(schools.short$NAV), col = "firebrick")
points(schools.short$nums,schools.short$NAV, pch = 16, cex = .75)
dev.off()

### Schools by NAV
head(schools.short[order(schools.short$NAV, decreasing = T),])


