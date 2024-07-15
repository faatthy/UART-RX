### Introduction  

+ There are many serial communication protocol as I2C, UART and SPI. 
+ A Universal Asynchronous Receiver/Transmitter (UART) is a block of 
circuitry responsible for implementing serial communication. 
+ UART is Full Duplex protocol (data transmission in both directions 
simultaneously)

![Screenshot 2024-06-19 093559](https://github.com/user-attachments/assets/c52c1c1d-d478-4e6c-b947-75d0aacbe236)

- Transmitting UART converts parallel data from the master device (eg. 
CPU) into serial form and transmit in serial to receiving UART.   
- Receiving UART will then convert the serial data back into parallel data 
for the receiving device.

![image](https://github.com/user-attachments/assets/f66d59f6-12db-41c8-ad04-e38e94213fa3)

## Block Interface     

![image](https://github.com/user-attachments/assets/60507853-57a5-45e7-a9c8-c81ac3d34f37)

## Signals Description    

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <table>
        <tr>
            <th>Port</th>
            <th>Width</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>CLK</td>
            <td>1</td>
            <td>UART RX Clock Signal</td>
        </tr>
        <tr>
            <td>RST</td>
            <td>1</td>
            <td>Synchronized reset signal</td>
        </tr>
        <tr>
            <td>PAR_TYP</td>
            <td>1</td>
            <td>Parity Type</td>
        </tr>
        <tr>
            <td>PAR_EN</td>
            <td>1</td>
            <td>Parity Enable</td>
        </tr>
        <tr>
            <td>Prescale</td>
            <td>5</td>
            <td>Oversampling Prescale</td>
        </tr>
        <tr>
            <td>RX_IN</td>
            <td>1</td>
            <td>Serial Data IN</td>
        </tr>
        <tr>
            <td>P_DATA</td>
            <td>8</td>
            <td>Frame Data Byte</td>
        </tr>
        <tr>
            <td>Data_valid</td>
            <td>1</td>
            <td>Data Byte Valid signal</td>
        </tr>
    </table>
</body>
</html>

## Specifications

* UART RX receive a UART frame on RX_IN. 
* UART_RX support oversampling by 8, 16, 32  
* RX_IN is high in the IDLE case (No transmission). 
* PAR_ERR signal is high when the calculated parity bit not equal the received frame parity bit as this mean that the frame is corrupted. 
* STP_ERR signal is high when the received stop bit not equal 1 as this mean that the frame is corrupted. 
* DATA is extracted from the received frame and then sent through P_DATA bus associated with DATA_VLD signal only after 
checking that the frame is received correctly and not corrupted
(PAR_ERR = 0 && STP_ERR = 0). 
* UART_RX can accept consequent frames without any gap. 
* Registers are cleared using asynchronous active low reset 
* PAR_EN (Configuration)     
0: To disable frame parity bit       
1: To enable frame parity bit 
* PAR_TYP (Configuration)        
0: Even parity bit  
1: Odd parity bit 

##  Expected ReceivedFrames  

1.  Data Frame (in case of Parity is enabled & Parity Type is even)
 – One start bit (1'b0)
– Data (LSB first or MSB, 8 bits)
– Even Parity bit
– One stop bit

![image](https://github.com/user-attachments/assets/caf32e16-385b-4f68-ab1f-7a39a3f4c064)

## Frames Waveforms

![image](https://github.com/user-attachments/assets/ee587f32-1e06-4098-b894-8ca8128590dc)

## Oversampling 

Oversampling is a technique used in UART (Universal Asynchronous Receiver/Transmitter) to improve the accuracy of data reception by sampling the incoming signal multiple times within a single bit period. This helps to minimize the impact of noise and timing inaccuracies. Here's an in-depth look at oversampling

![image](https://github.com/user-attachments/assets/450c34d8-821f-4a4c-8b40-dd972ae2910e)

## TOP Block Diagram

![image](https://github.com/user-attachments/assets/98e79b17-e43e-45c2-ba5e-48de4709dee6)

## Test Cases

![Screenshot 2024-07-14 073648](https://github.com/user-attachments/assets/dd08940f-bef0-4e6a-83ff-64bfc0f732ce)

## Schematic

![Screenshot 2024-07-15 031239](https://github.com/user-attachments/assets/72f7639b-5cf9-4983-9064-e8e77522927f)




