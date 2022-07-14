import { actionTypes } from "../constants/action-types";
import axios from 'axios'

export const setProducts = (products) => {
    return{
            type: actionTypes.SET_PRODUCTS,
            payload: products
        };
};

export const selectedProduct = (product) => {
    return{
            type: actionTypes.SELECTED_PRODUCT,
            payload: product
        };
};

export const deletedProduct = () => {
    return{
            type: actionTypes.DELETE_PRODUCT,
        };
};

export const loadProducts = () => {
    return function (dispatch) {
        axios.get("https://fakestoreapi.com/products")
        .then((res) =>{
            dispatch(setProducts(res.data))
        })
        .catch(err =>{console.log(err);})
    }
}


export const selectProduct = (id) => {
    return function (dispatch) {
        axios.get("https://fakestoreapi.com/products/"+id)
        .then((res) =>{
            dispatch(selectedProduct(res.data))
        })
        .catch(err =>{console.log(err);})
    }
}

export const deleteProduct = (id) => {
    return function (dispatch) {
        axios.delete("https://fakestoreapi.com/products/"+id)
        .then((res) =>{
            console.log(res);
            dispatch(deletedProduct());
            dispatch(loadProducts());
        })
        .catch(err =>{console.log(err);})
    }
}



