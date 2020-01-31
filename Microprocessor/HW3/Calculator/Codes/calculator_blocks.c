/*
 * calculator_blocks.c
 *
 * Created: 12/22/2019 07:44:00 PM
 *  Author: Maryam Saeedmehr
 */ 
 
#include "calculator_blocks.h"

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

sint64 Result=0;
sint64 Operands[MaxNumberOfOperands];
uint8 Operations[MaxNumberOfOperations];
sint8 Digits[MaxNumberOfDigits];

uint8 OperandsCounter=0; /*How many operands entered*/
uint8 OperationsCounter=0; /*how many operations*/
uint8 DigitsCounter=0;/*how many digits is entered including math symbols*/

bool FirstNumberSign=false; /*if Digits[0]=negative value which means that operand[0] is negative*/
bool SignNumberFlagToConvertInt64=false; /*Communication flag between the ConvertInt64 and Analyze and
										To make a note that the number which ConvertInt64 will convert is negative*/
bool OtherNumberSign=false;/*if any operand is negative and not operand[0],the variable is set to true */

void ResetData()
{
	uint8 index=0;
	for(index=0;index<MaxNumberOfDigits;index++)
			Digits[index]=0;
	for(index=0;index<MaxNumberOfOperands;index++)
			Operands[index]=0;
	for(index=0;index<MaxNumberOfOperations;index++)
			Operations[index]=0;
	OperandsCounter=0;
	OperationsCounter=0;
	DigitsCounter=0;
	Result=0;
}		

void SynchronousDisplay(uint8 data)
{
	if(data >=0 && data<=9) LCD_Signed_Int64_ToString(data);
	else LCD_displayCharacter(data);
}

void GetData()
{
	uint8 temp=0;/*To get into the loop for the first time and hold the value of the key pressed*/

	while(temp != EqualKey)
	{
		temp=KeyPad_getPressedKey();
		if(temp==EnterKey) 
		{
			Flag=Reset; /*to clean what's entered before this condition,when returning into the main
			it will cleared as non of the loops in main satisfy the flag*/
			return;
		}
		Digits[DigitsCounter]=temp; /*storing any thing the user input*/
		SynchronousDisplay(Digits[DigitsCounter]);
		DigitsCounter++;
		_delay_ms(300);	/*delay time between each press */
	}
	
	Flag=AnalyzePoint; /*to next step when pressing the equal key*/
	
}


sint64 ConvertToInt64(uint8 * ptr,uint8 len)
{
	uint8 index;
	sint64 value=0;/*the value which will be returned*/
	bool Negative =false;/*If the number is negative*/

	if(SignNumberFlagToConvertInt64) { /*If negative*/
		Negative=true;
		SignNumberFlagToConvertInt64=false;/*Remember it's a critical section,so should be disabled again*/
	}		
	for(index=0;index<len;index++)
	{
		value+=ptr[len-index-1]*powerOf(10,index);/*Math basics*/
		/*PowerOf is a function included into keypad.h*/
	}
	
	if(Negative) value= -value ; /*As it should be*/
	return value;
}

void DisplayResult()
{
	LCD_goToRowColumn(1,0);
	LCD_Signed_Int64_ToString(Result);
	while(KeyPad_getPressedKey() != EnterKey){}
		Flag=StartPoint;
}
void ThrowException(uint8 *msg)
{
	LCD_goToRowColumn(1,0);
	LCD_displayString(msg);
	while(KeyPad_getPressedKey() != EnterKey){} /*Don't get from the exception until pressing enter key*/
		Flag=ErrorPoint;
}

void Analyze()
{
	sint8 TempArr[MaxNumberOfDigits]={0};
	uint8 TempIndex=0;
	uint8 index=0;
	
	
	if(IsOperation(Digits[0]) && Digits[0]!= '-'){ /*if the input is  *5 for example */
		 ThrowException("Invalid input");
		 Flag=StartPoint;
		 return;
			}		
			
	/*Checking on if the first number is signed*/
	if(Digits[0]== '-' && !IsOperation(Digits[1]))
	{
			FirstNumberSign =true; /*To register the number in TempArr without conflict with the second condition*/
			SignNumberFlagToConvertInt64=true;/*To make a note that the number which ConvertInt64 will convert is negative*/
			index++; /* To assign TempArr[0]= Digits[1] for the first time only and in signed case [in the first condition below]*/
	}		
	
		while(DigitsCounter != 0)
		{
			/*this loop is scan the Digits array and once it found and operation symbol it will convert the number which 
			previous it then continue searching*/

			if(((Digits[index]>=0) && (Digits[index]<=9)) || FirstNumberSign||OtherNumberSign) 
			{
				TempArr[TempIndex]=Digits[index];
				TempIndex++;
				FirstNumberSign =false;
				OtherNumberSign =false;
			}				
			else if(((IsOperation(Digits[index]))||(Digits[index]== EqualKey)))/* 2*8*3= */
			{	/*The equality sign help me to calculate the last operand value*/
				Operations[OperationsCounter]=Digits[index];
				OperationsCounter++;		
				Operands[OperandsCounter]=ConvertToInt64(TempArr,TempIndex);
				OperandsCounter++;
				TempIndex=0;
					if(Digits[index+1] == '-' && index >0) /*If the other operand is signed (2nd operand ...)*/
					{
							OtherNumberSign=true;
							SignNumberFlagToConvertInt64=true;
							index++;/*To Not include the sign in the TempArr*/
							
					}else if(IsOperation(Digits[index+1])) /*if two symbols after each other ++ or *% */
					{
						ThrowException("Invalid Syntax");
						Flag =ErrorPoint;
						return;
					}
						
			}
			else if(Digits[index]==EnterKey){
				/*Should be an unreachable code ,but in case of any thing*/
				Flag=StartPoint;
				return;
			}
			
			index++;
			DigitsCounter--;

		}

		Flag=CalculatePoint;/*go to the next stage*/
}



