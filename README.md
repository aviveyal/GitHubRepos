# GitHubRepos

////////////// Architecture //////////////

MVC design -

Navigator Controller

3 ViewControllers-
* MainVC - main page of the application with buttons for each list
* ReposVC- showing the lists , same tableview for all 4 lists (data loaded on seguge)
*RepoDetailVC - when clicking on cell on the list load this VC and show more detail of the repository

5 Models-
*Repo - object including all repository data
*Repo+sql (extension of Repo) - all functions to cache and manage data on local storage
*GitHubApi - functions that use GitHubAPI
*AvatarDownload - manage picture downloading of repositories owner avatar 
*ModelSql - setup db file on local storage

////////////// Comments //////////////

*for the repository language I display a logo picture of the programmed language, I downloaded logos of main programming language, but might missing some logos

*Favorite list is cached according to the requirments in the assignment - the repositories on this list are never searched on the internet , that's mean the data on the list shown as was on the time is cached.
In case avatar was changed , more forks occured , stars count increase...it will not affect on the list .

the solution for now - if some repository exist on the favorite list and you add it again to favorite list it will ovveride the last one and will save the new data.
for production it will be better check on the internet for new data for each repository on that list

*The app include all of the requirment in the assignment:
Displays the most trending repositories on GitHub,user able to choose which timeframe,sorted by the number of stars ,the list allow infinite scrolling,favorites repositories are saved locally and are available even without an internet connection,avatar images cached, UI suitable to also to ipad , search bar for each list ,clear user experience when there is no internet connection .
