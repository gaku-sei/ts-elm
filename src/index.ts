import { Main } from "../elm/Main";

const app = Main.worker();

app.ports.doneConvertUser.subscribe(user => {
  console.log(user.name, user.tags);
});

app.ports.failedConvertUser.subscribe(error => {
  console.log(error);
});

app.ports.convertUser.send(`{ "name": "test", "tags": [1, 2, 3] }`);
app.ports.convertUser.send(`"will fail"`);
