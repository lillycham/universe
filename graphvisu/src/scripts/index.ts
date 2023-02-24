import Graph from './graph';
import { getRandomInt } from './lib';

// Instantiate our graph and add connections between nodes
const aGraph = new Graph();

aGraph.addVertices('0', '1', '2', '3', '4', '5', '6', '7', '8', '9');
aGraph.addEdges(['0', '1'], ['1', '2'], ['1', '3'], ['1', '7'], ['3', '4'], ['4', '7'], ['5', '1'], ['6', '9'], ['7', '9'], ['8', '9']);
aGraph.dfs('d', 'a', (g: any, n: any) => console.log(g, n));

type Coords = {
    x: number
    y: number
}

/**
 * Container class abstracting the rendering of graph vertices and edges
 */
class Node {
    coords: Coords;
    contents: string;
    fill: string;
    fg: string;
    font: string;
    counter = 500;
    visited = 0;

    constructor(coords: Coords, contents: any, color: string, font: string, fg: string) {
        this.coords = coords;
        this.contents = contents;
        this.fill = color;
        this.font = font;
        this.fg = fg;
    }

    draw(ctx: CanvasRenderingContext2D, color = this.fill) {
        const { x, y } = this.coords;
        ctx.fillStyle = color;
        ctx.beginPath();
        ctx.arc(x, y, 20, 0, 2 * Math.PI);
        ctx.fill();
        ctx.closePath();
        this.relabel(ctx);
    }

    relabel(ctx: CanvasRenderingContext2D) {
        const { x, y } = this.coords;
        ctx.fillStyle = this.fg;
        ctx.font = this.font;
        ctx.fillText(this.contents, x, y);
        ctx.fillStyle = this.fill;
    }

    connect(ctx: CanvasRenderingContext2D, other: Node) {
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

    redraw(ctx: CanvasRenderingContext2D) {
        const cols = {
            0: 'red',
            1: 'orange',
            2: 'green',
            3: 'blue',
            4: 'indigo',
            5: 'violet',
        };
        const num = this.visited;
        this.draw(ctx, cols[(num as keyof typeof cols)]);
        this.visited += 1;
    }
}

type CanvasProps = {
    width: number
    height: number
    graph: Graph
}

const drawGraphSim = (props: CanvasProps, canvas: HTMLCanvasElement) => {
    let nodes: Node[] = [];
    // Get a context, force unwrap it because if we can't get one then everything is FUBAR anway
    const ctx = canvas.getContext('2d')!;
    // Make it look nicer
    ctx.imageSmoothingEnabled = true;
    ctx.imageSmoothingQuality = 'high';
    // Draw initial canvas BG
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(0, 0, props.width, props.height);
    // Populate the list of graph nodes w/new nodes
    for (const node of props.graph.vertices) {
        const coords = { x: getRandomInt(0, props.height - 150), y: getRandomInt(0, props.height - 150) };
        const gNode = new Node(coords, node, '#ffb6c1', '1.5em monospace', '#ffffff');
        nodes.push(gNode);
    }
    // draw the lines between nodes
    nodes.forEach(node => {
        // Connect adjacent nodes
        nodes.forEach(other => {
            if (new Set(aGraph.adjacents[node.contents]).has(other.contents)) {
                node.connect(ctx, other);
                // Draw the text back on so it doesn't get covered up.
                node.relabel(ctx);
            }
        });
    });
    // draw the lines between nodes
    nodes.forEach(node => {
        node.draw(ctx);
    });
    return nodes;
};
const animateGraphSim = (props: CanvasProps, canvas: HTMLCanvasElement, nodes: Node[], start: string) => {
    const ctx = canvas.getContext('2d')!;
    // Awful hack
    let timeout = 500;
    setTimeout((_: any) => {
        aGraph.dfs(start, start, (_: any, n: string) => {
            console.log(n);
            const node = nodes.filter((node) => node.contents == n)[0];
            setTimeout(() => {
                node?.redraw(ctx);
            }, timeout);
            console.log(node);
            timeout += 500;
        });
    }, 300);
};

let height = 1024;
let width = 1024;

// Get handles to html elements and apply attributes
const canvas = document.getElementById('graph')! as HTMLCanvasElement;
canvas.setAttribute('width', height + '');
canvas.setAttribute('height', width + '');
canvas.replaceWith(canvas);

const button = document.getElementById('render-button')!;
const input = document.getElementById('start-sel')!;

let start = 0;

input.onchange = (ev) => {
    //@ts-ignore
    start = ev.target?.value ?? 0;
};

// Draw the graph and get the node list
const nodes = drawGraphSim({
    graph: aGraph,
    width: width,
    height: height
}, canvas);

// On click, start sim
button.addEventListener('click', (_) => animateGraphSim({
    graph: aGraph,
    width: width,
    height: height
}, canvas, nodes, start + ''));
