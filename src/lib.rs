pub use wasi::http::types::{
    Fields, IncomingRequest, OutgoingBody, OutgoingResponse, ResponseOutparam,
};

struct Component;
wasi::http::proxy::export!(Component);

impl wasi::exports::http::incoming_handler::Guest for Component {
    fn handle(req: IncomingRequest, outparam: ResponseOutparam) {
        match req.path_with_query().unwrap().as_str() {
            "/wait" => http_wait(req, outparam),
            // "/echo" => {} // TODO
            // "/host" => {} // TODO
            "/" | _ => http_home(req, outparam),
        }
    }
}

fn http_home(_req: IncomingRequest, outparam: ResponseOutparam) {
    let headers = Fields::new();
    let res = OutgoingResponse::new(headers);
    let body = res.body().expect("outgoing response");

    ResponseOutparam::set(outparam, Ok(res));

    let out = body.write().expect("outgoing stream");
    out.blocking_write_and_flush(b"Hello, wasi:http/proxy world!\n")
        .expect("writing response");

    drop(out);
    OutgoingBody::finish(body, None).unwrap();
}

fn http_wait(_req: IncomingRequest, outparam: ResponseOutparam) {
    // Get the time now
    let now = wasi::clocks::monotonic_clock::now();

    // Sleep for 1 second
    let nanos = 1_000_000_000;
    let pollable = wasi::clocks::monotonic_clock::subscribe_duration(nanos);
    pollable.block();

    // Compute how long we slept for.
    let elapsed = wasi::clocks::monotonic_clock::now() - now;
    let elapsed = elapsed / 1_000_000; // change to millis

    let headers = Fields::new();
    let res = OutgoingResponse::new(headers);
    let body = res.body().expect("outgoing response");

    ResponseOutparam::set(outparam, Ok(res));

    let out = body.write().expect("outgoing stream");
    let msg = format!("slept for {elapsed} millis\n");
    out.blocking_write_and_flush(msg.as_bytes())
        .expect("writing response");

    drop(out);
    OutgoingBody::finish(body, None).unwrap();
}
