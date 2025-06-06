import re
import time
from typing import Dict, List, Optional, Tuple, Any

from MicroPie import App, HttpMiddleware, Request


class ExplicitRouter(HttpMiddleware):
    def __init__(self):
        # Map route paths to (method, regex pattern, handler name, param names)
        self.routes: Dict[str, Tuple[str, str, str, List[str]]] = {}
    
    def add_route(self, path: str, handler_name: str, method: str = "GET") -> None:
        """
        Register an explicit route with its handler method name and HTTP method.
        
        Args:
            path: The route pattern (e.g., "/api/users/{user}/records/{record}")
            handler_name: The handler method name (e.g., "api")
            method: The HTTP method (e.g., "GET", "POST")
        """
        # Extract parameter names from the path (e.g., ["user", "record"])
        param_names = re.findall(r"{([^}]+)}", path)
        pattern = re.sub(r"{([^}]+)}", r"([^/]+)", path)
        pattern = f"^{pattern}$"
        self.routes[path] = (method, pattern, handler_name, param_names)
    
    async def before_request(self, request: Request) -> Optional[Dict]:
        """
        Match the request path and set path parameters for MicroPie routing.
        
        Args:
            request: The MicroPie Request object
        
        Returns:
            None to let MicroPie handle parsing and routing, or a dict to short-circuit
        """
        path = request.scope["path"]
        
        for route_path, (method, pattern, handler_name, param_names) in self.routes.items():
            if request.method != method:
                if re.match(pattern, path):
                    return {"status_code": 405, "body": "405 Method Not Allowed"}
                continue
            match = re.match(pattern, path)
            if match:
                # Set path_params as a list of strings
                request.path_params = [str(param) for param in match.groups()]
                request._route_handler = handler_name
                # Store param_names for use in _view_api
                if handler_name == "_view_api":
                    request._param_names = param_names
                return None
        
        return None
    
    async def after_request(
        self,
        request: Request,
        status_code: int,
        response_body: Any,
        extra_headers: List[Tuple[str, str]]
    ) -> Optional[Dict]:
        return None


class MyApp(App):
    def __init__(self):
        super().__init__()
        self.router = ExplicitRouter()
        self.middlewares.append(self.router)
        # Register explicit routes
        for n in range(5):
            self.router.add_route(f"/route-{n}", "_req_ok", "GET")
            self.router.add_route(f"/route-dyn-{n}/" + "{part}", "_req_ok", "GET")
        self.router.add_route("/api/users/{user}/records/{record}", "_view_api", "PUT")
        self.router.add_route("/upload", "upload", "POST")
    
    async def _req_ok(self):
        return "ok"

    async def _view_api(self):
        """Check headers for authorization, load JSON/query data and return as JSON."""
        if not self.request.headers.get('authorization'):
            return 401, "Error"

        # Convert path_params to dict with integer values using param_names
        param_names = getattr(self.request, '_param_names', [])
        params = {name: int(param) for name, param in zip(param_names, self.request.path_params)}

        return {
            'params': params,
            'query': self.request.query_params,
            'data': self.request.get_json,
        }
    
    async def html(self):
        """Return HTML content and a custom header."""
        return (
            200,
            b'<b>HTML OK</b>', 
            [('x-time', str(time.time()))]
        )
    
    async def upload(self, file):
        """Handle file upload and return the saved file path with text/plain content type."""
        filename = file["filename"]
        return (
            200,
            file["saved_path"],
            [("Content-Type", "text/plain")]
        )

app = MyApp()
