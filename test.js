import { expect } from 'chai';
import request from 'supertest';
import express from 'express';

const app = express();
app.get('*', (req, res) => {
  res.send('Hello, World!');
});

describe('GET /', function() {
  it('should return "Hello, World!"', function(done) {
    request(app)
      .get('/')
      .end((err, res) => {
        expect(res.text).to.equal('Hello, World!');
        done();
      });
  });
});
