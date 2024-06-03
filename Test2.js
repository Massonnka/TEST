const inputString = `***/Test/files/1.xls, ***/Test/files/2.XLSX, ***/Test/filest/9.vra, ***/Test/files/3.jpg, ***/Test/files/4.xml, ***/TEST/files/5.png, ***/Test/files/6.xlsm, ***/Test/files/7.xlso, ***/Test/files/8.xls*, ***/Test/files/9.xlasx, ***/Test/files/9.vba`;

const excelRegex = /\.xls[xm]?$/i;

const filePaths = inputString.split(", ");

const excelFiles = filePaths.filter(path => excelRegex.test(path));

console.log(excelFiles.join(", "));