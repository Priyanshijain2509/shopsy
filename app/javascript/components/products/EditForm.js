import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
function EditForm({ current_user}) {
  const [productName, setProductName] = useState('');
  const [productType, setProductType] = useState('');
  const [description, setDescription] = useState('');
  const [price, setPrice] = useState(1);
  const [productStatus, setProductStatus] = useState('');
  const { id } = useParams();

  useEffect(() => {
    console.log('Fetching product with ID:', id);
    fetch(`/products/${id}`)
      .then((response) => response.json())
      .then((data) => {
        console.log('data from Edit Form', data)
        setProductName(data.product.product_name);
        setProductType(data.product.product_type);
        setDescription(data.product.description);
        setPrice(data.product.price);
        setProductStatus(data.product.product_status);
      })
      .catch((error) => {
        console.error('API Error', error);
      });
  }, [id]);

  useEffect(() => {
    console.log('Rendering EditForm with:', productName, productType, description, price, productStatus);
  }, [productName, productType, description, price, productStatus]);

  const handleSubmit = (e) => {
    e.preventDefault();
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
    const updatedProductData = {
      product_name: productName,
      product_type: productType,
      description: description,
      price: price,
      product_status: productStatus,
    };

    fetch(`/products/${id}`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken,
      },
      body: JSON.stringify(updatedProductData),
    })
      .then((response) => response.json())
      .then((data) => {
        console.log('API Response', data);
        window.location.href = '/all_products';
      })
      .catch((error) => {
        console.error('API Error', error);
      });
  };

  const handleCancel = () => {
    window.location.href = '/all_products';
  };

  return (
    <>
    <div className='container mt-4 box'>
      <h2>Edit Product</h2>
      <form onSubmit={handleSubmit}>
        <div className='mb-3'>
          <label className='form-label'>Product Name</label>
          <input
            type='text'
            className='form-control'
            name='product_name'
            value={productName}
            onChange={(e) => setProductName(e.target.value)}
          />
        </div>
        < br/>
        <div className='mb-3'>
          <label className='form-label'>Product Type</label>
          <select
            className='form-select'
            name='product_type'
            value={productType}
            onChange={(e) => setProductType(e.target.value)}>
            <option value=''>Select Type</option>
            <option value='Clothes'>Clothes</option>
            <option value='Electronic'>Electronic</option>
            <option value='Health Care'>Health Care</option>
            <option value='Home Decor'>Home Decor</option>
            <option value='Grocery'>Grocery</option>
          </select>
        </div>
        < br/>
        <div className='mb-3'>
          <label className='form-label'>Description</label>
          <textarea
            className='form-control'
            name='description'
            value={description}
            onChange={(e) => setDescription(e.target.value)}
          />
        </div>
        < br/>
        <div className='mb-3'>
          <label className='form-label'>Price</label>
          <input
            type='number'
            className='form-control'
            name='price'
            value={price}
            onChange={(e) => setPrice(e.target.value)}
          />
        </div>
        < br/>
        <div className='mb-3'>
          <label className='form-label'>Product Status</label>
          <select
            className='form-select'
            name='product_status'
            value={productStatus}
            onChange={(e) => setProductStatus(e.target.value)}>
            <option value=''>Select status</option>
            <option value='Active'>Active</option>
            <option value='Archived'>Archived</option>
            </select>
          </div>
        < br/>
        <div className='mb-3'>
          <button type='submit' className='btn btn-success me-2'>Update Product</button>
          <button type='button' className='btn btn-danger' onClick={handleCancel}>
            Cancel
          </button>
        </div>
      </form>
    </div>
    </>
  );
}

export default EditForm;
