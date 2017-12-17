interface User {
  name: string;
  tags: number[];
}

interface MainPorts {
  convertUser: string;
}

interface MainSubscriptions {
  doneConvertUser: User;
  failedConvertUser: string;
}

export const Main: ElmModule<MainPorts, MainSubscriptions>;
