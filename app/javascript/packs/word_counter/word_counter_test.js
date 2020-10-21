import { letterScore, textScore } from './word_counter.js';

var expect = chai.expect;

describe('letterScore', () => {
  it('lowercase letters', () => {
    expect(letterScore("a")).to.equal(1);
    expect(letterScore("b")).to.equal(2);
    expect(letterScore("j")).to.equal(10);
    expect(letterScore("z")).to.equal(26);
  });

  it('uppercase letters', () => {
    expect(letterScore("A")).to.equal(1);
    expect(letterScore("B")).to.equal(2);
    expect(letterScore("J")).to.equal(10);
    expect(letterScore("Z")).to.equal(26);
  });

  it('numbers', () => {
    expect(letterScore("0")).to.equal(0);
    expect(letterScore("1")).to.equal(1);
    expect(letterScore("2")).to.equal(2);
    expect(letterScore("3")).to.equal(3);
    expect(letterScore("9")).to.equal(9);
  });

  it('ignored', () => {
    expect(letterScore(" ")).to.equal(0);
    expect(letterScore("#")).to.equal(0);
    expect(letterScore("_")).to.equal(0);
    expect(letterScore(".")).to.equal(0);
  });
});

describe('textScore', () => {
  it('calcualate score', () => {
    expect(textScore("Hello World 123!")).to.equal(130);
  });
});
