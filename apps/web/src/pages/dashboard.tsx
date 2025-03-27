// apps/web/pages/dashboard.tsx
import React from 'react';
import { useQuery } from 'react-query';
import { fetchUsers, fetchSchedule, User, Schedule } from '../../../../packages/shared-api/src/api';

const Dashboard: React.FC = () => {
  // Fetch users and schedule using React Query
  const { data: users, isLoading: isLoadingUsers, error: usersError } = useQuery<User[]>('users', fetchUsers);
  const { data: schedule, isLoading: isLoadingSchedule, error: scheduleError } = useQuery<Schedule[]>('schedule', fetchSchedule);

  if (isLoadingUsers || isLoadingSchedule) return <p>Loading...</p>;
  if (usersError || scheduleError) return <p>Error loading data.</p>;

  return (
    <div style={{ padding: '20px' }}>
      <h1>Dashboard</h1>
      <div>
        <h2>User List</h2>
        <ul>
          {users?.map(user => (
            <li key={user.id}>{user.name} - {user.role}</li>
          ))}
        </ul>
      </div>
      <div>
        <h2>Schedule</h2>
        <ul>
          {schedule?.map((slot, index) => (
            <li key={index}>{slot.time}: {slot.staff}</li>
          ))}
        </ul>
      </div>
    </div>
  );
};

export default Dashboard;
