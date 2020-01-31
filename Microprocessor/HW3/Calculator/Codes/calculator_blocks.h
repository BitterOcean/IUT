/*
 * calculator_blocks.h
 *
 * Created: 12/22/2019 07:44:00 PM
 *  Author: Maryam Saeedmehr
 */ 


#ifndef CALCULATOR_BLOCKS_H_
#define CALCULATOR_BLOCKS_H_

/*
*  typedef unsigned char uint8;
*  typedef signed char sint8;
*  typedef unsigned short uint16;
*  typedef signed short sint16;
*  typedef unsigned long uint32;
*  typedef signed long sint32;
*  typedef unsigned long long uint64;
*  typedef signed long long sint64;
*  typedef unsigned char bool;
*/

#include "SourceCodes/std_types.h"
enum boolenexper {true=1,false=0};
#include "SourceCodes/micro_config.h"
#include "SourceCodes/common_macros.h"
#include "SourceCodes/lcd.h"
#include "SourceCodes/keypad.h"
#include "math.h"

/*The limits on the inputs which you are set*/
#define MaxNumberOfDigits 16
#define MaxNumberOfOperands 12
#define MaxNumberOfOperations MaxNumberOfOperands-1

#define IsOperation(n) ((n=='*')||(n=='+')||(n=='-')||(n=='%'))

enum StageFlag{Reset,StartPoint,AnalyzePoint,CalculatePoint,DisplayPoint,ErrorPoint};
enum keys{EnterKey=13,EqualKey= '=' ,Numberkey,OperationKey};
enum Errors{ExcessedMaxNumberOfdigits,InvalidInput,OutofRange};	

extern uint8 Flag;

extern uint32 powerOf(uint8 x,uint8 y); /*Used With ConvertToInt64()*/
void ResetData(); /*To get all the globel variables in .c file set to zero when doing new operation*/
void GetData(); /*Get the data from the keypad until pressing "equal key"*/
void SynchronousDisplay(uint8 data); /*To display what you type in the LCD while storing the inputs*/
void Analyze(); /*To get the operands seperated from the operation to be able to know the operations which i am going to use*/
sint64 ConvertToInt64(uint8 * ptr,uint8 len); /*Converting series of seperate digits into a single number (1,1,5)=>115 */
void ThrowException(uint8 *msg);/*Throw error message on LCD when error found*/
void Calculate(); /*Do the math*/
void DisplayResult();
#endif /* CALCULATOR_BLOCKS_H_ */