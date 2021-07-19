'''
    # Computer Security Course 3992

    # Question 1 ? -------------------------------------------------------
        Caesar cipher decryption

        i) ‫‪  HdxmjnjaoZsxcvibznzmqzm‬‬
        ii)‫‪  KfpjSjykqncfuutsUqfdXytwjhfzlmymnofhpnslBmfyxFuuxjxxntsx‬‬
        iii) ‫‪.4)/C+g-;)x'i1v0k:y'2=yz')xk6z';k+{:kF`OE‬‬
        iv)  ‫‪9?4:Nw4>88G9?<K4CCBA#?4L&GBE864H:;G;<=46><A:*;4GFrCCF‬‬‫‪8FF<BAFP‬‬
        v)   ‫‪BH=CWPDEO;DKIASKNG;EO;=>KQP;?NULPKCN=LDU;=J@;GA‬‬‫U;I=J=CAIAJPhY‬‬

    # How to run it ? ----------------------------------------------------
        ~$ pip3 install inquirer
        ~$ python3 q1.py

    # Who am I ? ---------------------------------------------------------
        Author : Maryam Saeedmehr
        Std.NO : 9629373
'''
import inquirer
import string

class bcolors:
    HEADER    = '\033[95m'
    OKBLUE    = '\033[94m'
    OKCYAN    = '\033[96m'
    OKGREEN   = '\033[92m'
    WARNING   = '\033[93m'
    FAIL      = '\033[91m'
    ENDC      = '\033[0m'
    BOLD      = '\033[1m'
    UNDERLINE = '\033[4m'

lower_letters     = string.ascii_lowercase
upper_letters     = string.ascii_uppercase
punctuation_mark  = string.punctuation
digits            = string.digits
englishLetterFreq = {'E': 12.70, 'T': 9.06,
                     'A': 8.17,  'O': 7.51,
                     'I': 6.97,  'N': 6.75,
                     'S': 6.33,  'H': 6.09,
                     'R': 5.99,  'D': 4.25,
                     'L': 4.03,  'C': 2.78,
                     'U': 2.76,  'M': 2.41,
                     'W': 2.36,  'F': 2.23,
                     'G': 2.02,  'Y': 1.97,
                     'P': 1.93,  'B': 1.29,
                     'V': 0.98,  'K': 0.77,
                     'J': 0.15,  'X': 0.15,
                     'Q': 0.10,  'Z': 0.07}
alphabet_map_num  = dict(zip(range(1,27), string.ascii_uppercase))
end_program       = False

def phi_calculation(i, ciphertext):
    letter_frequency = dict.fromkeys(string.ascii_uppercase, 0)
    phi = 0
    for letter in upper_letters:
        letter_frequency[letter] = ciphertext.upper().count(letter)/len(ciphertext)*100
        phi += letter_frequency[letter] * englishLetterFreq[
        upper_letters[(upper_letters.index(letter)-key)%26]
        ]
    return phi

while not end_program:
    what_to_do = [
        inquirer.List('choice',
            message='What do you want to do',
            choices=['Decrypt a cipher text',
                    'Frequency Analysis',
                    'Exit from the program'],
        ),
    ]
    sentences = [
        inquirer.List('ciphertext',
            message='Which cipher text do you want to decrypt: ',
            choices=["HdxmjnjaoZsxcvibznzmqzm‬‬",
                    "KfpjSjykqncfuutsUqfdXytwjhfzlmymnofhpnslBmfyxFuuxjxxntsx‬‬",
                    ".4)/C+g-;)x'i1v0k:y'2=yz')xk6z';k+{:kF`OE",
                    "9?4:Nw4>88G9?<K4CCBA#?4L&GBE864H:;G;<=46><A:*;4GFrCCF8FF<BAFP",
                    "BH=CWPDEO;DKIASKNG;EO;=>KQP;?NULPKCN=LDU;=J@;GAU;I=J=CAIAJPhY",
                    "Others...",]
        ),
    ]
    frequencyAnalysisSentences = [
        inquirer.List('freqAnalysis',
                message='Which cipher text do you want to analyze: ',
                choices=["HdxmjnjaoZsxcvibznzmqzm‬‬",
                        "KfpjSjykqncfuutsUqfdXytwjhfzlmymnofhpnslBmfyxFuuxjxxntsx‬‬",]
        ),
    ]
    decide = inquirer.prompt(what_to_do)

    if decide['choice'] == 'Decrypt a cipher text':
        ciphertext = inquirer.prompt(sentences)['ciphertext']
        if ciphertext == 'Others...':
            ciphertext = input('[' + bcolors.WARNING + '?' + bcolors.ENDC
                                + '] Enter you cypher text: ')

        if not(set(ciphertext).intersection(punctuation_mark)
                or set(ciphertext).intersection(digits)):
            # for cipher text containing only letters(upper or lower case)
            print(bcolors.OKBLUE + '[key] ' + 'Plain text'.center(len(ciphertext), ' ') + bcolors.ENDC)
            print(bcolors.OKBLUE + '-'*(len(ciphertext)+6) + bcolors.ENDC)
            for key in range(1, 26):
                plaintext = ""
                for letter in ciphertext:
                    if letter in lower_letters:
                        plaintext += lower_letters[(lower_letters.index(letter)
                                                - key) % 26]
                    if letter in upper_letters:
                        plaintext += upper_letters[(upper_letters.index(letter)
                                                - key) % 26]

                print(bcolors.OKBLUE + f'[{key%94:3d}] {plaintext}' + bcolors.ENDC)
            print()

        else: # for cipher text containing digits or punctuation_mark
            print(bcolors.OKBLUE + '[key] ' + 'Plain text'.center(len(ciphertext), ' ') + bcolors.ENDC)
            print(bcolors.OKBLUE + '-'*(len(ciphertext)+6) + bcolors.ENDC)
            for key in range(33, 127):
                plaintext = ""
                for letter in ciphertext:
                    plaintext += chr((ord(letter) - key)%94 + 33)

                print(bcolors.OKBLUE + f'[{key:3d}] {plaintext}' + bcolors.ENDC)
            print()

    elif decide['choice'] == 'Frequency Analysis':
        ciphertext = inquirer.prompt(frequencyAnalysisSentences)['freqAnalysis']
        phi_i = [0]*26
        for key in range(1, 26):
            phi_i[key - 1] = phi_calculation(key, ciphertext)

        for i in range(1, 26):
            if phi_i[i-1] == max(phi_i):
                print(bcolors.WARNING + bcolors.BOLD + f'[{i:2d}] {phi_i[i-1]} *' + bcolors.ENDC)
            else:
                print(bcolors.OKBLUE + f'[{i:2d}] {phi_i[i-1]}' + bcolors.ENDC)
        print()

    else: # Exit from the program
        print(bcolors.BOLD + bcolors.HEADER + '[+] Author : Maryam Saeedmehr' + bcolors.ENDC)
        print(bcolors.BOLD + bcolors.HEADER + '[+] Std NO : 9629373' + bcolors.ENDC)
        print(bcolors.BOLD + bcolors.HEADER + '[+] Bye Bye \N{winking face}' + bcolors.ENDC)
        end_program = True