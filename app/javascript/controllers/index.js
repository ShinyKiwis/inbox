// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import AlertsController from "./alerts_controller"
import AvatarController from "./avatar_controller"
import ApplicationController from "./application_controller"
application.register("alerts", AlertsController)
application.register("avatar", AvatarController)
application.register("application", ApplicationController)
