import React, { useState } from 'react';

function CreateForm({ current_user }) {
  const [productName, setProductName] = useState('');
  const [productType, setProductType] = useState('');
  const [description, setDescription] = useState('');
  const [price, setPrice] = useState(1);
  const [productStatus, setProductStatus] = useState('Active');

  const handleSubmit = (e) => {
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
    e.preventDefault();
    const newProductData = {
      product_name: productName,
      product_type: productType,
      description: description,
      price: price,
      product_status: productStatus,
    };

    fetch('/products/new', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken,
      },
      body: JSON.stringify(newProductData),
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
        <h2>Create Product</h2>
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
          < br />
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
          < br />
          <div className='mb-3'>
            <label className='form-label'>Description</label>
            <textarea
              className='form-control'
              name='description'
              value={description}
              onChange={(e) => setDescription(e.target.value)}
            />
          </div>
          < br />
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
          < br />
          <div className='mb-3'>
            <label className='form-label'>Product Status</label>
            <select
              className='form-select'
              name='product_status'
              value={productStatus}
              onChange={(e) => setProductStatus(e.target.value)}>
              <option value='Active'>Active</option>
              <option value='Archived'>Archived</option>
            </select>
          </div>
          < br />
          <button type='submit' className='btn btn-success me-2'>Create Product</button>
          <button type='button' className='btn btn-danger' onClick={handleCancel}>
            Cancel
          </button>
          </form>
      </div>
    </>
  );
}

export default CreateForm;
