import 'dart:js_interop';

@JS('__removeMiniQrLoader')
external void _removeMiniQrLoader();

@JS('__removeMiniQrLoader')
external JSAny? get _loaderFn;

/// Fades out and removes the index.html splash. Safe to call once Flutter has
/// painted its first frame; the JS hook guards against double-invocation.
void removeWebLoader() {
  if (_loaderFn != null) _removeMiniQrLoader();
}
