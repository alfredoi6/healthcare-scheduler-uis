// mobile/app/(tabs)/dashboard.tsx
import React from 'react';
import { View, Text, FlatList, StyleSheet } from 'react-native';
import { useQuery } from 'react-query';
import { fetchUsers, fetchSchedule, User, Schedule } from 'shared-api/api';

const Dashboard: React.FC = () => {
  const { data: users, isLoading: isLoadingUsers, error: usersError } = useQuery<User[]>('users', fetchUsers);
  const { data: schedule, isLoading: isLoadingSchedule, error: scheduleError } = useQuery<Schedule[]>('schedule', fetchSchedule);

  if (isLoadingUsers || isLoadingSchedule) {
    return <Text>Loading...</Text>;
  }

  if (usersError || scheduleError) {
    return <Text>Error loading data.</Text>;
  }

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Dashboard</Text>

      <Text style={styles.sectionTitle}>User List</Text>
      <FlatList
        data={users}
        keyExtractor={(item) => item.id.toString()}
        renderItem={({ item }) => (
          <Text>{item.name} - {item.role}</Text>
        )}
      />

      <Text style={styles.sectionTitle}>Schedule</Text>
      <FlatList
        data={schedule}
        keyExtractor={(_, index) => index.toString()}
        renderItem={({ item }) => (
          <Text>{item.time}: {item.staff}</Text>
        )}
      />
    </View>
  );
};

export default Dashboard;

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 10,
  },
  sectionTitle: {
    fontSize: 18,
    marginTop: 20,
    marginBottom: 10,
    fontWeight: '600',
  },
});
