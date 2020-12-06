package pse.ked.controller;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import org.immutables.value.Value;

import java.time.LocalDateTime;

@Value.Immutable
@JsonSerialize(as = ImmutableHello.class)
@JsonDeserialize(as = ImmutableHello.class)
public interface Hello {

    @Value.Default
    default LocalDateTime time() {
        return LocalDateTime.now();
    }
    @Value.Default
    default String title() {
        return "REX/Demo - CI/CD - Promotion d'images docker";
    }

    String message();



}
