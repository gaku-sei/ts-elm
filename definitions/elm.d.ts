declare module "elm" {
  type BuildPorts<Ports> = {
    [Port in keyof Ports]: {
      send(arg: Ports[Port]): void;
    };
  };

  type BuildSubscriptions<Subscriptions> = {
    [Subscription in keyof Subscriptions]: {
      subscribe(f: (arg: Subscriptions[Subscription]) => void): void;
    };
  };

  interface ElmApplication<Ports, Subscriptions> {
    ports: BuildPorts<Ports> & BuildSubscriptions<Subscriptions>;
  }

  interface ElmModule<Ports, Subscriptions> {
    worker(): ElmApplication<Ports, Subscriptions>;
  }
}
