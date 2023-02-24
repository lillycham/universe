"use strict";
(() => {
  // src/scripts/graph.ts
  var Graph = class {
    vertices;
    adjacents;
    edges;
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
    addVertices(...vs) {
      vs.forEach((v) => {
        this.vertices.push(v);
        this.adjacents[v] = [];
      });
    }
    /**
     * variadic form of addEdge.
     * @param es - An array of pairs, where each pair represents a connection between two vertices.
     */
    addEdges(...es) {
      es.forEach((e) => {
        const [v, w] = e;
        this.addEdge(v, w);
      });
    }
    /**
     * connect 2 vertices together.
     * 
     * @param v the first vertex
     * @param w the vertex to connect v to
     */
    addEdge(v, w) {
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
    dfs(goal, v = this.vertices[0], fn, visited = {}) {
      let adj = this.adjacents;
      visited[v] = true;
      if (!visited[v] && v !== goal) {
        if (fn !== null)
          fn(this, v);
      }
      for (let i = 0; i < (adj[v]?.length ?? 0); i++) {
        let w = adj[v][i];
        if (!visited[w])
          this.dfs(goal, w, fn, visited);
        if (fn !== null)
          fn(this, v);
      }
      return visited[goal] || false;
    }
  };

  // src/scripts/lib.ts
  function getRandomInt(min, max) {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min + 1)) + min;
  }

  // src/scripts/index.ts
  var aGraph = new Graph();
  aGraph.addVertices("0", "1", "2", "3", "4", "5", "6", "7", "8", "9");
  aGraph.addEdges(
    ["0", "1"],
    ["1", "2"],
    ["1", "3"],
    ["1", "7"],
    ["3", "4"],
    ["4", "7"],
    ["5", "1"],
    ["6", "9"],
    ["7", "9"],
    ["8", "9"]
  );
  aGraph.dfs("d", "a", (g, n) => void 0);
  var Node = class {
    coords;
    contents;
    fill;
    fg;
    font;
    counter = 500;
    visited = 0;
    constructor(coords, contents, color, font, fg) {
      this.coords = coords;
      this.contents = contents;
      this.fill = color;
      this.font = font;
      this.fg = fg;
    }
    draw(ctx, color = this.fill) {
      const { x, y } = this.coords;
      ctx.fillStyle = color;
      ctx.beginPath();
      ctx.arc(x, y, 20, 0, 2 * Math.PI);
      ctx.fill();
      ctx.closePath();
      this.relabel(ctx);
    }
    relabel(ctx) {
      const { x, y } = this.coords;
      ctx.fillStyle = this.fg;
      ctx.font = this.font;
      ctx.fillText(this.contents, x, y);
      ctx.fillStyle = this.fill;
    }
    connect(ctx, other) {
      const { x, y } = this.coords;
      const ox = other.coords.x;
      const oy = other.coords.y;
      ctx.fillStyle = this.fill;
      ctx.beginPath();
      ctx.moveTo(x, y);
      ctx.lineTo(ox, oy);
      ctx.lineWidth = 2.5;
      ctx.stroke();
      ctx.closePath();
      this.relabel(ctx);
    }
    redraw(ctx) {
      const cols = {
        0: "red",
        1: "orange",
        2: "green",
        3: "blue",
        4: "indigo",
        5: "violet"
      };
      const num = this.visited > 5 ? 0 : this.visited;
      this.draw(ctx, cols[num]);
      this.visited += 1;
    }
  };
  var drawGraphSim = (props, canvas2) => {
    let nodes2 = [];
    const ctx = canvas2.getContext("2d");
    ctx.imageSmoothingEnabled = true;
    ctx.imageSmoothingQuality = "high";
    ctx.fillStyle = "#ffffff";
    ctx.fillRect(0, 0, props.width, props.height);
    for (const node of props.graph.vertices) {
      const coords = { x: getRandomInt(0, props.height - 150), y: getRandomInt(0, props.height - 150) };
      const gNode = new Node(coords, node, "#ffb6c1", "1.5em monospace", "#ffffff");
      nodes2.push(gNode);
    }
    nodes2.forEach((node) => {
      nodes2.forEach((other) => {
        if (new Set(aGraph.adjacents[node.contents]).has(other.contents)) {
          node.connect(ctx, other);
          node.relabel(ctx);
        }
      });
    });
    nodes2.forEach((node) => {
      node.draw(ctx);
    });
    return nodes2;
  };
  var animateGraphSim = (props, canvas2, nodes2, start2) => {
    const ctx = canvas2.getContext("2d");
    let timeout = 500;
    setTimeout((_) => {
      aGraph.dfs(start2, start2, (_2, n) => {
        const node = nodes2.filter((node2) => node2.contents == n)[0];
        setTimeout(() => {
          node?.redraw(ctx);
        }, timeout);
        timeout += 500;
      });
    }, 300);
  };
  var height = 1024;
  var width = 1024;
  var canvas = document.getElementById("graph");
  canvas.setAttribute("width", height + "");
  canvas.setAttribute("height", width + "");
  canvas.replaceWith(canvas);
  var button = document.getElementById("render-button");
  var input = document.getElementById("start-sel");
  var start = 0;
  input.onchange = (ev) => {
    start = ev.target?.value ?? 0;
  };
  var nodes = drawGraphSim({
    graph: aGraph,
    width,
    height
  }, canvas);
  button.addEventListener(
    "click",
    (_) => animateGraphSim({
      graph: aGraph,
      width,
      height
    }, canvas, nodes, start + "")
  );
})();
