import { Converters } from "../elm/Converters/User";

const app = Converters.User.worker();

app.ports.done.subscribe(user => {
  console.log(user.name, user.tags);
});

app.ports.failed.subscribe(error => {
  console.log(error);
});

app.ports.convert.send(`{ "name": "test", "tags": [1, 2, 3] }`);
app.ports.convert.send(`"will fail"`);
