import type { Locator, Page } from "npm:playwright-core@1.59.1";

export type Helpers = {
  sleep: (ms: number) => Promise<void>;
  v: (selector: string) => Locator;
  field: (label: string) => Locator;
};

export type Clip = (page: Page, helpers: Helpers) => Promise<void>;

export type Config = {
  baseURL?: string;
  viewport?: { width: number; height: number };
  storageState?: string;
  auth?: Clip;
};

export type Flow = {
  config?: Config;
  clips: Record<string, Clip>;
};
