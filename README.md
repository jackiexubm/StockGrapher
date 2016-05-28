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