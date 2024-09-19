## Title: A/B Testing for Mobile Games - Cookie Cats

Note: I attached a more detailed report to this repository, or you can check it [here](https://docs.google.com/document/d/1pL8tICQDnqSXg67VhRJv5e9x0mTI0DC45bvKwSCqGsY/edit?usp=sharing).

**Goal:**
The goal of this A/B test is to assess the impact of moving the first gate in the Cookie Cats mobile game from level 30 to level 40. Specifically, the goal is to determine how this change affects player engagement, retention rates (both after 1 day and 7 days), and the number of game rounds played within the first 14 days after installation.

### Experiment Design

**Contents**

The dataset consists of data from 90,189 players who installed the game during the A/B test period. 
Task Variables

The variables provided in the dataset include:

- user-id: A unique number that identifies each player.
- version: Whether the player was put in the control group (gate_30 - a gate at level 30) or the group with the moved gate (gate_40 - a gate at level 40).
- sum_gamerounds: the number of game rounds played by the player during the first 14 days after installation.
- retention_1: Did the player come back and play 1 day after installing?
- retention_7: Did the player come back and play 7 days after installing?
  
*When a player installed the game, he or she was randomly assigned to either.*


**Metrics Choice**
I used BigQuery to run queries and generate key metrics required for this analysis.

1. The variables are 
2. game_version;
3. no_of_users, 
4. no_of_retention_1;
5. retention_1_rate;
6. no_of_retention_7;
7. retention_7_rate;
8. Mean_of_gamerounds,
9. stddev_of_gamerounds,
10. min_value
11. max_value

Check this [spreadsheet](https://docs.google.com/spreadsheets/d/1SXEuinrPQaJxRC5HCiAIyNd29gshLlAIH0HKRPnPWzA/edit?gid=979159770#gid=979159770) or the table below below.

Note: 	gate_30 is the control group; and 
gate_40 is the experiment group

| game_version | no_of_users | no_of_retention_1 | retention_1_rate | no_of_retention_7 | retention_7_rate | mean_of_gamerounds | stddev_of_gamerounds | min_value | max_value |
|--------------|-------------|------------------|------------------|-------------------|------------------|--------------------|----------------------|-----------|-----------|
| gate_30      | 44700       | 20034            | 0.4482           | 8502              | 0.1902           | 52.4563            | 256.7164             | 0         | 49854     |
| gate_40      | 45489       | 20119            | 0.4423           | 8279              | 0.1820           | 51.2988            | 103.2944             | 0         | 2640      |


In the results shown in the table above, the retention_1 rate and retention_7 rate for the gate_30 group are higher than that of the gate_40 group. Additionally, the standard deviation of game rounds and the mean of game rounds are also higher than that of the gate_40 group, further indicating that the gate_30 group performed better overall compared to the gate_40 group. 

**However, this is not sufficient enough to launch the features. Further analysis needs to be conducted on the evaluation metrics to guide our actions.** 

**Hypothesis**
Null hypothesis (H0): The retention rate is the same for both groups (no difference). I.e H0 : p1​=p2​

Alternative hypothesis (Ha​​): The retention rates are different between the two groups. i.e Ha: p1≠p2


For my next step, I used Evan Millers’s Chi-Squared Test and the 2 Sample T-Test calculator to carry out my A/B test.

### Test 1: Evan Millers’s Chi-Squared Test

**Evan Millers’s Chi-Squared Test**

| Evan Miller’s Chi-Squared Test (95% CI) | p-value | Statistically significant? |
|-----------------------------------------|---------|----------------------------|
| Retention_1                             | 0.074   | No                         |
| Retention_7                             | 0.00155 | Yes                        |



**Evan Millers’s 2 Sample T-Test**

| p-value | Statistically significant? |
|---------|----------------------------|
| 0.38    | No                         |



**1. Description of Statistical Tests:**
2-Sample T-Test: A 2-sample t-test was conducted to compare the mean number of game rounds played between Gate 30 and Gate 40.
Chi-Squared Tests: Two separate Chi-Squared tests were conducted to assess the differences in retention rates:
Retention after 1 day: The chi-squared test yielded a p-value of 0.074.
Retention after 7 days: The chi-squared test yielded a p-value of 0.0016.


**2. Estimated Treatment Effect:**
Difference in Means (Game Rounds): The estimated difference in mean game rounds between Gate 30 (Sample 1) and Gate 40 (Sample 2) is 1.157, with Gate 30 players playing more rounds on average.


**3. Confidence Intervals:**
Gate 30 (Game Rounds): 52.456 ± 2.38 (50.076 to 54.836).
Gate 40 (Game Rounds): 1.299 ± 0.949 (0.350 to 2.248).
These confidence intervals indicate that Gate 30 has a higher mean game round than Gate 40.

**4. P-Values:**
- 2-Sample T-Test: The p-value is 0.38, indicating no statistically significant difference in the mean number of game rounds between Gate 30 and Gate 40.
- Chi-Squared Test (Retention after 1 day): The p-value is 0.074, which is above the standard alpha level of 0.05. While this suggests some difference in day 1 retention between Gate 30 and Gate 40, it is not statistically significant.
- Chi-Squared Test (Retention after 7 days): The p-value is 0.0016, which is well below 0.05, indicating a statistically significant difference in retention rates after 7 days, with Gate 30 showing better long-term retention.


#### Summary Statement
- Retention after 1 day: The p-value of 0.074 suggests that the difference between Gate 30 and Gate 40 is marginally insignificant. While Gate 30 has a slightly higher retention rate (44.82% vs. 44.23%), this result is not statistically significant.
  
- Retention after 7 days: With a highly significant p-value of 0.0016, Gate 30 clearly outperforms Gate 40 in long-term retention (19.02% vs. 18.20%). This is a crucial metric, as long-term retention typically indicates stronger player engagement.

- Game Rounds Played: Although Gate 30 has a higher mean number of game rounds (52.46 vs. 51.30), the difference is not statistically significant (p = 0.38). This suggests that the change in the gate position does not drastically affect overall player engagement measured by game rounds.


**Recommendation**
Given that the retention rates after 7 days show a statistically significant improvement for Gate 30, this should be the preferred option, even though the retention after 1 day and the number of game rounds played are not significantly different. Long-term player engagement is typically more valuable, making Gate 30 a better choice for maximizing retention.


**Action** 
Leave Gate 30 as the first gate as it shows stronger long-term player retention, which is likely to yield more sustained engagement over time.


Note: I attached a more detailed report and the .sql file to this repository, or you can check it [here](https://docs.google.com/document/d/1pL8tICQDnqSXg67VhRJv5e9x0mTI0DC45bvKwSCqGsY/edit?usp=sharing) and [here](https://github.com/bayoxx/A-B-Testing-for-Mobile-Games---Cookie-Cats/blob/main/Cookie%20Cats%20game.sql).

Task Source: Kaggle


