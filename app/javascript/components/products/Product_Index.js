import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { useParams } from 'react-router';

function Product_Index() {
  const [products, setProducts] = useState([]);
	const [current_user, setCurrentUser] = useState([]);
	const [editingProduct, setEditingProduct] = useState(null);
	const [status, setStatus] = useState('Placed');
	const [updateStatus, setUpdateStatus] = useState('Cancelled');
	const [product, setProduct] = useState(null);
	let { id } = useParams();

	useEffect(() => {
		fetch('/products')
			.then((response) => response.json())
			.then((data) => {
				const { products, current_user } = data;
				console.log('Products', products);
				console.log('Current User', current_user);
				setProducts(products);
				setCurrentUser(current_user);
			})
			.catch((error) => {
				console.log('error', error);
			});
	}, []);

	useEffect(() => {
		console.log('Editing Product:', editingProduct);
	}, [editingProduct]);

	const handleEdit = (user_id, id) => {
		fetch(`/users/${user_id}/products/${id}/edit`)
			.then((response) => response.json())
			.then((data) => {
				console.log('Data: ', data);
				setEditingProduct((prevEditingProduct) => data);
			})
			.catch((error) => {
				console.error('Error fetching product details for editing', error);
			});
	};

	const handleDelete = (user_id, id) => {
		const csrfToken = document.querySelector('meta[name="csrf-token"]').content;

		fetch(`/users/${user_id}/products/${id}`, {
			method: 'DELETE',
			headers: {
				'Content-Type': 'application/json',
				'X-CSRF-Token': csrfToken,
			},
		})
		.then((response) => response.json())
		.then((data) => {
			setProducts((prevProducts) =>
			prevProducts.filter((product) => product.id !== id)
		);
		  alert(data.message);
	  })
		.catch((error) => {
			console.error('Error deleting product', error);
		});
	};

	const handleOrder = (user_id, id) =>{
		const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
		fetch(`/products/${id}`)
		.then((response) => response.json())
		.then((data) => {
			setProduct(data.product);

	  	const newOrderData = {
			buyer: current_user.id,
			seller: data.product.user_id,
			status: status,
			product_id: data.product.id,
		  };

			fetch(`/users/${user_id}/products/${id}/orders`, {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json',
					'X-CSRF-Token': csrfToken,
				},
				body: JSON.stringify(newOrderData),
			})
			.then((response) => response.json())
            .then((orderData) => {
              console.log('Order API Response', orderData);
							window.location.href = '/all_products';
							alert('Order Placed!');
            })
            .catch((error) => {
              console.error('Order API Error', error);
            });
        })
        .catch((error) => {
          console.error('Product API Error', error);
        });
    }

		const handleCancel = (user_id, productId, id) => {
			const shouldCancel = window.confirm('Do you want to cancel the order?');

			if (shouldCancel) {
				const csrfToken = document.querySelector('meta[name="csrf-token"]').content;

				fetch(`/products/${productId}`)
					.then((response) => response.json())
					.then((data) => {
						setProduct(data.product);

						const updateOrderData = {
							id: id,
							buyer: user_id,
							seller: data.product.user_id,
							status: updateStatus,
							product_id: data.product.id,
						};

						fetch(`/users/${user_id}/products/${productId}/orders/${id}`, {
							method: 'PUT',
							headers: {
								'Content-Type': 'application/json',
								'X-CSRF-Token': csrfToken,
							},
							body: JSON.stringify(updateOrderData),
						})
							.then((response) => response.json())
							.then((orderData) => {
								console.log('Order API Response', orderData);
								window.location.href = '/all_products';
							})
							.catch((error) => {
								console.error('Order API Error', error);
							});
					})
					.catch((error) => {
						console.error('Product API Error', error);
					});
			}
		};

  return (
    <>
			{current_user.role === 'seller' && (
				<div>
					<Link to={ '/order_list' }
					  className='btn btn-primary'>Order list
					</Link>
					<Link
						to={`/users/${current_user.id}/products/new`}
						className='btn btn-primary'>
						New Product
					</Link>
				</div>
			)}
      <h1>All Products</h1>

      {products.length === 0 ? (
        <p>No products posted yet.</p>
      ) : (
        <div>
          <div className='table-responsive'>
            <table className='table table-striped'>
              <thead>
                <tr>
                  <th>Product name</th>
                  <th>Product type</th>
                  <th>Description</th>
                  <th>Price</th>
                  <th>Product status</th>
                  <th colSpan='3'></th>
                </tr>
              </thead>
              <tbody>
								{products.map((product) => {
								  const orders = product.orders;
                  return (
                    <tr key={product.id}>
                      <td>{product.product_name}</td>
                      <td>{product.product_type}</td>
                      <td>{product.description}</td>
                      <td>{product.price} $</td>
											{current_user.role === 'buyer' && (
												<td>
													{product.product_status === 'Archived' ? (
														<p>Out of Stock</p>
													) : (
														orders.some(order => order.buyer === current_user.id
															&& order.status === 'Placed') ? (
															<button className='btn btn-danger'
																onClick={() => handleCancel(
																	current_user.id, product.id, orders.find(
																		order => order.buyer === current_user.id &&
																		order.status === 'Placed').id)}>
																Cancel
															</button>
														) : (
															<button
																className='btn btn-success' onClick={
																	() => handleOrder(current_user.id, product.id)}>
																Order
															</button>
														)
													)}
												</td>
											)}
											{current_user.role === 'admin' &&(
                      <>
                        <td>{product.product_status}</td>
												<td>
													<button className='btn btn-danger' onClick={
														() => handleDelete(product.user_id, product.id)}>
														Delete
													</button>
												</td>
                      </>
											) }
											{current_user.role === 'seller' && (
											<>
                        <td>{product.product_status}</td>
							          <td>
													<Link to={`/all_products/${product.id}/edit`}
													 className='btn btn-info'>Edit</Link>
												</td>
												<td>
													<button className='btn btn-danger' onClick={
														() => handleDelete(product.user_id, product.id)}>
														Delete
													</button>
												</td>
											</>
											)}
										</tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        </div>
      )}
    </>
  );
}

export default Product_Index;
