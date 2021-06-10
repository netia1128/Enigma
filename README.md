# Enigma 
![Caesar_cipher](https://user-images.githubusercontent.com/76889420/121444413-b7022280-c94c-11eb-9d76-78677b184a9d.png)

## Description  
Enigma is a ruby-based project completed during my time at the Turing School of Software and Design. The aim of the project is to create a tool that runs off a command-line interface that is capable of carrying out ceaser cipher encyption or decryption of a message, as well as cracking an encryption code. More details on the encryption algorithim can be found [here](https://backend.turing.edu/module1/projects/enigma/encryption). 

## Design  
Enigma has a lean design. The pipeline starts with a user provided text file that includes a message to be encrypted or decrypted. Following a CLI prompt, a runner file reads the message contained in the text file, and passes it to the enigma class to be decrypted or encrypted. Based upon the action requested, the enigma class will reach out to a module that will provide the encryption/decryption key, or it will reach out to a class that cracks an unknown encryption key. The information is generated and passed back up the chain into encryption/decryption text files.

![image](https://user-images.githubusercontent.com/76889420/121425788-07b75280-c930-11eb-9dc3-663639d8dae5.png)

## Testing  
The project uses Rspec to test the project. Each method contained within the project has an accompanying test. Particular attention was paid to edge cases.

## Running Enigma

After cloning the project, choose one of the paths below to run the program.

**To Encrypt**  
1. To encrypt, write a message in message_to_encrypt.
2. Run the following command in your CLI ```$ ruby encrypt.rb message_to_encrypt.txt encrypted_message.txt. ```
3. Your encyrpted message will be found in encrypted_message.txt

**To Decrypt**  
1. Start by encrypting a message using the steps above.
2. Run the following command in your CLI ```$ ruby decrypt.rb encrypted_message.txt.txt decrypted_message.txt. ```
3. Your decyrpted message will be found in decrypted_message.txt

**To Crack**  
Cracking will crack an encrypted message, and it will report to you the key that was used to encrypt it. 
1. Start by encrypting a message using the steps above. Note - the message must end in ' end' for the cracker to work.
2. Run the following command in your CLI ```$ ruby crack.rb encrypted_message.txt craced.txt. ``
 
