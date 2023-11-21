import React, { useEffect, useState } from 'react';

function Index() {
  const [users, setUsers] = useState([]);

  useEffect(() => {
    fetch('/users')
      .then((response) => response.json())
      .then((users) => {
        console.log('users', users);
        setUsers(users);
      })
      .catch((error) => {
        console.log('error', error);
      });
  }, []);

  const handleDelete = (id) => {
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;

    fetch(`/users/${id}`, {
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken,
      },
    })
    .then((response) => response.json())
    .then((data) => {
      setUsers((prevUsers) =>
        prevUsers.filter((user) => user.id !== id)
      );
      alert(data.message);
    })
    .catch((error) => {
      console.error('Error deleting user', error);
    });
  };

  return (
    <div>
      <h1>All Users</h1>
      <table className='table table-striped'>
        <thead>
          <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Role</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          {users.map((user) => (
            <tr key={user.id}>
              <td>{user.first_name}</td>
              <td>{user.last_name}</td>
              <td>{user.role}</td>
              <td>
                <button
                  className='btn btn-danger btn-sm'
                  onClick={() => handleDelete(user.id)} >
                  DELETE
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default Index;
