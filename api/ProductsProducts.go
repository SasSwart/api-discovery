package api

import (
	"github.com/gin-gonic/gin"
)

// GENERATED INTERFACE. DO NOT EDIT

type ProductsProducts interface {
	ProductsProductsGet(*gin.Context, *ProductsProductsGetParameters, *ProductsProductsGetRequestBody) ProductsProductsGetResponse
	InvalidRequest(*gin.Context, error)
}

type UnimplementedProductsProducts struct{}

func (u UnimplementedProductsProducts) ProductsProductsGet(*gin.Context, *ProductsProductsGetParameters, *ProductsProductsGetRequestBody) ProductsProductsGetResponse {
	return ProductsProductsGet405Response{}
}
func (u UnimplementedProductsProducts) InvalidRequest(c *gin.Context, err error) {
	c.JSON(400, err.Error())
	c.Abort()
}

func RegisterProductsProductsPath(e gin.IRouter, srv ProductsProducts) {

	e.GET("/products", func(c *gin.Context) {
		params := &ProductsProductsGetParameters{}

		if valid, err := params.IsValid(); !valid {
			srv.InvalidRequest(c, err)
			return
		}

		var body *ProductsProductsGetRequestBody

		if valid, err := body.IsValid(); !valid {
			srv.InvalidRequest(c, err)
			return
		}
		response := srv.ProductsProductsGet(c, params, body)
		c.JSON(response.GetStatus(), response)
	})
}

type ProductsProductsGetResponse interface {
	GetStatus() int
}

type ProductsProductsGet200Response ProductsProductsGet200ResponseModel

func (ProductsProductsGet200Response) GetStatus() int {
	return 200
}

type ProductsProductsGet405Response struct{}

func (ProductsProductsGet405Response) GetStatus() int {
	return 405
}
