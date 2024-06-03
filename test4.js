const url = 'https://cors-anywhere.herokuapp.com/https://terrikon.com/football/italy/championship';

fetch(url)
  .then(response => response.text())
  .then(html => {
    const parser = new DOMParser();
    const doc = parser.parseFromString(html, 'text/html');
    
    const rows = doc.querySelectorAll('.goalstat tbody tr');
    
    const table = [];
    table.push('<table><th></th><th>Игрок</th><th>Команда</th><th>Забито</th><th>Игр</th><th>Среднее</th>');

    rows.forEach((row, index) => {
      const cells = row.querySelectorAll('td');
      const player = cells[1].textContent.trim();
      const team = cells[2].textContent.trim();
      const goals = parseInt(cells[3].textContent.trim(), 10);
      const games = parseInt(cells[4].textContent.trim(), 10);
      const average = (goals / games).toFixed(2);
      
      table.push(`<tr><td>${index + 1}.</td><td>${player}</td><td>${team}</td><td>${goals}</td><td>${games}</td><td>${average}</td></tr>`);
    });

    table.push('</table>');
    const result = table.join('');

    document.body.innerHTML = result;
  })
  .catch(err => {
    console.error('Error fetching the data:', err);
  });