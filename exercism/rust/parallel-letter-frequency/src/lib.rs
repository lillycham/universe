use std::collections::HashMap;
use std::sync::mpsc;
use std::thread;

pub fn frequency(input: &[&str], worker_count: usize) -> HashMap<char, usize> {
    let no_each = input.len() / worker_count;
    let inputs = input.chunks(no_each);
    let (tx, rx) = mpsc::channel();

    let _x: Vec<_> = inputs
        .into_iter()
        .map(|v| {
            thread::spawn(move || {
                let mut map: HashMap<char, usize> = HashMap::new();
                for inp in v {
                    for c in inp.to_owned().chars() {
                        *map.entry(c).or_default() += 1;
                    }
                }
                tx.send(map).unwrap();
            });
        })
        .collect();

    let mut res: HashMap<char, usize> = HashMap::new();
    while let Ok(msg) = rx.recv() {
        for (k, v) in msg.iter() {
            res.insert(*k, v + if res.contains_key(k) { res[k] } else { 0 });
        }
    }
    res
}
