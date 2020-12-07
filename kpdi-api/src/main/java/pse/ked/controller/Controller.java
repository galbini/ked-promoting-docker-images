package pse.ked.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Controller {

    @GetMapping("/hello")
    public ResponseEntity<Hello> version() {
        return new ResponseEntity<>(
                ImmutableHello.builder()
                        .message("Bonjour KED!")
                        .build(),
                HttpStatus.OK);
    }
}
