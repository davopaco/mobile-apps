import { Router } from "express";

export default interface ExpressRouter {
  router: Router;
  path: string;
  routes: () => void;
}
