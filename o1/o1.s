.thumb
.syntax unified

.include "gpio_constants.s"     // Register-adresser og konstanter for GPIO

.text
	.global Start

	// PB0 - Port B - Pin 9
	// LED0 - Port E - Pin 2
	// r0-r12 for General purpose

Start:
	// DOUTSET = Set data output
	// DOUTCLR = Clear data output
	//
	// (PORT_SIZE * LED_PORT) = totale antallet portregistre
	ldr r0, =GPIO_BASE + (PORT_SIZE * LED_PORT) // Regner ut register-addr. Henter minnelokasjon og legger i r0
	ldr r1, =GPIO_PORT_DOUTCLR // Henter minnelokasjon 'GPIO_PORT_DOUTCLR' og legger i r1
	add r1, r0, r1 // r0 + r1 i r1
	ldr r2, =GPIO_PORT_DOUTSET // Henter minnelokasjon 'GPIO_PORT_DOUTSET' og legger i r1
	add r0, r0, r2 // r0 + r2 i r0

	// DIN = Data input
	ldr r2, =GPIO_BASE + (PORT_SIZE * BUTTON_PORT) + GPIO_PORT_DIN
	// Regner ut reg-addr.
	// ldr = Henter minnelokasjon og legger i r2

	ldr r3, =1 << LED_PIN
	ldr r4, =1 << BUTTON_PIN

Loop:
	ldr r6, [r2] // Henter innhold i minnelokasjon r2 og legger i r6
	and r6, r6, r4 // Gjør et bitwise AND på r6 og ’r4’, lagre i r6
	cmp r6, r4 // compare r6 og r4
	beq TurnOn // Branch if EQual)
TurnOff:
	str r3, [r0] // Lagre r3 på minnelokasjon r0.
	B Loop // branch to loop (endless loop!)
TurnOn:
	str r3, [r1] // Lagre r3 på minnelokasjon r1.
	B Loop // branch to loop (endless loop!)


NOP // Behold denne pÃ¥ bunnen av fila

