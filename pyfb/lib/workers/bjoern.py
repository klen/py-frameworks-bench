import baker
import bjoern
from importlib import import_module


@baker.command(
    default=True,
    shortopts={
        'worker_class': 'k', 'bind': 'b', 'pid': 'p', 'daemon': 'D',
        'workers': 'w'})
def run(app, worker_class=None, bind='127.0.0.1:5000', pid=None, daemon=False,
        workers=1, log_file=None):
    host, port = bind.split(':')
    module_name, app_var = app.split(':')
    try:
        bjoern.run(
            wsgi_app=getattr(import_module(module_name), app_var),
            host=host.strip(),
            port=int(port),
            reuse_port=True)
    except:
        pass


if __name__ == '__main__':
    baker.run()