void Calculate()
{
	uint8 piority=false;
	
	if(OperationsCounter>2){/* > 2 As equal sign included in it*/
		if(Operations[1] != Operations[0]) piority=true;		
	}		
	
	
	if(OperandsCounter == 1)
	{
		
		Result=Operands[0];
		Flag=DisplayPoint;
		return;
	}

if(piority==false){	
	if((OperandsCounter>1))
	{
		uint8 index=0;
		switch(Operations[0])
		{
			case '+':{
						Result=0;
						for(index=0;index<OperandsCounter;index++)
								Result+=Operands[index];
						break;
					}
					
			case '*':{
				Result=1;/*As it's initially to -1*/
				for(index=0;index<OperandsCounter;index++)
								Result*=Operands[index];
				break;
					}
			case '-':{
				Result=Operands[0];	/*As i use -= and Result is initially to -1,so it will give a wrong answer*/
				for(index=1;index<OperandsCounter;index++)
								Result-=Operands[index];
				break;
					}	
			case '%':{
				Result=Operands[0]; /*As above*/
				for(index=1;index<OperandsCounter;index++)
						Result/=Operands[index];
				break;
					}
					
			default:{
				ThrowException("Calculation Error");
				Flag=StartPoint;
				break;
				}					
		}
		
		Flag=DisplayPoint;
		return;
	}
		}	
else{	
	if((OperandsCounter>1))/*Honstly it's for 3 operands only and two different  operation*/
	{
		/*yeah this technique is very bad ,if you made a generic way or fast one that could be extended
		to more different operands,please content me*/
		uint8 code=0;
		if(Operations[0]=='*' && Operations[1] == '+') code=1;
		else if(Operations[0]=='+' && Operations[1] == '*') code=2;
		else if(Operations[0]=='+' && Operations[1] == '-') code=3;
		else if(Operations[0]=='-' && Operations[1] == '+') code=4;
		else if(Operations[0]=='*' && Operations[1] == '%') code=5;
		else if(Operations[0]=='%' && Operations[1] == '*') code=6;
		else if(Operations[0]=='%' && Operations[1] == '+') code=7;
		else if(Operations[0]=='+' && Operations[1] == '%') code=8;
		else if(Operations[0]=='*' && Operations[1] == '-') code=9;
		else if(Operations[0]=='-' && Operations[1] == '*') code=10;
		else if(Operations[0]=='%' && Operations[1] == '-') code=11;
		else if(Operations[0]=='-' && Operations[1] == '%') code=12;
		else code =0; 
		
		switch(code){
			case 1: Result=(Operands[0]*Operands[1])+Operands[2]; break;
			case 2: Result=Operands[0]+(Operands[1]*Operands[2]); break;
			case 3: Result=Operands[0]+(Operands[1]-Operands[2]); break;
			case 4: Result=(Operands[0]-Operands[1])+Operands[2]; break;
			case 5: Result=Operands[0]*(Operands[1]/Operands[2]); break;
			case 6: Result=(Operands[0]/Operands[1])*Operands[2]; break;
			case 7: Result=Operands[0]/Operands[1]+Operands[2]; break;
			case 8: Result=Operands[0]/Operands[1]+Operands[2]; break;
			case 9: Result= Operands[0]*Operands[1]-Operands[2]; break;
			case 10: Result=Operands[0]-Operands[1]*Operands[2]; break;
			case 11: Result= Operands[0]/Operands[1]-Operands[2];break;
			case 12: Result= Operands[0]-Operands[1]/Operands[2];break;
					
			default:
				{
					ThrowException("PiorityError");
					Flag=StartPoint;
					break;
				}
		}	
		Flag=DisplayPoint;
		return;
	}
		}
		
			
	Flag=DisplayPoint;
	return;
}