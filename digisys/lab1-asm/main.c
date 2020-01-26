// lab1-asm/main.c
// Copyright (c) J. M. Spivey 2018-19

#include "hardware.h"
#include "lib.h"
#include <stdarg.h>

static int txinit;              // UART ready to transmit first char

/* serial_init -- set up UART connection to host */
void serial_init(void) {
    GPIO_DIRSET = BIT(USB_TX);
    GPIO_DIRCLR = BIT(USB_RX);
    SET_FIELD(GPIO_PINCNF[USB_TX], GPIO_PINCNF_PULL, GPIO_Pullup);
    SET_FIELD(GPIO_PINCNF[USB_RX], GPIO_PINCNF_PULL, GPIO_Pullup);

    UART_BAUDRATE = UART_BAUD_9600;     // 9600 baud
    UART_CONFIG = 0;                    // format 8N1
    UART_PSELTXD = USB_TX;               // choose pins
    UART_PSELRXD = USB_RX;
    UART_ENABLE = UART_Enabled;
    UART_STARTTX = 1;
    UART_STARTRX = 1;
    UART_RXDRDY = 0;
    txinit = 1;
}

/* serial_getc -- wait for input character and return it */
int serial_getc(void) {
    while (! UART_RXDRDY) { }
    char ch = UART_RXD;
    UART_RXDRDY = 0;
    return ch;
}

/* serial_putc -- send output character */
void serial_putc(char ch) {
    if (! txinit) {
        while (! UART_TXDRDY) { }
    }
    txinit = 0;
    UART_TXDRDY = 0;
    UART_TXD = ch;
}

/* serial_puts -- send string character by character */
void serial_puts(char *s) {
    while (*s != '\0')
        serial_putc(*s++);
}

void serial_printf(char *fmt, ...) {
    va_list va;
    va_start(va, fmt);
    do_print(serial_putc, fmt, va);
    va_end(va);
}

#define BUF 80
char line_buf[BUF];

/* accept -- input a line of text into line_buf with line editing */
void accept(char *prompt) {
    char *p = line_buf;

    serial_puts(prompt);

    while (1) {
        char x = serial_getc();

        switch (x) {
        case '\b':
        case 0177:
            if (p > line_buf) {
                p--;
                serial_puts("\b \b");
            }
            break;

        case '\r':
            *p = '\0';
            serial_puts("\r\n");
            return;

        default:
            /* Ignore other non-printing characters */
            if (x >= 040 && x < 0177 && p < &line_buf[BUF]) {
                *p++ = x;
                serial_putc(x);
            }
        }
    }
}

int getnum(void) {
    accept("Gimme a number: ");
    if (line_buf[0] == '0' && (line_buf[1] == 'x' || line_buf[1] == 'X'))
        return xtou(&line_buf[2]);
    else
        return atoi(line_buf);
}

#define ROW_MASK 0x0000e000
#define COL_MASK 0x00001ff0

#define ROW0 13
#define COL0 4

#define R 1
#define C 2

#define LIGHT (1<<(ROW0+R)) | (~(1<<(COL0+C)) & COL_MASK)

#define FUDGE 20 // cycles of overhead

extern int foo(int a, int b);

/* init -- main program */
void init(void) {
    unsigned time;

    serial_init();
    serial_printf("\r\nHello micro:world!\r\n\n");
    GPIO_DIRSET = ROW_MASK | COL_MASK;

    // Set up TIMER0 in 32 bit mode
    TIMER0_MODE = TIMER_Mode_Timer;
    TIMER0_BITMODE = TIMER_32Bit;
    TIMER0_PRESCALER = 0; // Count at 16MHz
    TIMER0_START = 1;

    while (1) {
        int a, b, c;
        a = getnum();
        b = getnum();

        TIMER0_CLEAR = 1;
        GPIO_OUT = LIGHT;
        c = foo(a, b);
        GPIO_OUT = 0;
        TIMER0_CAPTURE[0] = 1;

        serial_printf("foo(%d, %d) = %d\r\n", a, b, c);
        serial_printf("foo(%x, %x) = %x\r\n", a, b, c);

        time = TIMER0_CC[0] - FUDGE;
        serial_printf("%d cycle%s, %d microsec\r\n\n",
                      time, (time == 1 ? "" : "s"), (time+8)/16);
    }
}
