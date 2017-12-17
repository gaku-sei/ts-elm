import { ConverterModule } from "elm-converter";

interface User {
  name: string;
  tags: number[];
}

export namespace Converters {
  const User: ConverterModule<User>;
}
