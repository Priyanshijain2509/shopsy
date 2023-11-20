import React , { useState, useEffect }from "react";
import { useParams } from "react-router-dom";
function CancelOrder(){
	const [status, setStatus] = useState('Cancelled');
  const { user_id: currentUserId, product_id: productId, id: orderId } = useParams();
  const [product, setProduct] = useState(null);

  const handleSubmit = () => {
    if (currentUserId && productId) {
      const csrfToken = document.querySelector('meta[name="csrf-token"]').content;

      fetch(`/products/${productId}`)
        .then((response) => response.json())
        .then((data) => {
          setProduct(data.product);

          const newOrderData = {
						id: orderId,
            buyer: currentUserId,
            seller: data.product.user_id,
            status: status,
            product_id: data.product.id,
          };

          fetch('/orders/cancel', {
            method: 'PUT',
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
            })
            .catch((error) => {
              console.error('Order API Error', error);
            });
        })
        .catch((error) => {
          console.error('Product API Error', error);
        });
    } else {
      console.error('currentUserId or productId is undefined');
    }
  };

  useEffect(() => {
    handleSubmit();
  }, [currentUserId, productId]);

  return (
    <>

    </>
  );
}

export default CancelOrder;