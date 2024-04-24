# Drafting The Best Alternative

### Impetus
Tom Brady was drafted in 2000 after such players as Giovanni Carmazzi and Tee Martin. While there were great players in the 2000 draft class (Urlacher and Alexander, for example), I think it is reasonable to suggest that almost every team would go back and take Brady if they could get a redo. While he may be an extreme outlier, it raises the question of how often teams make the correct choice within a set of constrained alternatives. By that I mean, it is worthwhile to consider how draftees are evaluated compared to the next alternative within their position. For instance, the Chicago Bears have a high stakes choice to make with the first pick of the 2024 draft in which they will surely take a quarterback. No disrespect to players like Marvin Harrison Jr., but the Bears' choice is really constrained to the available QB candidates. 

### Approach
This project looks at how good of a job NFL teams do at drafting players within the same position. It makes some strong assumptions (explained in detail later) about how drafting works, but the essential idea is as follows:
- Teams evaluate draftees relative to their positional comparisons (WRs are compared to other WRs, for example).
- When a team makes a decision to draft a player, the available options for that selection are all of the players in the draft who play that position (if a team is taking a TE with the 45 pick, they are selecting from all available tight ends left in the draft class).
- When a team drafts a player, I treat them as if they stay on the same team for their entire career (this is obviously incorrect but post-draft contracts isn't really a part of this as the assumption is that teams keep their players).

These assumptions aren't fully backed up in reality, of course. Sometimes teams will draft the best available player regardless of position. While this approach does not account for that, I think it is a somewhat reasonable assumption to make that, in general, players are drafted based on need at that position.

### Data
Data for this project comes for www.pro-football-reference.com (PFR). I collected each draft list from 1990 - 2022 (more recent drafts have players too early in their careers to effectively answer these questions, I think) resulting in 8,581 players. Each draft file includes the draft order, player drafted for each pick, the position they play(ed), and their career statistics. There are discrepancies in how players are listed to the data is cleaned as follows:
- All CBs become DBs
- All OTs become Ts
- All KRs become WRs
- ~30 players with DT/DE position listings are corrected to their player listing in PFR.
- ~109 players with OL position listings are corrected to their player listing in PFR. Some of these are a little tricky as they either didn't play a game or swapped around positions. For these, I use the position they are listed as being drafted in. That isn't perfect but it one way to to easily handle it. Two players had no listing beyond OL in PFR. For those I simply searched for what their position is listed at in Wikipedia.
- Teams are updated to reflect their *current* team (e.g. the Raiders are the Las Vegas Raiders for all drafts).
- All drafts stop after the 254th pick. There are 283 players drafted after the 254th pick across all of the drafts, but the low counts for each pick skews our data so I removed them.

To find the value of each pick I used one of two measures from PFR: AV and wAV. The description of them is here: https://www.pro-football-reference.com/about/approximate_value.htm. Put simply, they are measures of the total "value" that the player's career had. AV is the raw number and wAV is a weighted measure of AV that discounts the value of each year. Crucially, I take the *higher* of these two numbers for each player. The rationale is two-fold. The first is that not every player has a metric for each value and taking the higher generally accounts for that. The second is that I am trying to be as generous as possible to teams while using an imprecise tool. Players without a AV or wAV score are listed as having a career AV of 0. Going forward, I will refer to the player's AV with the understanding that it means the higher of their AV and wAV.

The main variable of interest is what I call NAV (or Next Alternative Value). NAV is the difference between the AV of the player drafted and the AV of the player that was drafted in the same position after them. For example, in 1996 the New York Jets selected Keyshawn Johnson (WR) with the first pick of the draft and an AV of 79. The next WR taken was Terry Glenn at 7. Johnson's NAV is his 79 minus Glenn's 67, resulting in a NAV of 12 for Johnson. Essentially, the Jets gained 12 AV points by picking Johnson over Glen.

### Findings
TLDR: Teams are generally pretty good at drafting the better player.

I look at this in a few different ways. The first is simply looking at how each team did over those drafts as both a raw number of added value and a mean added value. This is Figure XXXX below. In both plots there is a gray line at 0 (teams below that line are pretty bad at drafting players) and a red line at the median NAV for that dataset (total NAV and median NAV respectively).

FIGURE 1: Total NAV Per Team
![screenshot](teams.fig1.png)

Here we see that, generally speaking, most teams have a positive NAV score in both total terms (NAV of each pick summed over 32 drafts) and their median NAV added. There are exceptions, of course. Cleveland (a reoccuring theme as we will see), Cincinnati, and Las Vegas are pretty bad at drafting over our window. Teams that have historically been successful on the field during our window tend to be better at drafting (Green Bay, Indianapolis, Balitmore, New England). 


#### The Best and Worst Picks to Have
I also wanted to look 

#### The Worst Draft Pick Ever
This won't be a suprise to anyone who has a decent understanding of draft history. It's Spergon Wynn, who was drafted 16 spots before Tom Brady and cost Cleveland 182 AV points. 

#### The Best Draft Pick Ever (besides Tom Brady)

#### The Best and Worst Schools To Draft From
Who doesn't love healthy trash talk between rival schools? In addition to looking at picks and teams, I wanted to see if teams are potentially relying on school reputation or on-field success instead of player ability. While this won't fully answer this question, it does provide some interesting comparisons. To start, I drop any school that doesn't have at least 4 players drafted over the last 33 years, a fairly generous window. It also helpfully reduces our school count from 371 to 189.

The best school for NAV? Harvard, with a mean NAV of 34.4 (predominantly driven by Matt Birk and Ryan Fitzpatrick). That being said, there are only 5 Harvard draftees in the data. Among schools with a decently large number of drafted players, Marshall (with 23 draftees and a mean NAV of 12.56) and Boston College (64 draftees and mean NAV of 10.5) stand out.

The worst schools include some lesser known institutions, like Texas State at -29.37 among its 8 draftees and Kansas, whos 34 draftees have a mean NAV of -5.41. Even among those schools with a large number of players drafted, results aren't always encouraging. Ohio State leads the drafted count with 202 players, but they only provide an average NAV of 0.72 whereas Alabama's 179 players (second most) have a NAV of 2.33. Bragging rights also are owned by Florida who come in tied for 3rd with FSU at 177 draftees but posess a much stronger NAV at 2.14 versus FSU's ... less than excellent ... -1.27.

