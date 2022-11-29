const express = require('express');
const app = express();
const port = 3000;
const hostname = 'localhost';

app.get('/articles', (req, res) => {
  res.send(
    JSON.stringify({
      message: 'success',
      articles: [
        {
          title: 'Article 1',
          description:
            'Sit voluptate duis velit eiusmod culpa eiusmod do dolor est eu anim magna exercitation. Laboris ea fugiat pariatur consequat labore nulla culpa anim officia tempor. Sint nostrud exercitation deserunt ad amet dolore ex tempor in ullamco irure. Minim duis eiusmod irure dolor mollit magna fugiat.',
        },
        {
          title: 'Article 2',
          description:
            'Sit voluptate duis velit eiusmod culpa eiusmod do dolor est eu anim magna exercitation. Laboris ea fugiat pariatur consequat labore nulla culpa anim officia tempor. Sint nostrud exercitation deserunt ad amet dolore ex tempor in ullamco irure. Minim duis eiusmod irure dolor mollit magna fugiat.',
        },
        {
          title: 'Article 3',
          description:
            'Sit voluptate duis velit eiusmod culpa eiusmod do dolor est eu anim magna exercitation. Laboris ea fugiat pariatur consequat labore nulla culpa anim officia tempor. Sint nostrud exercitation deserunt ad amet dolore ex tempor in ullamco irure. Minim duis eiusmod irure dolor mollit magna fugiat.',
        },
      ],
    })
  );
});

app.listen(port, hostname, () => {
  console.log(`Server is running on http://${hostname}:${port}`);
});
