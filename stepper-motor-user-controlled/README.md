# Question
Write a program to drive a stepper motor forward continuously when user inputs '1', backward when '2', and idle when '0'. User input is received in serial port. Stepper motor is connected via parallel port.

# Note
Keyboard buffer is read one at a time after each half-step. <br/>
2 will make it AntiClock, 1 will make it Clock, 0 will make it IDLE.

# Example
* ### Keyboard Buffer Sequence - 212010200 <br/>
Displayed Stepper after each Buffer Char is read. <br/>
Motor Direction can be seen as an arrow on top left of motor. <br/>
Keyboard Buffer can be viewed at the bottom. <br/>

### Initially Moving Clockwise
![ex1a](ex1a.JPG) <br/>

![ex1b](ex1b.JPG) <br/>

![ex1c](ex1c.JPG) <br/>

![ex1d](ex1d.JPG) <br/>

![ex1e](ex1e.JPG) <br/>

![ex1f](ex1f.JPG) <br/>

![ex1g](ex1g.JPG) <br/>

![ex1h](ex1h.JPG) <br/>

![ex1i](ex1i.JPG) <br/>

![ex1j](ex1j.JPG) <br/>

### Buffer is Empty now. Motor was Idle at last. It stays Idle until buffer gets another character Input.
