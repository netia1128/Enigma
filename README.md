# Enigma 

## Description  
Enigma is a ruby-based project completed during my time at the Turing School of Software and Design. The aim of the project is to create a tool that runs off a command-line interface that is capable of carrying out ceaser cipher encyption or decryption of a message, as well as cracking an encryption code. More details on the encryption algorithim can be found [here](https://backend.turing.edu/module1/projects/enigma/encryption). 

## Design  
Enigma has a lean design. The pipeline starts with a user provided text file that includes a message to be encrypted or decrypted. Following a CLI prompt, a runner file reads the message contained in the text file, and passes it to the enigma class to be decrypted or encrypted. Based upon the action requested, the enigma class will reach out to a module that will provide the encryption/decryption key, or it will reach out to a class that cracks and unknown encryption key. 

![image](https://user-images.githubusercontent.com/76889420/121425788-07b75280-c930-11eb-9dc3-663639d8dae5.png)

## Testing  
The project uses Rspec to test the project. Each method contained within the project has an accompanying test. Particular attention was paid to edge cases.

## Running Enigma
