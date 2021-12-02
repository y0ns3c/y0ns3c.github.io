#!/usr/bin/env python

from sys import argv

assert len(argv) == 4

arg_template = argv[1]
arg_src = argv[2]
arg_dest = argv[3]

with open(arg_template, encoding="utf-8") as f_template:
    template = f_template.read().splitlines()


head_elems = []
content_elems = []
# Extract head and content elements
with open(arg_src, encoding="utf-8") as f_src:
    tag_section = ''
    for line in f_src:
        line = line.rstrip()
        clean = line.lstrip()

        if clean == "<head>":
            tag_section = "HEAD"
        elif clean == "</head>":
            tag_section = ''
        elif clean == "<div class='page-content'>" or clean == '<div class="page-content">':
            tag_section = "CONTENT"
        else:
            if tag_section == "HEAD":
                head_elems.append(line)
            elif tag_section == "CONTENT":
                content_elems.append(line)

    content_elems.pop()

# Set nav-current
page = arg_src.split('/')[-1]
for index, line in enumerate(template):
    if "nav-button" in line and page in line:
        template[index] = line.replace("nav-button", "nav-current")


with open(arg_dest, "w", encoding="utf-8") as f_dest:
    for line in template:
        clean = line.strip()
        if clean == "# HEAD #":
            f_dest.write('\n'.join(head_elems))
        elif clean == "# CONTENT #":
            f_dest.write('\n'.join(content_elems))
        else:
            f_dest.write(line)

        f_dest.write('\n')
