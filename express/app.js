const express = require('express');
const app = express();
const cors = require('cors');
const hostname = 'localhost';
const port = 3000;
const { postRouter } = require('./routes/PostRoute');
const { commentRouter } = require('./routes/CommentRoute');
const { userRouter } = require('./routes/UserRoute');
const { articleRouter } = require('./routes/ArticleRoute');

app.use(cors());
app.use(express.json());

app.use('/post', postRouter);
app.use('/comments', commentRouter);
app.use('/user', userRouter);
app.use('/article', articleRouter);

app.listen(port, hostname, () => {
  console.log(`Server is running on ${hostname}:${port}`);
});
