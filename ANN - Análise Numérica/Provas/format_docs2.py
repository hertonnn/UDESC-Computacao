import os, glob, re

folder = r'C:\Users\UserOtt\Documents\FACULDADE\UDESC-Computacao\ANN - Análise Numérica\Provas'
files = sorted(glob.glob(os.path.join(folder, '*.md')))

def format_file(fpath):
    with open(fpath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Rule 5: Zero tabs
    content = content.replace('\t', '  ')
    
    # Pre-process: Ensure $$...$$ on a single line becomes multiline
    content = re.sub(r'\$\$(.*?)\$\$', r'\n$$\n\1\n$$\n', content)
    
    # Split by lines
    lines = content.split('\n')
    
    out_lines = []
    in_math_block = False
    
    for line in lines:
        line = line.rstrip() # remove trailing spaces
        
        # Rule 10: $$ inside lists should be at col 0
        if line.strip() == '$$':
            line = '$$'
            in_math_block = not in_math_block
            out_lines.append(line)
            continue
            
        if in_math_block:
            # Rule 9: Matrix/system lines split by \\
            if r'\\' in line and not line.endswith(r'\\'):
                parts = re.split(r'\\\\', line)
                new_line = ''
                for idx in range(len(parts)-1):
                    new_line += parts[idx].strip() + r'\\' + '\n'
                new_line += parts[-1].strip()
                # Split this new_line and append each part
                for p in new_line.split('\n'):
                    if p.strip():
                        out_lines.append(p.strip())
            else:
                if line.strip():
                    out_lines.append(line)
        else:
            # Rule 3: List markers
            m = re.match(r'^(\s*)[\*\+]\s+(.*)$', line)
            if m:
                line = f'{m.group(1)}- {m.group(2)}'
            
            # Rule 11: Tables separators
            if '|' in line and '-' in line and not re.search(r'[a-zA-Z0-9]', line):
                if re.match(r'^\|?(\s*:?-+:?\s*\|?)+$', line):
                    cells = line.split('|')
                    new_cells = []
                    for c in cells:
                        c = c.strip()
                        if set(c).issubset({'-', ':'}) and len(c) > 0:
                            if ':' not in c:
                                new_cells.append(' :--- ')
                            else:
                                new_cells.append(f' {c} ')
                        else:
                            new_cells.append(c)
                    line = '|'.join(new_cells)
            
            out_lines.append(line)

    # Now enforce Rule 1 (Blank lines around headings, separators, tables, blocks $$, lists)
    content = '\n'.join(out_lines)
    
    # Clean up empty lines
    content = re.sub(r'\n{3,}', '\n\n', content)
    
    lines = content.split('\n')
    final_lines = []
    
    def is_table(l):
        return l.strip().startswith('|') and l.strip().endswith('|')
    
    def is_heading(l):
        return l.startswith('#')
        
    def is_separator(l):
        return l.strip() == '---'
        
    def is_list(l):
        return re.match(r'^\s*-\s+', l) is not None
        
    in_math = False
    for i, line in enumerate(lines):
        if line.strip() == '$$':
            in_math = not in_math
            if in_math:
                if len(final_lines) > 0 and final_lines[-1].strip() != '':
                    final_lines.append('')
                final_lines.append(line)
            else:
                final_lines.append(line)
                if i+1 < len(lines) and lines[i+1].strip() != '':
                    final_lines.append('')
            continue
            
        if in_math:
            final_lines.append(line)
            continue
            
        if line.strip() == '':
            final_lines.append(line)
            continue
            
        needs_blank_before = False
        if i > 0 and final_lines[-1].strip() != '':
            if is_heading(line): needs_blank_before = True
            if is_separator(line): needs_blank_before = True
            if is_table(line) and not is_table(lines[i-1]): needs_blank_before = True
            if is_list(line) and not is_list(lines[i-1]): needs_blank_before = True
                
        if needs_blank_before:
            final_lines.append('')
            
        final_lines.append(line)
        
        needs_blank_after = False
        if i+1 < len(lines) and lines[i+1].strip() != '':
            if is_heading(line): needs_blank_after = True
            if is_separator(line): needs_blank_after = True
            if is_table(line) and not is_table(lines[i+1]): needs_blank_after = True
            if is_list(line) and not is_list(lines[i+1]): needs_blank_after = True
                
        if needs_blank_after:
            final_lines.append('')
            
    content = '\n'.join(final_lines)
    
    # 2. Never two --- consecutive
    content = re.sub(r'---\n+---', r'---', content)
    
    # Cleanup empty lines again
    content = re.sub(r'\n{3,}', '\n\n', content)

    with open(fpath, 'w', encoding='utf-8') as f:
        f.write(content.strip() + '\n')

for fpath in files:
    fname = os.path.basename(fpath)
    if fname.startswith('prompt'):
        continue
    format_file(fpath)
    print(f'Formatted: {fname}')
