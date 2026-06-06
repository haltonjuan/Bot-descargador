nano bot_downloader.py
mkdir -p ~/downloads
nohup python bot_downloader.py > bot.log 2>&1 &
ls ~/downloads
termux-setup-storage
cp ~/downloads/*.mp4 ~/storage/downloads/
termux-media-scan ~/storage/downloads/
pkg install termux-api
termux-media-scan ~/storage/downloads/
clear
nano bot_downloader.py
pkill -f bot_downloader.py
nohup python bot_downloader.py > bot.log 2>&1 &
clear
cat bot.log
nano bot_downloader.py
pkill -f bot_downloader.py
nohup python bot_downloader.py > bot.log 2>&1 &
cat bot.log
rm bot_downloader.py
cat > bot_downloader.py << 'EOF'
import logging
from telegram import Update
from telegram.ext import Application, CommandHandler, MessageHandler, filters, ContextTypes
import yt_dlp
import os

logging.basicConfig(level=logging.INFO)

TOKEN = "8890918190:AAE90jgcMrgJO6Q8UYL_dNnZrkV-BEFe_KE"

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text("✅ Bot listo!\n\nPega cualquier link de video y lo descargo 📥")

async def download_video(update: Update, context: ContextTypes.DEFAULT_TYPE):
    url = update.message.text.strip()
    if not url.startswith("http"):
        await update.message.reply_text("❌ Eso no parece un link válido.")
        return

    msg = await update.message.reply_text("⏳ Descargando... espera por favor")

    try:
        ydl_opts = {
            'outtmpl': '/data/data/com.termux/files/home/downloads/%(title)s.%(ext)s',
            'format': 'best',
            'noplaylist': True,
        }
        with yt_dlp.YoutubeDL(ydl_opts) as ydl:
            info = ydl.extract_info(url, download=True)
            filename = ydl.prepare_filename(info)

        os.system(f'termux-media-scan "{filename}"')
        cp_path = f'/data/data/com.termux/files/home/storage/downloads/{os.path.basename(filename)}'
        os.system(f'cp "{filename}" "{cp_path}"')
        os.system(f'termux-media-scan "{cp_path}"')

        await msg.edit_text(f"✅ ¡Descargado!\n📁 Guardado en: Descargas/{os.path.basename(filename)}")
    except Exception as e:
        await msg.edit_text(f"❌ Error: {str(e)[:250]}")

def main():
    app = Application.builder().token(TOKEN).build()
    app.add_handler(CommandHandler("start", start))
    app.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, download_video))

    print("🤖 Bot iniciado correctamente... No cierres Termux")
    app.run_polling()

if __name__ == '__main__':
    main()
EOF

cat > bot_downloader.py << 'EOF'
import logging
from telegram import Update
from telegram.ext import Application, CommandHandler, MessageHandler, filters, ContextTypes
import yt_dlp
import os

logging.basicConfig(level=logging.INFO)

TOKEN = "8890918190:AAE90jgcMrgJO6Q8UYL_dNnZrkV-BEFe_KE"

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text("✅ Bot listo!\n\nPega cualquier link de video y lo descargo 📥")

async def download_video(update: Update, context: ContextTypes.DEFAULT_TYPE):
    url = update.message.text.strip()
    if not url.startswith("http"):
        await update.message.reply_text("❌ Eso no parece un link válido.")
        return

    msg = await update.message.reply_text("⏳ Descargando... espera por favor")

    try:
        ydl_opts = {
            'outtmpl': '/data/data/com.termux/files/home/downloads/%(title)s.%(ext)s',
            'format': 'best',
            'noplaylist': True,
        }
        with yt_dlp.YoutubeDL(ydl_opts) as ydl:
            info = ydl.extract_info(url, download=True)
            filename = ydl.prepare_filename(info)

        os.system(f'termux-media-scan "{filename}"')
        cp_path = f'/data/data/com.termux/files/home/storage/downloads/{os.path.basename(filename)}'
        os.system(f'cp "{filename}" "{cp_path}"')
        os.system(f'termux-media-scan "{cp_path}"')

        await msg.edit_text(f"✅ ¡Descargado!\n📁 Guardado en: Descargas/{os.path.basename(filename)}")
    except Exception as e:
        await msg.edit_text(f"❌ Error: {str(e)[:250]}")

def main():
    app = Application.builder().token(TOKEN).build()
    app.add_handler(CommandHandler("start", start))
    app.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, download_video))

    print("🤖 Bot iniciado correctamente... No cierres Termux")
    app.run_polling()

if __name__ == '__main__':
    main()
EOF

pkill -f bot_downloader.py
nohup python bot_downloader.py > bot.log 2>&1 &
cat bot.log
clear
exit
clear
bot
nohup python bot_downloader.py > bot.log 2>&1 &
exit
nohup python bot_downloader.py > bot.log 2>&1 &
exit
pkill -9 -f python
rm bot_downloader.py
cat > bot_downloader.py << 'EOF'
import logging
from telegram import Update, InlineKeyboardButton, InlineKeyboardMarkup
from telegram.ext import Application, CommandHandler, MessageHandler, CallbackQueryHandler, filters, ContextTypes
import yt_dlp
import os

logging.basicConfig(level=logging.INFO)

TOKEN = "8890918190:AAHnXzXLJe7AUevcaHqHhI0Q_tGno1jU6G0"
OWNER_ID = 6871765532

async def check(update: Update):
    if update.effective_user.id != OWNER_ID:
        await update.message.reply_text("Hola, lo siento, soy un bot exclusivamente de haltonjuan 🫶🏻")
        return False
    return True

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if not await check(update):
        return
    await update.message.reply_text("✅ Bot listo!\n\nPega cualquier link y te pregunto qué querés 📥")

async def link_directo(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if not await check(update):
        return
    url = update.message.text.strip()
    if not url.startswith("http"):
        return
    context.user_data['url'] = url
    keyboard = [
        [InlineKeyboardButton("🎬 Video (MP4)", callback_data="video"),
         InlineKeyboardButton("🎵 Audio (MP3)", callback_data="audio")]
    ]
    await update.message.reply_text("¿Qué querés descargar?", reply_markup=InlineKeyboardMarkup(keyboard))

async def boton(update: Update, context: ContextTypes.DEFAULT_TYPE):
    query = update.callback_query
    if query.from_user.id != OWNER_ID:
        await query.answer("Bot privado 🫶🏻", show_alert=True)
        return
    await query.answer()
    tipo = query.data
    url = context.user_data.get('url')
    if not url:
        await query.edit_message_text("❌ Link perdido, pegalo de nuevo.")
        return
    await query.edit_message_text("⏳ Descargando... espera")
    try:
        if tipo == 'audio':
            ydl_opts = {
                'outtmpl': '/data/data/com.termux/files/home/downloads/%(title)s.%(ext)s',
                'format': 'bestaudio/best',
                'noplaylist': True,
                'postprocessors': [{'key': 'FFmpegExtractAudio', 'preferredcodec': 'mp3'}],
            }
        else:
            ydl_opts = {
                'outtmpl': '/data/data/com.termux/files/home/downloads/%(title)s.%(ext)s',
                'format': 'best',
                'noplaylist': True,
            }
        with yt_dlp.YoutubeDL(ydl_opts) as ydl:
            info = ydl.extract_info(url, download=True)
            filename = ydl.prepare_filename(info)
        if tipo == 'audio':
            filename = os.path.splitext(filename)[0] + '.mp3'
        os.system(f'termux-media-scan "{filename}"')
        cp_path = f'/data/data/com.termux/files/home/storage/downloads/{os.path.basename(filename)}'
        os.system(f'cp "{filename}" "{cp_path}"')
        os.system(f'termux-media-scan "{cp_path}"')
        await query.edit_message_text(f"✅ Descargado!\n📁 {os.path.basename(filename)}")
    except Exception as e:
        await query.edit_message_text(f"❌ Error: {str(e)[:250]}")

def main():
    app = Application.builder().token(TOKEN).build()
    app.add_handler(CommandHandler("start", start))
    app.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, link_directo))
    app.add_handler(CallbackQueryHandler(boton))
    print("🤖 Bot iniciado... No cierres Termux")
    app.run_polling()

if __name__ == '__main__':
    main()
EOF

python bot_downloader.py
pkill -9 -f python
rm bot_downloader.py
cat > bot_downloader.py << 'EOF'
import logging
from telegram import Update, InlineKeyboardButton, InlineKeyboardMarkup
from telegram.ext import Application, CommandHandler, MessageHandler, CallbackQueryHandler, filters, ContextTypes
import yt_dlp
import os

logging.basicConfig(level=logging.INFO)

TOKEN = "8890918190:AAHnXzXLJe7AUevcaHqHhI0Q_tGno1jU6G0"
OWNER_ID = 6871765532

async def check(update: Update):
    if update.effective_user.id != OWNER_ID:
        await update.message.reply_text("Hola, lo siento, soy un bot exclusivamente de haltonjuan 🫶🏻")
        return False
    return True

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if not await check(update):
        return
    await update.message.reply_text("✅ Bot listo!\n\nPega cualquier link y te pregunto qué querés 📥")

async def link_directo(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if not await check(update):
        return
    url = update.message.text.strip()
    if not url.startswith("http"):
        await update.message.reply_text("ey wey eso no es un link, resume la conversación enviando solo para lo que fui hecho (link) okey 🫶🏻🖕")
        return
    context.user_data['url'] = url
    keyboard = [
        [InlineKeyboardButton("🎬 Video (MP4)", callback_data="video"),
         InlineKeyboardButton("🎵 Audio (MP3)", callback_data="audio")]
    ]
    await update.message.reply_text("¿Qué querés descargar?", reply_markup=InlineKeyboardMarkup(keyboard))

async def boton(update: Update, context: ContextTypes.DEFAULT_TYPE):
    query = update.callback_query
    if query.from_user.id != OWNER_ID:
        await query.answer("Bot privado 🫶🏻", show_alert=True)
        return
    await query.answer()
    tipo = query.data
    url = context.user_data.get('url')
    if not url:
        await query.edit_message_text("❌ Link perdido, pegalo de nuevo.")
        return
    await query.edit_message_text("⏳ Descargando... espera")
    try:
        if tipo == 'audio':
            ydl_opts = {
                'outtmpl': '/data/data/com.termux/files/home/downloads/%(title)s.%(ext)s',
                'format': 'bestaudio/best',
                'noplaylist': True,
                'postprocessors': [{'key': 'FFmpegExtractAudio', 'preferredcodec': 'mp3'}],
            }
        else:
            ydl_opts = {
                'outtmpl': '/data/data/com.termux/files/home/downloads/%(title)s.%(ext)s',
                'format': 'best',
                'noplaylist': True,
            }
        with yt_dlp.YoutubeDL(ydl_opts) as ydl:
            info = ydl.extract_info(url, download=True)
            filename = ydl.prepare_filename(info)
        if tipo == 'audio':
            filename = os.path.splitext(filename)[0] + '.mp3'
        os.system(f'termux-media-scan "{filename}"')
        cp_path = f'/data/data/com.termux/files/home/storage/downloads/{os.path.basename(filename)}'
        os.system(f'cp "{filename}" "{cp_path}"')
        os.system(f'termux-media-scan "{cp_path}"')
        await query.edit_message_text(f"✅ Descargado!\n📁 {os.path.basename(filename)}")
    except Exception as e:
        await query.edit_message_text(f"❌ Error: {str(e)[:250]}")

def main():
    app = Application.builder().token(TOKEN).build()
    app.add_handler(CommandHandler("start", start))
    app.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, link_directo))
    app.add_handler(CallbackQueryHandler(boton))
    print("🤖 Bot iniciado... No cierres Termux")
    app.run_polling()

if __name__ == '__main__':
    main()
EOF

python bot_downloader.py
exit
pkill -f morse_bot.py
rm morse_bot.py
cat > morse_bot.py << 'EOF'
import logging
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

def texto_a_morse(texto):
    return ' '.join(MORSE.get(c.upper(), '?') for c in texto)

async def morse(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if update.effective_user.id != OWNER_ID:
        await update.message.reply_text("hola soy un bot creado exclusivamente para haltonjuan 🫶🏻")
        return
    texto = update.message.text
    await update.message.reply_text(texto_a_morse(texto))

def main():
    app = Application.builder().token(TOKEN).build()
    app.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, morse))
    print("🤖 Bot morse iniciado!")
    app.run_polling()

if __name__ == '__main__':
    main()
EOF

python morse_bot.py
clear
pkill -f morse_bot.py
rm morse_bot.py
cat > morse_bot.py << 'EOF'
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

def texto_a_morse(texto):
    limpio = re.sub(r'[^A-Za-z0-9 ]', '', texto)
    return ' '.join(MORSE.get(c.upper(), '') for c in limpio).strip()

async def morse(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if update.effective_user.id != OWNER_ID:
        await update.message.reply_text("hola soy un bot creado exclusivamente para haltonjuan 🫶🏻")
        return
    texto = update.message.text
    resultado = texto_a_morse(texto)
    await update.message.reply_text(resultado)

def main():
    app = Application.builder().token(TOKEN).build()
    app.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, morse))
    print("🤖 Bot morse iniciado!")
    app.run_polling()

if __name__ == '__main__':
    main()
EOF

python morse_bot.py
clear
pkill -f morse_bot.py
rm morse_bot.py
cat > morse_bot.py << 'EOF'
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
EOF

python morse_bot.py
exit
python morse_bot.py
clear
nohup python bot_downloader.py > bot.log 2>&1 &
clear
exit
nohup python bot_downloader.py > bot.log 2>&1 &
exit
