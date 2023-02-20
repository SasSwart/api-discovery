// GENERATED CODE. DO NOT EDIT

package api

import "github.com/gin-gonic/gin"

type API interface {
	ProductsProducts
}

func RegisterAPI(e gin.IRouter, srv API) {
	RegisterProductsProductsPath(e, srv)
}

type UnimplementedServer struct {
	UnimplementedProductsProducts
}

func (u UnimplementedServer) InvalidRequest(c *gin.Context, err error) {
	c.JSON(400, err.Error())
	c.Abort()
}
