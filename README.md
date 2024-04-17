# Drafting The Best Alternative

### Impetus
Tom Brady was drafted in 2000 after such players as Giovanni Carmazzi and Tee Martin. Of course there were great players in the 2000 draft class (Urlacher and Alexander, for example), but I think it is reasonable to suggest that almost every team would go back and take Brady if they could get a redo. While he may be an extreme outlier, it raises the question of how often do teams make the correct choice within a set of constrained alternatives. By that I mean, it is worthwhile to consider how draftees are evaluated compared to the next alternative within their position. For instance, the Chicago Bears have a high stakes choice to make with the first pick of the 2024 draft, in which they will surely take a quarterback. No disrespect to players like Marvin Harrison Jr., but the Bears' choice is really constrained to the available QB candidates. 

### Approach
This project looks at how good of a job NFL teams do at drafting players within the same position. It makes some strong assumptions (explained in detail later) about how drafting works, but the essential idea is as follows:
- Teams evaluate draftees relative to their positional comparisons (WRs are compared to other WRs, for example).
- When a team makes a decision to draft a player, the available options for that selection are all of the players in the draft who play that position (if a team is taking a TE with the 45 pick they are selecting from all available tight ends left in the draft class).
- When a team drafts a player, I treat them as if they stay on the same team for their entire career (this is obviously incorrect but post-draft contracts isn't really a part of this as the assumption is that teams keep their players).

### Data
Data for this project comes for www.pro-football-reference.com (PFR). I collected each draft list from 1990 - 2022 (more recent drafts have players too early in their careers to effectively answer these questions, I think) resulting in 8,581 players. The data is cleaned as follows:
- All CBs become DBs
- All OTs become Ts
- All KRs become WRs
- 30 players with DT/DE position listings are corrected to their player listing in PFR.

To find the value of each pick I use one of two measures from PFR: AV and wAV. The description of them is here: https://www.pro-football-reference.com/about/approximate_value.htm. Put simply, they are measures of the total "value" that the player's career had.

### Findings
TLDR: Teams are generally pretty good at drafting the better player.

