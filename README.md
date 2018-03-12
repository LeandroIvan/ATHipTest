# ATHipTest

Solution that takes a chat message string and returns a JSON string containing information about its contents. 

Special content to look for includes:

1. @mentions - A way to mention a user. Always starts with an '@' and ends when hitting a non-alphanumeric character.  For example, "Hey @andy, are you free for lunch tomorrow?".

2. Emoticons - For this exercise, you only need to consider 'custom' emoticons which are alphanumeric strings, no longer than 15 characters, contained in parentheses. You can assume that anything matching this format is an emoticon. (https://www.hipchat.com/emoticons)

3. Links - Any URLs contained in the message, along with the page's title.


## Getting Started

Open the project, build and run.  
No 3rd party library in use.  

### Prerequisites

XCode 9.2

## Running the tests

To make testing the take-home challenge easier I added a unitTest file that takes randomly a string and print the result.   
To make it even easier I implementated a basic UI with a textField that takes in input a string and it shows in a textView the result.

## Built With

* XCode 9.2 in Swift 4
* Support iOS 11+

## Authors

* Mady with ❤️ by **Leandro Ivan Candiotto** 
