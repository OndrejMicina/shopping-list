<!-- ABOUT THE PROJECT -->
# Shared shopping list

### Built With

Used technologies

* [Flutter](https://flutter.dev/) - front end
* [.Net framework](https://dotnet.microsoft.com/en-us/) - back end
* [Hive](https://pub.dev/packages/hive) - local storage
* [Firebase](firebase.google.com) - database

<!-- USAGE EXAMPLES -->
## SCENARIO

The main idea of this project is to manage one shopping list within a group of users. 
Users well be able to use application without registering. 
~~Shopping list should be awailable in local memory for offline use ~~
First of all, user will create shopping list, after this, he will be able to edit list such as adding / delleting /or marking as bought. 
If he want to share, he will send the link or code to join the list. 

After this stage, the secon stage is to edit app for industry use as inventory helper. Each of workers will add their request to supply center to deliver requested items or plan the order. *

As a user i will be able to:

* Use application without registration
* Create shopping list
* Join shopping list
* Add items to the shoping list
* Delete items from shoping list
* Buy/complete shopping list
* ~~Overview list when offline~~
* See people connected to shoping list
* Use easy to interact interface 
* Share my shopping list using link or code

### PLAN

* Prepare coding environment
* Setup required packages
* 
* Build initial flutter app
*   
* Create simple list of goods in flutter CRUD
* Create local databse
* Create simple local API and connect to database 
* Try simple requests from database to obtain goods in list
* Edit app to fetch data from API
* Create flutter menu for conecting to group
* Implement groups 
* Test creating list in groups

| USER  | LIST|CODE|

## RESULTS SUMMARY

Pre programovanie bol zvoleny jazyk flutter, v ktorom som robil prvý krát. Po naučení sa základov som začal konštruovať jednoduchý list položiek ktorý som neskôr upravil na model Shopping listu. Po sprovoznení listu som najprv zvolil SQLite pre lokálne ukladanie do zariadenia. Plán bol taký že používateľ si vytvorí list lokálne a  neskor ked sa rozhodne ho zdielať bude odoslaný do databáze. SQlite mi prišla moc zložitá na tak jednoduchý problém a preto som sa obzrel za novou technologiou- hive. Naučil som sa základné ovládanie a sprovoznil lokálne ukladanie. Na generovanie ID som použil knižnicu NANOID ktorá generuje náhodné ID v požadovanom rozsahu. Pomocou tohto vygenerovanáho ID umožnujem používateľovi zdielanie svojeho listu. Po stlačení share sa list odlošle do databázy firebase od google a pomocou ID si ju vie používateľ stiahnu%t do svojho zariadenia.

<!-- ROADMAP  -->
## Roadmap
**
<!-- 
- [x] Add Changelog
- [ ] Multi-language Support
    - [ ] Chinese
    - [ ] Spanish

    -->
    
## 
*Will be changed later
