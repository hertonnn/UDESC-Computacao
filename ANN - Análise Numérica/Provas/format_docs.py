import os, glob, re

folder = r'C:\Users\UserOtt\Documents\FACULDADE\UDESC-Computacao\ANN - Análise Numérica\Provas'
files = sorted(glob.glob(os.path.join(folder, '*.md')))

def format_file(fpath):
    with open(fpath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # 5. Remove tabs
    content = content.replace('\t', '  ')
    
    # 8. Never $$...$$ on same line. Replace inline block $$...$$ with block
    # Matches $$ something $$ on the same line, ignoring cases where it's already a block
    # We use non-greedy .*? and DOTALL is false (default) so it matches within the same line.
    content = re.sub(r'\$\$(.*?)\$\$', r'\n$$\n\1\n$$\n', content)
    
    # Cleanup multiple newlines
    content = re.sub(r'\n{3,}', '\n\n', content)
    
    lines = content.split('\n')
    out_lines = []
    
    in_math_block = False
    
    for i, line in enumerate(lines):
        line = line.rstrip()
        
        # 10. $$ block inside lists shouldn't be indented
        if line.strip() == '$$':
            line = '$$'
            in_math_block = not in_math_block
            
        if in_math_block or line == '$$':
            # 9. Matrix/system multi-lines (\\) shouldn't be compacted
            if r'\\' in line and not line.endswith(r'\\'):
                parts = re.split(r'\\\\(\s*)', line)
                new_line = ''
                for idx in range(0, len(parts)-1, 2):
                    new_line += parts[idx].strip() + r'\\' + '\n'
                new_line += parts[-1].strip()
                line = new_line.strip()
        
        # 3. List markers to '-'
        if not in_math_block:
            m = re.match(r'^(\s*)[\*\+]\s+(.*)$', line)
            if m:
                line = f'{m.group(1)}- {m.group(2)}'
                
        out_lines.append(line)
        
    # Reassemble and fix empty lines
    content = '\n'.join(out_lines)
    
    # Handle the multiple newlines that might have been introduced in matrices
    content = re.sub(r'\\\\\n\s*', r'\\\\\n', content)
    
    # 1. Blank lines around specific blocks.
    # It's easier to ensure blank lines around $$
    content = re.sub(r'([^\n])\n\$\$', r'\1\n\n$$', content)
    content = re.sub(r'\$\$\n([^\n])', r'$$\n\n\1', content)
    
    # Ensure blank lines around headings
    content = re.sub(r'([^\n])\n(#+ )', r'\1\n\n\2', content)
    content = re.sub(r'(#+ .*)\n([^\n])', r'\1\n\n\2', content)
    
    # Ensure blank lines around separators
    content = re.sub(r'([^\n])\n(---)', r'\1\n\n\2', content)
    content = re.sub(r'(---)\n([^\n])', r'\1\n\n\2', content)
    
    # 2. Never two --- consecutive
    content = re.sub(r'---\n+---', r'---', content)
    
    # Fix tables separation (Regra 11)
    # Search for |---|---|...| and replace with | :--- | :--- |
    # (Matches any sequence of pipe and dashes)
    def fix_table_separator(match):
        row = match.group(0)
        # Ensure it has :---
        row = re.sub(r'\|-+', '| :--- ', row)
        row = row.replace(' ', '').replace(':', ' :').replace('|:', '| :')
        # A simpler way: if it looks like a separator row, replace elements
        cells = row.split('|')
        new_cells = []
        for c in cells:
            c = c.strip()
            if set(c) == {'-'} or set(c) == {'-', ':'}:
                if not ':' in c:
                    new_cells.append(':---')
                else:
                    new_cells.append(c)
            else:
                new_cells.append(c)
        return '|'.join(new_cells)
    
    content = re.sub(r'\|(?:\s*:-*:?\s*\|)+', fix_table_separator, content)
    content = re.sub(r'\|(?:\s*-+\s*\|)+', fix_table_separator, content)
    
    # Ensure blank lines around tables
    content = re.sub(r'([^\n])\n(\|(?:.*?)\|)', r'\1\n\n\2', content)
    content = re.sub(r'(\|(?:.*?)\|)\n([^\n\|])', r'\1\n\n\2', content)
    
    # Final cleanup of excessive newlines
    content = re.sub(r'\n{3,}', '\n\n', content)
    
    with open(fpath, 'w', encoding='utf-8') as f:
        f.write(content.strip() + '\n')

for fpath in files:
    fname = os.path.basename(fpath)
    if fname.startswith('prompt'):
        continue
    format_file(fpath)
    print(f'Formatted: {fname}')
