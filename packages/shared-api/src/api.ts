// packages/shared-api/src/api.ts
import axios from 'axios';

// Create an Axios instance pointing to your mock server
const apiClient = axios.create({
  baseURL: 'http://localhost:4000',
});

// Define TypeScript interfaces for our data types
export interface User {
  id: number;
  name: string;
  role: string;
}

export interface Schedule {
  time: string;
  staff: string;
}

// Function to fetch users from the mock API
export const fetchUsers = async (): Promise<User[]> => {
  const response = await apiClient.get<User[]>('/users');
  return response.data;
};

// Function to fetch schedule data from the mock API
export const fetchSchedule = async (): Promise<Schedule[]> => {
  const response = await apiClient.get<Schedule[]>('/schedule');
  return response.data;
};
