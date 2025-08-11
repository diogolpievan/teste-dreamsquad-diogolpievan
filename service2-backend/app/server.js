const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());

app.get('/', (req, res) => {
  res.send('Hello from Service 2!');
});

app.get('/greet/:name', (req, res) => {
  const name = req.params.name;
  res.send(`Hello, ${name}! Welcome to Service 2.`);
});

app.post('/data', (req, res) => {
  const data = req.body;
  res.json({
    message: 'Data received successfully!',
    receivedData: data
  });
});

app.listen(port, () => {
  console.log(`Service 2 is running`);
});


