import React, { useState, useEffect } from 'react';

function EditForm({ current_user, productId }) {
  const [productName, setProductName] = useState('');
  const [productType, setProductType] = useState('');
  const [description, setDescription] = useState('');
  const [price, setPrice] = useState(1);
  const [productStatus, setProductStatus] = useState('Active');

  useEffect(() => {
    // Fetch product data based on productId and update state
    fetch(`/products/${productId}`)
      .then((response) => response.json())
      .then((data) => {
        const { product_name, product_type, description, price, product_status } = data;
        setProductName(product_name);
        setProductType(product_type);
        setDescription(description);
        setPrice(price);
        setProductStatus(product_status);
      })
      .catch((error) => {
        console.error('API Error', error);
      });
  }, [productId]);

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

    fetch(`/products/${productId}/edit`, {
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
    <div className="container mt-4 box">
      <h2>Edit Product</h2>
      <form onSubmit={handleSubmit}>
        <div className="mb-3">
          <label className="form-label">Product Name</label>
          <input
            type="text"
            className="form-control"
            name="product_name"
            value={productName}
            onChange={(e) => setProductName(e.target.value)}
          />
        </div>
        < br/>
        <div className="mb-3">
          <label className="form-label">Product Type</label>
          <select
            className="form-select"
            name="product_type"
            value={productType}
            onChange={(e) => setProductType(e.target.value)}>
            <option value="">Select Type</option>
            <option value="Clothes">Clothes</option>
            <option value="Electronic">Electronic</option>
            <option value="Health Care">Health Care</option>
            <option value="Home Decor">Home Decor</option>
            <option value="Grocery">Grocery</option>
          </select>
        </div>
        < br/>
        <div className="mb-3">
          <label className="form-label">Description</label>
          <textarea
            className="form-control"
            name="description"
            value={description}
            onChange={(e) => setDescription(e.target.value)}
          />
        </div>
        < br/>
        <div className="mb-3">
          <label className="form-label">Price</label>
          <input
            type="number"
            className="form-control"
            name="price"
            value={price}
            onChange={(e) => setPrice(e.target.value)}
          />
        </div>
        < br/>
        <div className="mb-3">
          <label className="form-label">Product Status</label>
          <select
            className="form-select"
            name="product_status"
            value={productStatus}
            onChange={(e) => setProductStatus(e.target.value)}>
            <option value="Active">Active</option>
            <option value="Archived">Archived</option>
          </select>
        </div>
        < br/>
        <div className="mb-3">
          <button type="submit" className="btn btn-success me-2">Update Product</button>
          <button type="button" className="btn btn-danger" onClick={handleCancel}>
            Cancel
          </button>
        </div>
      </form>
    </div>
  );
}

export default EditForm;
