# Drafting The Best Alternative

### Impetus
Tom Brady was drafted in 2000 after such players as Giovanni Carmazzi and Tee Martin. Of course, there were great players in the 2000 draft class (Urlacher and Alexander, for example), but I think it is reasonable to suggest that almost every team would go back and take Brady if they could get a redo. While he may be an extreme outlier, it raises the question of how often teams make the correct choice within a set of constrained alternatives. By that I mean, it is worthwhile to consider how draftees are evaluated compared to the next alternative within their position. For instance, the Chicago Bears have a high stakes choice to make with the first pick of the 2024 draft, in which they will surely take a quarterback. No disrespect to players like Marvin Harrison Jr., but the Bears' choice is really constrained to the available QB candidates. 

### Approach
This project looks at how good of a job NFL teams do at drafting players within the same position. It makes some strong assumptions (explained in detail later) about how drafting works, but the essential idea is as follows:
- Teams evaluate draftees relative to their positional comparisons (WRs are compared to other WRs, for example).
- When a team makes a decision to draft a player, the available options for that selection are all of the players in the draft who play that position (if a team is taking a TE with the 45 pick, they are selecting from all available tight ends left in the draft class).
- When a team drafts a player, I treat them as if they stay on the same team for their entire career (this is obviously incorrect but post-draft contracts isn't really a part of this as the assumption is that teams keep their players).

### Data
Data for this project comes for www.pro-football-reference.com (PFR). I collected each draft list from 1990 - 2022 (more recent drafts have players too early in their careers to effectively answer these questions, I think) resulting in 8,581 players. Each draft file includes the draft order, player drafted for each pick, the position they play(ed), and their career statistics. There are discrepancies in how players are listed to the data is cleaned as follows:
- All CBs become DBs
- All OTs become Ts
- All KRs become WRs
- ~30 players with DT/DE position listings are corrected to their player listing in PFR.
- Teams are updated to reflect their *current* team (e.g. the Raiders are the Las Vegas Raiders for all drafts).

To find the value of each pick I use one of two measures from PFR: AV and wAV. The description of them is here: https://www.pro-football-reference.com/about/approximate_value.htm. Put simply, they are measures of the total "value" that the player's career had. AV is the raw number and wAV is a weighted measure of AV that discounts the value of each year. Crucially, I take the HIGHER of these two numbers for each player. The rationale is two-fold. The first is that not every player has a metric for each value and taking the higher generally accounts for that. The second is that I am trying to be as generous as possible to teams while using an imprecise tool. Going forward, I will refer to the player's AV with the understanding that it means the higher of their AV and wAV.

The main variable of interest is what I call NAV (or Next Alternative Value). NAV is the difference between the AV of the player drafted and the AV of the player that was drafted in the same position after them. For example, in 1996 the New York Jets selected Keyshawn Johnson (WR) with the first pick of the draft and an AV of 79. The next WR taken was Terry Glen at 67. Johnson's NAV is his 79 minus Glen's 12, resulting in a NAV of 12. Essentially, the Jets gained 12 AV points by picking Johnson over Glen.

### Findings
TLDR: Teams are generally pretty good at drafting the better player.

I look at this in a few different ways. The first is simply looking at how each team did over those drafts as both a raw number of added value and a median added value. The is Figure XXXX below.

FIGURE XXXX

Here we see that, generally speaking, most teams have a positive NAV score in both total terms (NAV of each pick summed over 32 drafts) and their median NAV added. There are exceptions, of course. Cleveland (a reoccuring theme as we will see), Cincinnati, and Las Vegas are pretty bad at drafting over our window.
