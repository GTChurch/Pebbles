# Giving Reconciliation Page
The giving reconciliation page is made up of three blocks, one of which is optional. The goal of this page/report was two-fold. 

* To provide a solution to as bug which rendered the batch page with no account names 
* To create a page which organized our batches in excel in a way that our Financial team preferred to the standard batch page.

Follow the instructions below to set up the page in your rock instance, and please submit an Issue if you find any errors with this report or a better way to set it up!

## Page Setup
The first step in creating this report page is to create a new page in your Rock Backend Site. We placed this page under a new finance page called "Advanced Reports" along with some other reports that we created for our financial team. Our advanced reports page then has a "Page Menu" block on it which lists all the reports below itself. 

For your giving reconciliation page, you will want to create a page that uses the "Left Sidebar" layout. Name, the page whatever you would like and maybe add a route in there for easy access. 

Next on your Giving Reconciliation Page, you will need to add an HTML block and a Dynamic data block to the sidebar of the page. These will become the report parameters pane, and the Total Batch count pane respectively, the latter of which is optional but our finance team wanted it so maybe yours will too. The main area of the page will need another Dynamic Data block which will become the actual list of Batches, accounts and income. 

Finally, on each of the Dynamic Data blocks on this page you will need to add the following in the "Parameters" field... 
`@StartDate=,@EndDate=,@CurrencyType=,@TransactionType=`. This will enable the block to get SQL Query parameters from the HTML block that controls the report start/enddate etc. The dynamic data block in the main section will also need `~/page/163?batchId={BatchId}` added, which will make each row clickable and take the user from the report page to the batch details page. 

## SQL Function setup
In order to allow the query string parameters to be used in the SQL query properly, the strings after each argument must be converted into the proper formats. In this case it's really only the CurrencyTypeId and TransactionTypeId fields that must be converted from strings to tables. We have a function stored in our database that allows us to do this easily and you will need to install it quickly to use the report page. 

To add this function to your database, simply copy the contents of `spListToTable.sql` from github into the `SQL Command` page in your Rock instance. The `SQL Command` page should be located under `Admin Tools > Power Tools > SQL Command`. 

Navigate to that page and select "No" under the `Selection Query` Option. Then Copy and paste the `spListToTable.sql` file contents and the function should be created and be ready to use by the other blocks on our page. If you are SQL proficient you will see that it's a super simple function and may find it useful in other reports that you wish to create as well!

## Setting up the Giving Reconciliation Page Blocks
The rest of the report setup should be pretty simple.. 
* Paste the contents of `MainQuery.sql` into the SQL box of the Dynamic Data block in the main section of the page.
* Paste the contents of `ReportParameters.lava` into the HTML block on the left side of the page
* Paste the `TotalBatchCount.sql` and `TotalBatchCount.lava` into the Query and Lava Template sections of the Left Sidebar Dynamic Data block on the left.
