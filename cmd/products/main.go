package main

import (
	"api-discovery/api"
	"api-discovery/server"
	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()
	api.RegisterAPI(r, server.Server{})
	r.Run()
}
