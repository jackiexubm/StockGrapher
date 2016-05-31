# finalProject2
# SASDAQ
# A stock simulator where you'll be able to make an account, start games
# (with others if we have time), read real time stock prices, look at the
# history of stocks and trade stocks. 

# GOALS 
# -be able to register and log in to an account
# -be able to look at current stock prices
# -be able to look at the real time graphs
# -be able to look at history of a stock
# -be able to start a simulation of trading stocks (a game)
# -be able to trade stocks and make a difference if significant amount of shares
# *be able to include friends in a game
# 

# * = if we have enough time 

# DEV LOG (date - who - what done)
# -May 11 - JX - initial commit
# -May 12 - JX - import import yahoofinance API and create basic test
#      	    	 methods for yahoofinanceAPI
#         - JX - fix error in MANIFEST.MF of yahoo jar file
# -May 13 - JM - Added user object, login, signUp. Not completed/has bugs
#         - JX - complete the function that graphs the trend of stock in
#	       	 past year
#	  - JX - complete code that gets quotes for past year in daily intervals
# -May 14 - JX - create getPastYear and getMinMax methods
#      	  - JX - complete method that graphs entire list of data with 
#	         correct scale given origin X and Y coords, width, and heigth
#         - JX - add drawing of axis, y axis scale, scale lines, and colored
#	          area under curve
#         - JX - add x and y titles
#         - JX - Make minor changes to improve visuals of graph
# -May 15 - JX - fix axis scale measurements and bugs
# -May 16 - JM - Added toString and fixed Driver. Still have to implement
#                encrypt()
#         - JM - Fixed Driver Bug
#         - JM - Finished 
# -May 19 - JX - add axis info onto graphRange
#		  - JX - complete graphRange function
#		  - JX - complete graph livePulled Stock list
#		  - JM - complete signUp
# -May 20 - JX - fix axis scale, graph lines, area under graph of graphRange
# -May 22 - JX - complete info chart for mouseover info
# 		  -	JX - Add datapoint pinpointing with mouse function to history graphing
#         - JX - Fix order of graph code to ensure no overlap
#         - JX - fix graphing error where if there is no change, line would not be gra
# -May 23 - JM - Added Log In to processing. Still has bugs
#         - JM - Fixed Button. Found new Object error
# -May 26 - JX - Add slider for graphRange 
#		  - JX - complete graphNewHistory Button
# -May 27 - JM - Added exceptions for logIn and Register. Text fields work better
#         - JM - Fixed text fields and added exceptions
# -May 28 - JX - complete many GUI things
# 		  - JX - complete pullPopular and graphPopular and button bar that changes which one is being graphed
# -May 30 - JX - complete buttons that toggle between history graphing and live graphing
# 		  - JX - Add toggle for mouse tracking
# 		  - JX - fix hide and show of new graphPastRange controllers
# 		  - JX - improved color of GUI
# 		  - JX - add titles with stock name to live graphs
# 		  - JX - make many improvements to graphLive with input
# 		  - JX - add GUI and method to change live pulled stock
# 		  - JX - applied most popular bar to work with graph history
# 		  - JX - complete hide and show of GUI for graph past and history graph
#
#
#
#
#
#