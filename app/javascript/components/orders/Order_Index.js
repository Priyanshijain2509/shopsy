import React, { useState, useEffect } from 'react';

function Order_Index({ current_user }) {
  const [data, setData] = useState([]);

  useEffect(() => {
    fetch('/orders')
      .then((response) => response.json())
      .then((responseData) => {
        console.log('data', responseData);
        setData(responseData);
      })
      .catch((error) => {
        console.log('error', error);
      });
  }, []);

  console.log('cr', current_user);

  console.log('Data outside useEffect', data);

  return (
    <>
      {current_user && current_user.role === 'seller' ? (
        <>
          <h1>Welcome to Your Dashboard</h1>
          <h2>Your Orders</h2>
          {data && data.length > 0 ? (
            <div className='table-responsive'>
              <table className='table table-striped'>
                <thead>
                  <tr>
                    <th>Product</th>
                    <th>Price</th>
                    <th>Buyer Name</th>
                    <th>Buyer Address</th>
                    <th>Order Id</th>
                    <th>Ordered At</th>
                    <th>Order Status</th>
                  </tr>
                </thead>
                <tbody>
                  {data.map((product) => (
                    <React.Fragment key={product.id}>
                      <tr>
                        <td>{product.product_name}</td>
                        <td>{`${product.price} $`}</td>
                      </tr>
                      {product.orders &&
                          product.orders
                            .filter((order) => order.status === 'Placed')
                            .map((order) => (
                              <tr key={order.id}>
                                <td></td>
                                <td></td>
                                <td>{order.org_buyer.first_name}</td>
                                <td>{order.org_buyer.address}</td>
                                <td>{order.id}</td>
                                <td>{order.created_at}</td>
                                <td>
                                  {order.status === 'Placed' ? (
                                    <span className='btn btn-success'>{order.status}</span>
                                  ) : (
                                    <span className='btn btn-danger'>{order.status}</span>
                                  )}
                                </td>
                              </tr>
                            ))}
                    </React.Fragment>
                  ))}
                </tbody>
              </table>
            </div>
          ) : (
            <p>No products posted yet.</p>
          )}
        </>
      ) : (
        <>
          <h1>Orders</h1>
          {data && data.length === 0 ? (
            <h3>No orders yet.</h3>
          ) : (
            <div className='table-responsive'>
              <table className='table table-striped'>
                <thead>
                  <tr>
                    <th>Product name</th>
                    <th>Product type</th>
                    <th>Price</th>
                    <th>Order Id</th>
                    <th>Ordered At</th>
                    <th>Status</th>
                    <th colSpan='3'></th>
                  </tr>
                </thead>
                <tbody>
                  {data.map((order) => (
                    <tr key={order.id}>
                      <td>{order.product.product_name}</td>
                      <td>{order.product.product_type}</td>
                      <td>{`${order.product.price} $`}</td>
                      <td>{order.id}</td>
                      <td>{order.created_at}</td>
                      <td>
                        {order.status === 'Placed' ? (
                          <span className='btn btn-success'>{order.status}</span>
                        ) : (
                          <span className='btn btn-danger'>{order.status}</span>
                        )}
                      </td>
                      <td></td>
                      <td></td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </>
      )}
    </>
  );
}

export default Order_Index;
