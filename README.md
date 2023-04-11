# Candy-Crush-Game
Build a candy crush game in Assembly Language

I have designed a candy crush game. It displays four screens.
The first screen shows name of the game. Then it takes input from user of their name. We have taken the input through a string and displayed the title Candy Crush through a string.
Now after this. We pressed “enter” and moved to the second screen. Over here we have displayed the instructions of the game. In the end of the page we displayed “press enter to move to next page”. Now after pressing “enter” we entered the third page.
The third page displays our entire game. We made 6 different shape which are:
1. Pentagon
2. Square
3. Rectangle
4. Diamond
5. Triangle
6. Octagon
Now in this page we also displayed a color bomb which is of pyramid shape. User will play the game in this screen. After the game is over. Our fourth and last page is displayed. This page display the final score and the username.
We have also done file handling, the name and the score of the user is stored in that “txt” file.
Variables:
1. msg1 db
2. msg2 db
3. msg3 db
4. msg4 db
5. msg5 db
6. msg6 db
7. msg7 db
8. t1 dw 0
9. t2 dw 0
10. t3 dw 0
11. t4 dw 0
12. t5 dw 0
13. instruction db
14. msg17 db
15. right_prompt db
16. username db
17. namedisplay db
18. moves db
19. score db
20. final_score db
21. next_page db
22. colorbomb db
23. PLAYERSHOW db
24. name_arr db
25. matrix db
26. a1 db
27. a2 db
28. a3 db
29. a4 db
30. a5 db
31. rand db
32. counter1 db
33. v1 dw
34. pentagon1 dw
35. pentagon2 dw
36. v2 dw
37. diamond1 dw
38. diamond2 dw
39. octagon1 dw
40. octagon2 dw
41. v5 dw
42. v3 dw
43. v4 dw
44. v7 dw
45. x_axis dw
46. y_axis dw
47. counter2 dw
48. storing_Si dw
49. index dw
50. clickX dw
51. clicky dw
52. fname db
53. fhandle dw
54. buffer db
55. msg dw
56. s1 db
57. s2 db
58. s3 db
59. s4 db
60. s5 db
