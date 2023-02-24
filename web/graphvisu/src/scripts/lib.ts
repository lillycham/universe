// Adapted from MDN
/**
 * Returns a random number (which can be a float) between `min` (inclusive) and `max` (exclusive)
 *
 * @param min minimum inclusive number
 * @param max maximum inclusive number
 */
export function getRandomArbitrary(min: number, max: number): number {
    return Math.random() * (max - min) + min;
}

/**
 * Returns a random integer between `min` (inclusive) and `max` (inclusive).
 *
 * The value is no lower than `min` (or the next integer greater than `min`
 * if `min` isn't an integer) and no greater than `max` (or the next integer
 * lower than `max` if `max` isn't an integer).
 *
 * @param min minimum inclusive number
 * @param max maxmimum inclusive number
 * @returns a random number between min and max
 */
export function getRandomInt(min: number, max: number): number {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min + 1)) + min;
}
