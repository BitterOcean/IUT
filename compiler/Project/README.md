# Compiler Project
![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)
![Builed](https://img.shields.io/azure-devops/build/totodem/8cf3ec0e-d0c2-4fcd-8206-ad204f254a96/2?style=flat)
![License](https://img.shields.io/packagist/l/doctrine/orm)
![language](https://img.shields.io/badge/language-Bison-orange)  

Authors : Maryam Saeedmehr , Sajede Nicknadaf  

Language : Bison/Flex


## **Table of contents**
- [DETAILS](#DETAILS)
- [FIRST PHASE](#FIRST-PHASE)
- [SECOND PHASE](#SECOND-PHASE)
- [THIRD PHASE](#THIRD-PHASE)
- [DOWNLOAD](#DOWNLOAD)
- [SUPPOERT](#SUPPOERT)
- [LICENSE](#LICENSE)


## **DETAILS**  

In this project, we are going to define a compiler for our simple language
This compiler is implemented using Flex and Bison tools
The target compiler should be able to receive a file containing the target code and generate an output code in MIPS language,
according to the semantic action and other necessary concepts that you have read in the compiler lesson.


## **FIRST PHASE**  

A program will be given to your code in the language that will be described. If that program has complied with 
the lexical rules of the programming language, you must print the tokens of the program at the output, 
otherwise a proper error must be generated without producing any token.  

For more details : [firstPart.pdf](https://github.com/BitterOcean/IUT/files/4668399/firstPart.pdf)  

Testcases : <a href="https://github.com/BitterOcean/IUT/tree/master/compiler/Project/FirstPhase/TestCase">/TestCase</a>

### **Enjoy It !**

![FirstPhase](https://user-images.githubusercontent.com/60509979/89719581-174bcf00-d9df-11ea-8a2c-f8b9e5f350d1.gif)



## **SECOND PHASE**  

You must write a program using bison, yacc and upload it to the LMS.A program is given to you in the language to be described, and if that program follows the lexical and syntactic rules of the language, you create a tree according to the grammar of the language and print it preorder But in case of any violation of the language rules, you should mention the line and column number as well as the name of the unauthorized token and show an appropriate error message.

For more details : [secondPart.pdf](https://github.com/BitterOcean/IUT/files/5046124/secondPart.pdf)

Testcases : <a href="https://github.com/BitterOcean/IUT/tree/master/compiler/Project/SecondPhase/TestCase">/TestCase</a>

### **Enjoy It !**

![SecondPhase](https://user-images.githubusercontent.com/60509979/89718951-b620fd00-d9d8-11ea-98d5-8042e0127e1a.gif)



## **THIRD PHASE**  

You must write a program using bison, yacc and upload it to the LMS. Your program acts like a real compiler in that after receiving the input file, it generates a file in MIPS language so that it can be run in SPIM environment. If some macros are needed to run in SPIM environment, it is better that the compiler can generate it itself and if there is any error in the input file, it will exit without generating the output file and displaying the relevant error.

For more details : [thirdPart.pdf](https://github.com/BitterOcean/IUT/files/5046126/thirdPart.pdf)  

Testcases : <a href="https://github.com/BitterOcean/IUT/tree/master/compiler/Project/ThirdPhase/TestCase">/TestCase</a>

### **Enjoy It !**

![ThirdPhase](https://user-images.githubusercontent.com/60509979/89718969-d81a7f80-d9d8-11ea-955e-d904ea6535bb.gif)



## **DOWNLOAD**  
<p>
  &nbsp;&nbsp;:small_orange_diamond: <b>First phase :</b></br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:arrow_right: <a href="https://github.com/BitterOcean/IUT/blob/master/compiler/Project/FirstPhase/LexAnalyzer.l">LexAnalyzer.l</a></br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:arrow_right: <a href="https://github.com/BitterOcean/IUT/blob/master/compiler/Project/FirstPhase/Lex.sh">Lex.sh</a></br>
</P>
<p>
  &nbsp;&nbsp;:small_orange_diamond: <b>Second phase :</b></br>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:arrow_right: <a href="https://github.com/BitterOcean/IUT/blob/master/compiler/Project/SecondPhase/Compiler.l">Compiler.l</a></br>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:arrow_right: <a href="https://github.com/BitterOcean/IUT/blob/master/compiler/Project/SecondPhase/Compiler.y">Compiler.y</a></br>
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:arrow_right: <a href="https://github.com/BitterOcean/IUT/blob/master/compiler/Project/SecondPhase/Compiler.sh">Compiler.sh</a></br>
</P>
<p>
  &nbsp;&nbsp;:small_orange_diamond: <b>Third phase :</b></br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:arrow_right: <a href="https://github.com/BitterOcean/IUT/blob/master/compiler/Project/ThirdPhase/Compiler.l">Compiler.l</a></br>  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:arrow_right: <a href="https://github.com/BitterOcean/IUT/blob/master/compiler/Project/ThirdPhase/Compiler.y">Compiler.y</a></br>  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:arrow_right: <a href="https://github.com/BitterOcean/IUT/blob/master/compiler/Project/ThirdPhase/Compiler.sh">Compiler.sh</a></br>
</P>

## **SUPPOERT**

Reach out to us at one of the following places!

- Telegram at :
  - <a href="https://t.me/BitterOcean" target="_blank">@BitterOcean</a>
  - <a href="https://t.me/Sajede_nick" target="_blank">@Sajede_nick</a>
- Gmail at :
  - <a href="mailto:maryamsaeedmehr@gmail.com" target="_blank">maryamsaeedmehr@gmail.com</a>
  - <a href="mailto:sajede.nicknadaf78@gmail.com" target="_blank">sajede.nicknadaf78@gmail.com</a>


## **LICENSE**

[![License](https://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

