const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
const firestore = admin.firestore();

// Function to increment the task count when a new task is created
exports.incrementTaskCount = functions.firestore
    .document('users_collection/{userId}/task_collection/{taskId}')
    .onCreate(async (snapshot, context) => {
        const userId = context.params.userId;
        const userRef = firestore.collection('users_collection').doc(userId);

        try {
            // Increment the task count by 1
            await userRef.update({
                taskCount: admin.firestore.FieldValue.increment(1)
            });

            console.log(`Task count incremented for user: ${userId}`);
        } catch (error) {
            console.error("Error updating task count:", error);
        }
    });

// Function to decrement the task count when a task is deleted
exports.decrementTaskCount = functions.firestore
    .document('users_collection/{userId}/task_collection/{taskId}')
    .onDelete(async (snapshot, context) => {
        const userId = context.params.userId;
        const userRef = firestore.collection('users_collection').doc(userId);

        try {
            // Decrement the task count by 1
            await userRef.update({
                taskCount: admin.firestore.FieldValue.increment(-1)
            });

            console.log(`Task count decremented for user: ${userId}`);
        } catch (error) {
            console.error("Error updating task count:", error);
        }
    });
