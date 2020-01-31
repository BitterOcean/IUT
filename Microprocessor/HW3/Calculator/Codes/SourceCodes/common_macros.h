/*
 * common_macros.h
 *
 * Created: 12/22/2019 07:44:00 PM
 *  Author: Maryam Saeedmehr
 */ 

/*PULL_UP_BIT is added by Yahia Farghaly 15 sep 2015*/
#ifndef COMMON_MACROS
#define COMMON_MACROS

/* Set a certain bit in any register */
#define SET_BIT(REG,BIT) (REG|=(1<<BIT))

/* Clear a certain bit in any register */
#define CLEAR_BIT(REG,BIT) (REG&=(~(1<<BIT)))

/* Toggle a certain bit in any register */
#define TOGGLE_BIT(REG,BIT) (REG^=(1<<BIT))

/* Rotate right the register value with specific number of rotates */
#define ROR(REG,num) ( REG= (REG>>num) | (REG<<(sizeof(SREG)-num)) )

/* Rotate left the register value with specific number of rotates */
#define ROL(REG,num) ( REG= (REG<<num) | (REG>>(sizeof(SREG)-num)) )

/* Check if a specific bit is set in any register and return true if yes */
#define BIT_IS_SET(REG,BIT) ( REG & (1<<BIT) )

/* Check if a specific bit is cleared in any register and return true if yes */
#define BIT_IS_CLEAR(REG,BIT) ( !(REG & (1<<BIT)) )

/*Configure a pin to input and in pull up configuration,as AVR feature*/
#define PULL_UP_BIT(DDR_REG,PORT_REG,BIT) {CLEAR_BIT(DDR_REG,BIT);SET_BIT(PORT_REG,BIT);}
			

#endif
