/**
 * A structure representing a generic graph.
 *
 * It uses an adjacency list internally.
 *
 * To instantiate, call `new Graph()`
 *
 * Vertices can be added with `.addVtx` or `.addVertices`
 */
export default class Graph {
    vertices: string[];
    adjacents: { [key: string]: string[] };
    edges: number;
    /**
     * Instantiate an empty Graph.
     */
    constructor() {
        this.vertices = [];
        this.adjacents = {};
        this.edges = 0;
    }

    /**
     * add 1 or many vertices to the graph.
     * a vertex is a "node".
     * @param vs - A list of vertices
     */
    addVertices(...vs: string[]) {
        vs.forEach((v) => {
            this.vertices.push(v);
            // @ts-ignore
            this.adjacents[v] = [];
        });
    }

    /**
     * variadic form of addEdge.
     * @param es - An array of pairs, where each pair represents a connection between two vertices.
     */
    addEdges(...es: string[][]) {
        es.forEach((e => {
            const [v, w] = e;
            this.addEdge(v, w);
        }));
    }

    /**
     * connect 2 vertices together.
     *
     * @param v the first vertex
     * @param w the vertex to connect v to
     */
    addEdge(v: string, w: string) {
        this.adjacents[v].push(w);
        this.adjacents[w].push(v);
        this.edges++;
    }

    /**
     * Depth First Search/Traversal.
     *
     * Traverse through a graph, returning `true` if the value `goal` is in the graph.
     *
     * @param goal What we're looking for
     * @param v - the starting node, defaulting to the 0th node in the alist
     * @param fn - the updating function to call, used for visualisation
     * @param visited - Tracks visited nodes, used in recursive calls.
     * @returns A boolean indicating whether `goal` is in the graph
     */
    dfs(goal: string, v = this.vertices[0], fn: ((arg0: this, arg1: string) => void) | null, visited: { [key: string]: boolean } = {}) {
        let adj = this.adjacents;
        visited[v] = true;
        if ((!visited[v] && v !== goal))
            if (fn !== null)
                fn(this, v);
        for (let i = 0; i < (adj[v]?.length ?? 0); i++) {
            let w = adj[v][i];
            if (!visited[w])
                this.dfs(goal, w, fn, visited);
            if (fn !== null)
                fn(this, v);
        }
        return visited[goal] || false;
    }
}
