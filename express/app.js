const express = require('express');
const app = express();
const port = 3000;
const hostname = 'localhost';
const { articles } = require('./articles');

app.get('/articles', (req, res) => {
  res.send(
    JSON.stringify({
      message: 'success',
      articles: articles,
    })
  );
});

app.listen(port, hostname, () => {
  console.log(`Server is running on http://${hostname}:${port}`);
});
