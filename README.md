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
    <title>UART RX Port Description</title>
    <style>
        table {
            width: 50%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
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
