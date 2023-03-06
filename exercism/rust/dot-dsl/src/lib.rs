pub mod graph {
    use std::collections::HashMap;

    use graph_items::{edge::Edge, node::Node};

    pub mod graph_items {
        pub mod node {
            use std::collections::HashMap;

            #[derive(Debug, PartialEq, Eq, Clone)]
            pub struct Node {
                pub content: String,
                pub attrs: HashMap<String, String>,
            }

            impl Node {
                /// Creates a new [`Node`].
                pub fn new(content: &str) -> Self {
                    Node {
                        content: content.to_string(),
                        attrs: HashMap::new(),
                    }
                }

                /// Adds attributes to this [`Node`].
                pub fn with_attrs(&mut self, attrs: &[(&str, &str)]) -> &mut Self {
                    for (key, value) in attrs {
                        self.attrs.insert(key.to_string(), value.to_string());
                    }
                    self
                }
            }
        }

        pub mod edge {
            use std::collections::HashMap;

            #[derive(Debug, Clone, PartialEq, Eq)]
            pub struct Edge {
                pub edge: (String, String),
                pub attrs: HashMap<String, String>,
            }

            impl Edge {
                /// Creates a new [`Edge`].
                pub fn new(edge: (&str, &str)) -> Self {
                    Edge {
                        edge: (edge.0.to_string(), edge.1.to_string()),
                        attrs: HashMap::new(),
                    }
                }
            }
        }
    }

    #[derive(Debug, PartialEq, Eq)]
    pub struct Graph {
        pub nodes: Vec<Node>,
        pub edges: Vec<Edge>,
        pub attrs: HashMap<String, String>,
    }

    impl Graph {
        pub fn new() -> Self {
            Graph {
                nodes: Vec::new(),
                edges: Vec::new(),
                attrs: HashMap::new(),
            }
        }

        pub fn with_attrs(&self, attrs: &[(&str, &str)]) -> &Self {
            for (key, value) in attrs {
                self.attrs.insert(key.to_string(), value.to_string());
            }
            self
        }

        pub fn with_nodes(&mut self, nodes: &[Node]) -> &Self {
            for node in nodes {
                self.attrs
                    .insert(node.content.clone(), node.content.clone());
            }
            self
        }

        /// Returns a reference to the nodes of this [`Graph`].
        pub fn nodes(&self) -> &[Node] {
            self.nodes.as_ref()
        }

        /// Return a node if it is in the graph.
        pub fn node(&self, node: &str) -> Option<Node> {
            self.nodes.iter().find(|n| n.content == node).cloned()
        }
    }

    impl Default for Graph {
        fn default() -> Self {
            Self::new()
        }
    }
}
