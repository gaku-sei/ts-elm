declare module "elm-converter" {
  import { ElmModule } from "elm";

  interface ConverterPorts {
    convert: string;
  }

  interface ConverterSubscriptions<T> {
    done: T;
    failed: string;
  }

  type ConverterModule<T> = ElmModule<ConverterPorts, ConverterSubscriptions<T>>;
}
