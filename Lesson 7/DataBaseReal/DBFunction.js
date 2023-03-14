function createSimpleTable(tx) {
    const sql =
              'CREATE TABLE IF NOT EXISTS contacts (' +
              'contact_id INTEGER PRIMARY KEY,' +
              'first_name TEXT NOT NULL,' +
              'last_name TEXT NOT NULL,' +
              'email TEXT NOT NULL UNIQUE,' +
              'phone TEXT NOT NULL UNIQUE' +
              ');' +
              'CREATE TABLE IF NOT EXISTS contacts1 (' +
              'contact_id INTEGER PRIMARY KEY,' +
              'first_name TEXT NOT NULL,' +
              'last_name TEXT NOT NULL,' +
              'email TEXT NOT NULL UNIQUE,' +
              'phone TEXT NOT NULL UNIQUE' +
              ');'
    tx.executeSql(sql)
}

function addContact(tx, first_name, last_name, email, phone) {
    const sql =
              'INSERT INTO contacts (first_name, last_name, email, phone)' +
              'VALUES("%1", "%2", "%3", "%4");'.arg(first_name).arg(last_name).arg(email).arg(phone) +
              'INSERT INTO contacts1 (first_name, last_name, email, phone)' +
              'VALUES("%1", "%2", "%3", "%4");'.arg(first_name).arg(last_name).arg(email).arg(phone)
    tx.executeSql(sql)
}
