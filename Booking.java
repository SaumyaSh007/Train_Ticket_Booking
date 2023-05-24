import java.util.Arrays;
import java.util.Scanner;

public class Booking {
    private static final int TOTAL_SEATS = 80;
    private static final int SEATS_IN_ROW = 7;
    private static final int LAST_ROW_SEATS = 3;
    private static boolean[] seats = new boolean[TOTAL_SEATS];

    public static void main(String[] args) {
        Arrays.fill(seats, true); 
        int seatsToBook = 2;
        int[] bookedSeats = bookSeats(seatsToBook);
        if (bookedSeats.length == 0) {
            System.out.println("No seats available.");
        } else {
            System.out.println("Successfully booked seats: " + Arrays.toString(bookedSeats));
        }
    }

    public static int[] bookSeats(int numSeats) {
        if (numSeats < 1 || numSeats > SEATS_IN_ROW) {
            return new int[0]; 
        }

        int startSeat = findAvailableSeatsInRow(numSeats);
        if (startSeat != -1) {
            markSeatsAsBooked(startSeat, numSeats);
            return generateSeatNumbers(startSeat, numSeats);
        }

        startSeat = findAdjacentSeats(numSeats);
        if (startSeat != -1) {
            markSeatsAsBooked(startSeat, numSeats);
            return generateSeatNumbers(startSeat, numSeats);
        }

        return new int[0];
    }

    private static int findAvailableSeatsInRow(int numSeats) {
        int availableSeatsCount = 0;
        for (int i = 0; i < TOTAL_SEATS; i++) {
            if (seats[i]) {
                availableSeatsCount++;
                if (availableSeatsCount == numSeats) {
                    return i - numSeats + 1;
                }
            }
            else {
                availableSeatsCount = 0; 
            }
        }
        return -1;
    }

    private static int findAdjacentSeats(int numSeats) {
        int availableSeatsCount = 0;
        for (int i = 0; i < TOTAL_SEATS; i++) {
            if (seats[i]) {
                availableSeatsCount++;
                if (availableSeatsCount == numSeats) {
                    return i - numSeats + 1; 
                }
            }
            else {
                availableSeatsCount = 0; 
            }
        }
        return -1;
    }

    private static void markSeatsAsBooked(int startSeat, int numSeats) {
        for (int i = startSeat; i < startSeat + numSeats; i++) {
            seats[i] = false;
        }
    }

    private static int[] generateSeatNumbers(int startSeat, int numSeats) {
        int[] seatNumbers = new int[numSeats];
        for (int i = 0; i < numSeats; i++) {
            seatNumbers[i] = startSeat + i + 1; 
        }
        return seatNumbers;
    }
}

