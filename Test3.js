const inputString = process.argv[2];

const splitString = str => str.split(/\s+/);

const filterNumbers = arr => arr.filter(num => /^-?\d+$/.test(num));

const convertToNumbers = arr => arr.map(num => parseInt(num));

const sortAndRemoveDuplicates = arr => {
    const sorted = arr.sort((a, b) => a - b);
    const result = [];
    let lastNum = null;
    for (const num of sorted) {
        if (num !== 0 || num !== lastNum) {
            result.push(num);
            lastNum = num;
        }
    }
    return result;
};

const printSortedNumbers = arr => console.log(arr.join(' '));

const main = inputString => {
    const numbersArray = splitString(inputString);
    const numbers = filterNumbers(numbersArray);
    const numbersToIntegers = convertToNumbers(numbers);
    const sortedNumbers = sortAndRemoveDuplicates(numbersToIntegers);
    printSortedNumbers(sortedNumbers);
};

main(inputString);
