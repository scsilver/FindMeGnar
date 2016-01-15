#Find Me Gnar

###Finds closest colorado resorts to you and displays 24 hour snow fall, current base, and temperature.

###Living at: [Find Me Gnar](http://findmegnar.herokuapp.com)



##Data Sources

###Real Time Crowd Sourced data
- Resort Relevant tweets (Twitter Api)

###Continuously updating data
- Road conditions for directions to resort (CDOT)
- Road cams for roads listed in directions to resort (CDOT)

###Daily Data
- Resorts Snowfall and Base stats (From each resorts site)
- Resorts temperature stats (Wunderground Api)

##TODO
- obtain data feeds from CDOT
- functions to find roadcams and roads along way to resort with
  - path from google maps api includes geo coordinates
  - google directions include road names
  - find roadcams close to directions path and display those images
  - find roads along google maps path and display conditions of each road on the directions panel
  - also color code sections of google path as road conditions
