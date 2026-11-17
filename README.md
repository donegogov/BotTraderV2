# 🤖 BotTrader — Trend + Daily (новите ботови)

**Автоматски ги тргува сигналите од новите ботови (Trend 4h, Daily 15m, v1 и v2)
на твојот Bybit или Binance акаунт.**

Чита директно од **Telegram** — преку твојот сопствен Telegram акаунт.
Нема сервер, нема API, ништо не е изложено. Истата архитектура како DipPop BotTrader-от.

---

## 🎯 Како избираш кој бот да се тргува

Секој сигнал во каналот носи `#signal` JSON блок со полиња **`bot`** и **`version`**.
Во `--setup` избираш **броеви од каталогот, со запирка** — пример: `1,5,12,14`.

```
  Достапни ботови (избери по број, со запирка):

     1) Trend·rules   — 4h тренд, само long
     2) Trend·veto    — правила + AI вето
     3) Trend·auto    — AI одлучува long/short
     4) Trend·ens     — 2 AI гласаат
     5) Trend·rules2  — v2 long+short
     6) Trend·veto2   — v2 + AI вето
     7) Trend·auto2   — v2 AI long/short
     8) Trend·ens2    — v2 2 AI гласаат
     9) Daily·rules   — 15m дипови, само long
    10) Daily·veto    — правила + AI вето
    11) Daily·ai      — AI enter/hold/exit
    12) Daily·rules2  — v2 дипови + rally shorts
    13) Daily·veto2   — v2 правила + AI вето
    14) Daily·ai2     — v2 AI со shorts
```

- Секој избран бот тргува **посебно** (позициите се чуваат по бот/верзија/симбол).
- **DipPop сигналите** (без `bot`/`version` во JSON) автоматски се **игнорираат** — за нив постои диппоп-овскиот BotTrader.
- `python bot_trader.py --list` — ја печати листата во секое време.

---

## 📋 Што ти треба

| Што | Како |
|---|---|
| Компјутер | Windows, macOS или Linux |
| Интернет | ✅ |
| **Telegram акаунт** | Го имаш веќе (телефон) |
| **Претплата на каналот** | Мора да си член за да читаш сигнали |
| Bybit или Binance | (само за реално тргување) |

---

## 🔑 Само членови на каналот можат да читаат

Ботот се најавува со **твојот Telegram акаунт** (преку Telethon) и ги чита пораките
како обичен член. Ако не си член на каналот — нема да работи (Telegram сам го блокира).
📖 Детално упатство: [TELETHON.md](TELETHON.md)

---

# 🪟 Windows — ЧЕКОР ПО ЧЕКОР

1. **Python 3.12** од https://www.python.org/downloads/ — при инсталација штиклирај **„Add python.exe to PATH"**.
2. Симни ја папката `bottrader-v2` (како ZIP, извлечи ја).
3. Во папката: отвори `cmd` → `pip install requests telethon qrcode`
4. Најава: `python bot_trader.py --login`
   - **1 = QR** — скенирај со телефон (Telegram → Settings → Devices → Link Desktop Device)
   - **2 = телефон + код** — кодот доаѓа во Telegram апликацијата (не SMS; доколку имаш 2FA, внеси ја лозинката)
5. Поставки: `python bot_trader.py --setup`
   - Внеси го каналот, избери **броеви на ботови** (пример `1,5,12,14`), берза, левериџ, **PAPER или LIVE**
6. Старт: `python bot_trader.py`

> Или двоен клик на `1-install-windows.bat` → `2-start-windows.bat`

# 🍎 macOS

```bash
pip3 install requests telethon qrcode
python3 bot_trader.py --login     # 1 = QR (најлесно)
python3 bot_trader.py --setup
python3 bot_trader.py
```

> Или двоен клик на `1-install-macos.command` → `2-start-macos.command`

# 🐧 Linux

```bash
pip3 install requests telethon qrcode
python3 bot_trader.py --login
python3 bot_trader.py --setup
python3 bot_trader.py
```

---

# ⚙️ КОМАНДИ

| Што | Команда |
|---|---|
| Најава (QR / телефон) | `python bot_trader.py --login` |
| Поставки (кои ботови, берза, режим) | `python bot_trader.py --setup` |
| Листа на ботови | `python bot_trader.py --list` |
| Состојба (отворени позиции) | `python bot_trader.py --status` |
| Offline paper тест | `python bot_trader.py --test-signal` |
| Избриши сесија | `python bot_trader.py --logout` |

---

# ⚠️ LIVE режим

- Потребни се **твоите** API клучеви (Bybit или Binance) — `--setup` ќе ги побара.
- Дозволи: **Read + Trade**, НИКОГАШ **Withdraw**.
- Започни со **PAPER** и мала сума, провери 20–30 сигнали, па дури тогаш LIVE.
- Левериџот е **твој избор** (1 = исто како ботот; поголем = поголем ризик и ликвидација).
- Сигналите се само намера на ботот — ти одлучуваш дали и со колкав левериџ да ги следиш.

# 📦 Како се чита сигналот (за програмери)

```python
import re, json
def parse_signal(text):
    m = re.search(r"#signal\s+(\{.*\})", text, re.DOTALL)
    return json.loads(m.group(1)) if m else None
# sig["bot"] + sig["version"] → кој бот; без нив → DipPop сигнал (игнорирај овде)
```
