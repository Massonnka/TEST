class Base {
    getClassname() {
        return this.constructor.name;
    }

    getLetter() {
        throw new Error("Переопределение метода getLetter");
    }
}

class First extends Base {
    getLetter() {
        return "A";
    }
}

class Second extends Base {
    getLetter() {
        return "B";
    }
}

const first = new First();
console.log(first.getClassname()); // "First"
console.log(first.getLetter());    // "A"

const second = new Second();
console.log(second.getClassname()); // "Second"
console.log(second.getLetter());    // "B"