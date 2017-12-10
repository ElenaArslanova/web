import re


class Escaper:
    escape_tags = {'b', 'i', 'em', 'strong'}
    src_regexp = re.compile(r'src=&quot;([^;]+)&quot;')
    img_regexp = re.compile(r'&lt;\s?img\s+.+&gt;')

    def __init__(self):
        self.styles = {
            'img': 'style="max-height: 400px; max-width: 400px;"'
        }

    def escape(self, string):
        for tag in self.escape_tags:
            string = re.sub('&lt;{}&gt;'.format(tag), '<{}>'.format(tag), string)
            string = re.sub('&lt;/{}&gt;'.format(tag), '</{}>'.format(tag), string)
        return self.escape_image(string.replace('\r\n', '<br>'))

    def escape_image(self, escaped_html):
        image = escaped_html
        for match in self.img_regexp.findall(escaped_html):
            src = self.src_regexp.findall(match)
            if src:
                src = src[0]
                image = image.replace(match, '<img src="{}">'.format(src))
        return image
