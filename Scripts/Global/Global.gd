extends Node

var enemies : Array


#Global variable used to check if the shop is opened.
#It is triggered by the "Shop" control node and by the
#"Exit" button
#If true, the player can not move
var shop_opened : bool = false
