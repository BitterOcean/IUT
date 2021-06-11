 #include "test6_lib.h"

uint16_t adc_data[LAST_ADC_INPUT-FIRST_ADC_INPUT+1];  
uint16_t adc_data_copy[LAST_ADC_INPUT-FIRST_ADC_INPUT+1];

// ADC interrupt service routine
// with auto input scanning
interrupt [ADC_INT] void adc_isr(void){
  static unsigned char input_index=0; 
  // Read the AD conversion result
  adc_data[input_index]=ADCW;
  // Select next ADC input
  if (++input_index > (LAST_ADC_INPUT-FIRST_ADC_INPUT)) {
    input_index=0;    
  }
  ADMUX=(FIRST_ADC_INPUT | ADC_VREF_TYPE)+input_index;
  // Delay needed for the stabilization of the ADC input voltage
  delay_us(10);
  // Start the AD conversion
  ADCSRA|=(1<<ADSC); 
}

// Read the AD conversion result
unsigned int read_adc(unsigned char adc_input){
  ADMUX=adc_input | ADC_VREF_TYPE;
  // Delay needed for the stabilization of the ADC input voltage
  delay_us(10);
  // Start the AD conversion
  ADCSRA|=(1<<ADSC);
  // Wait for the AD conversion to complete
  while ((ADCSRA & (1<<ADIF))==0);
  ADCSRA|=(1<<ADIF);
  return ADCW;
}


void Q1_adc_init(){
  // ADC initialization
  // ADC Clock frequency: 1000.000 kHz
  // ADC Voltage Reference: AREF pin
  // ADC Auto Trigger Source: ADC Stopped
  ADMUX=ADC_VREF_TYPE;
  ADCSRA=(1<<ADEN) | (0<<ADSC) | (1<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (1<<ADPS1) | (1<<ADPS0);
  SFIOR=(0<<ADTS2) | (0<<ADTS1) | (0<<ADTS0);
}


void Q2_adc_init(){
  // ADC initialization
  // ADC Clock frequency: 1000.000 kHz
  // ADC Voltage Reference: AVCC pin
  // ADC Auto Trigger Source: Free Running
  ADMUX=FIRST_ADC_INPUT | ADC_VREF_TYPE;
  ADCSRA=(1<<ADEN) | (1<<ADSC) | (1<<ADATE) | (0<<ADIF) | (1<<ADIE) | (0<<ADPS2) | (1<<ADPS1) | (1<<ADPS0);
  SFIOR=(0<<ADTS2) | (0<<ADTS1) | (0<<ADTS0);
}