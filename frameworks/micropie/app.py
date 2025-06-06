import re
from typing import Dict, List, Optional, Tuple, Any

from MicroPie import App, HttpMiddleware, Request


class ExplicitRouter(HttpMiddleware):
    def __init__(self):
        # Map route paths to (method, regex pattern, handler name)
        self.routes: Dict[str, Tuple[str, str, str]] = {}
    
    def add_route(self, path: str, handler_name: str, method: str = "GET") -> None:
        """
        Register an explicit route with its handler method name and HTTP method.
        
        Args:
            path: The route pattern (e.g., "/api/users/{user}/records/{record}")
            handler_name: The handler method name (e.g., "api")
            method: The HTTP method (e.g., "GET", "POST")
        """
        pattern = re.sub(r"{([^}]+)}", r"([^/]+)", path)
        pattern = f"^{pattern}$"
        self.routes[path] = (method, pattern, handler_name)
    
    async def before_request(self, request: Request) -> Optional[Dict]:
        """
        Match the request path and set path parameters for MicroPie routing.
        
        Args:
            request: The MicroPie Request object
        
        Returns:
            None to let MicroPie handle parsing and routing
        """
        path = request.scope["path"]
        
        for route_path, (method, pattern, handler_name) in self.routes.items():
            if request.method != method:
                continue
            match = re.match(pattern, path)
            if match:
                # Ensure path parameters are strings
                request.path_params = [str(param) for param in match.groups()]
                request._route_handler = handler_name
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
    
    async def _req_ok(self):
        return "ok"

    async def _view_api(self):
        """Check headers for authorization, load JSON/query data and return as JSON."""
        if not self.request.headers.get(b'authorization'):
            return 401, "Error"

        return {
            'params': self.request.path_params,
            'query': self.request.query_params,
            'data': self.request.get_json,
        }
    
    async def html(self):
        """Return HTML content and a custom header."""
        return (
            200,
            '<b>HTML OK</b>', 
            [(b'x-time', f"{time.time()}".encode())]
        )
    
    async def upload(self, file):
        filename = file["filename"]
        return file["saved_path"]

app = MyApp() 
