package server

import (
	"api-discovery/api"
	"github.com/gin-gonic/gin"
)

type Server struct{}

func (u Server) ProductsProductsGet(*gin.Context, *api.ProductsProductsGetParameters, *api.ProductsProductsGetRequestBody) api.ProductsProductsGetResponse {
	return api.ProductsProductsGet405Response{}
}
func (u Server) InvalidRequest(c *gin.Context, err error) {
	c.JSON(400, err.Error())
	c.Abort()
}
