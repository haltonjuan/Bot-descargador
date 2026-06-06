import logging
import re
from telegram import Update
from telegram.ext import Application, MessageHandler, filters, ContextTypes

logging.basicConfig(level=logging.INFO)

TOKEN = "8922065307:AAHT6DGqbP17Y5igasnEWrq_OXYdPMg-3Gg"
OWNER_ID = 6871765532

MORSE = {
    'A': '.-', 'B': '-...', 'C': '-.-.', 'D': '-..', 'E': '.',
    'F': '..-.', 'G': '--.', 'H': '....', 'I': '..', 'J': '.---',
    'K': '-.-', 'L': '.-..', 'M': '--', 'N': '-.', 'O': '---',
    'P': '.--.', 'Q': '--.-', 'R': '.-.', 'S': '...', 'T': '-',
    'U': '..-', 'V': '...-', 'W': '.--', 'X': '-..-', 'Y': '-.--',
    'Z': '--..', '0': '-----', '1': '.----', '2': '..---', '3': '...--',
    '4': '....-', '5': '.....', '6': '-....', '7': '--...', '8': '---..',
    '9': '----.', ' ': '/'
}

MORSE_INVERSO = {v: k for k, v in MORSE.items()}

def texto_a_morse(texto):
    limpio = re.sub(r'[^A-Za-z0-9 ]', '', texto)
    return ' '.join(MORSE.get(c.upper(), '') for c in limpio).strip()

def morse_a_texto(morse):
    palabras = morse.strip().split(' / ')
    resultado = ''
    for palabra in palabras:
        letras = palabra.strip().split(' ')
        for letra in letras:
            resultado += MORSE_INVERSO.get(letra, '?')
        resultado += ' '
    return resultado.strip()

def es_morse(texto):
    limpio = texto.replace(' ', '').replace('/', '')
    return all(c in '.-' for c in limpio) and len(limpio) > 0

async def convertir(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if update.effective_user.id != OWNER_ID:
        await update.message.reply_text("hola soy un bot creado exclusivamente para haltonjuan 🫶🏻")
        return
    texto = update.message.text
    if es_morse(texto):
        await update.message.reply_text(morse_a_texto(texto))
    else:
        await update.message.reply_text(texto_a_morse(texto))

def main():
    app = Application.builder().token(TOKEN).build()
    app.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, convertir))
    print("🤖 Bot morse iniciado!")
    app.run_polling()

if __name__ == '__main__':
    main()
