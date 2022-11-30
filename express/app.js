const express = require('express');
const app = express();
const cors = require('cors');
const port = 3000;
const hostname = 'localhost';
const { articles } = require('./articles');
const { postRouter } = require('./routes/PostRoute');
const { commentRouter } = require('./routes/CommentRoute');

app.use(cors());
app.use(express.json());

app.use('/post', postRouter);
app.use('/comments', commentRouter);

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
