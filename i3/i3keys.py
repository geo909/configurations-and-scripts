import re
from pathlib import Path

# --- settings ---
CONFIG_PATH = Path.home() / ".config/i3/config"
SKIP_IF_ACTION_MATCHES = re.compile(
    r"^(?:focus (?:left|right|up|down)|"
    r"move (?:left|right|up|down)\b(?!.*workspace)|"     # pure move, not "move container to workspace"
    r"workspace number \d+$|workspace (?:next|prev)$|"
    r"bindsym .*(?:Left|Right|Up|Down)\b)", re.I
)
# also skip: Super+h/j/k/l & their Shift (duplicates of move/focus); handled by action & key tests below

def load_config_text():
    try:
        return CONFIG_PATH.read_text(encoding="utf-8", errors="ignore")
    except Exception as e:
        return ""

cfg = load_config_text()

# --- gather variables from `set $var value` ---
var_map = {}
for m in re.finditer(r'^\s*set\s+\$(\S+)\s+(.+?)\s*$', cfg, flags=re.M):
    var_map["$"+m.group(1)] = m.group(2)

# friendly names
def friendly_mod(x):
    return {"Mod4":"Super", "Mod1":"Alt"}.get(x, x)

# Resolve variables used in actions like: exec $browser
def resolve_vars(s):
    # replace known $vars with their values (e.g., $browser -> google-chrome)
    for k,v in sorted(var_map.items(), key=lambda kv: -len(kv[0])):
        s = s.replace(k, v)
    return s

# For key combo text: map $a..$z to letters; $mod/$alt to friendly names
def beautify_keys(keys_raw):
    s = keys_raw.strip()

    # normalize whitespace around + and remove repeated spaces
    s = re.sub(r'\s*\+\s*', '+', s)
    s = re.sub(r'\s+', ' ', s)

    # drop flags like --release
    s = s.replace('--release', '').strip()

    # replace $mod/$alt with Mod strings (then to friendly)
    s = s.replace('$mod', var_map.get('$mod', '$mod'))
    s = s.replace('$alt', var_map.get('$alt', '$alt'))

    # $lshift/$rshift -> Shift
    s = s.replace('$lshift', 'Shift').replace('$rshift', 'Shift')

    # $a..$z -> letters
    def letter_sub(m):
        return m.group(1).upper()
    s = re.sub(r'\$([a-z])\b', letter_sub, s)

    # convert Mod names to friendly
    parts = s.split('+')
    parts = [friendly_mod(p) for p in parts]

    # pretty names for some keys
    pretty = {
        'Return':'Enter',
        'Print':'Print',
        'minus':'-',
        'Tab':'Tab',
        'space':'Space',
        'XF86MonBrightnessUp':'BrightnessUp',
        'XF86MonBrightnessDown':'BrightnessDown',
        'ctrl':'Ctrl', 'Ctrl':'Ctrl',
        'Shift':'Shift'
    }
    parts = [pretty.get(p, p) for p in parts]

    # fix casing/spacing
    parts = [p.strip() for p in parts if p.strip()]
    return " + ".join(parts)

# Extract bindings
bindings = []
pattern = re.compile(r'^\s*(bindcode|bindsym)\s+(.+?)\s+(.*)$', re.M)

# Common action starters to separate keys from action when there is no 'exec'
ACTION_STARTERS = r'(exec|focus|move|layout|split|fullscreen|floating|scratchpad|workspace|reload|restart|mode|kill|bar|border)'
sep_re = re.compile(r'\b' + ACTION_STARTERS + r'\b', re.I)

for m in pattern.finditer(cfg):
    kind, keys_and_maybe_space, rest = m.group(1), m.group(2), m.group(3)

    # Some configs put spaces around +, or multiple key tokens. Try to split before the action keyword.
    keys_part = keys_and_maybe_space
    action_part = rest
    # If keys_part accidentally includes action (due to odd spacing), split:
    if not re.search(r'\b(exec|focus|move|layout|split|fullscreen|floating|scratchpad|workspace|reload|restart|mode|kill|bar|border)\b', action_part, re.I):
        # try to rejoin from the whole tail
        tail = keys_and_maybe_space + " " + rest
        hit = sep_re.search(tail)
        if hit:
            keys_part = tail[:hit.start()].strip()
            action_part = tail[hit.start():].strip()

    # Clean action (remove flags)
    action = re.sub(r'\s*--no-startup-id\b', '', action_part)
    action = re.sub(r'\s*--release\b', '', action)
    action = action.strip()

    # Resolve variables in action only for readability
    pretty_action = resolve_vars(action)

    # Skip comments or empty
    if not keys_part or not pretty_action or pretty_action.startswith('#'):
        continue

    # Skip basic/boring bindings
    if SKIP_IF_ACTION_MATCHES.match(pretty_action):
        continue

    # Also skip classic focus/move with h/j/k/l explicitly in keys
    rawkeys_lower = keys_part.lower()
    if re.search(r'\$[hjkl]\b', rawkeys_lower):
        # focus/move were already filtered, but catch any leftover variants
        continue

    # Beautify keys
    keys = beautify_keys(keys_part)

    # Tighten: collapse duplicate spaces around '+' already done
    # Shorten verbose actions
    nice = pretty_action
    nice = nice.replace('i3-sensible-terminal', 'terminal')
    nice = nice.replace('google-chrome', 'Chrome')
    nice = nice.replace('firefox', 'Firefox')
    nice = nice.replace('thunar', 'Thunar')
    nice = nice.replace('flameshot gui', 'Flameshot (GUI)')
    nice = re.sub(r'^\s*exec\s+', '', nice)  # show command after exec
    nice = nice.replace('terminal -e ', 'terminal: ')
    nice = nice.replace('compton -b', 'Compton (start)')

    # squish multiple spaces
    nice = re.sub(r'\s{2,}', ' ', nice).strip('; ').strip()

    bindings.append((keys, nice))

# De-duplicate while preserving order
seen = set()
unique = []
for k,a in bindings:
    key = (k,a)
    if key not in seen:
        seen.add(key)
        unique.append(key)

# Pretty print for Conky
print("i3 Keybindings (useful ones)")
print("--------------------------------")
for k, a in unique:
    # Show arrow → between
    print(f"{k:25}  →  {a}")
