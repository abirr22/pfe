package tn.esprit.spring.kaddem;


import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import tn.esprit.spring.kaddem.entities.Universite;
import tn.esprit.spring.kaddem.repositories.UniversiteRepository;
import tn.esprit.spring.kaddem.services.UniversiteServiceImpl;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;
public class UniversiteServiceImplTest {

    @Mock
    private UniversiteRepository universiteRepository;

    @InjectMocks
    private UniversiteServiceImpl universiteService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testAddUniversite() {
        // Créer une université
        Universite universite = new Universite("Test University");

        // Simuler le comportement du repository
        when(universiteRepository.save(universite)).thenReturn(universite);

        // Appeler la méthode à tester
        Universite result = universiteService.addUniversite(universite);

        // Vérifier le résultat
        assertEquals("Test University", result.getNomUniv());
        verify(universiteRepository, times(1)).save(universite);
    }

    @Test
    public void testRetrieveUniversite() {
        // Créer une université
        Universite universite = new Universite(1, "Test University");

        // Simuler la méthode du repository
        when(universiteRepository.findById(1)).thenReturn(Optional.of(universite));

        // Appeler la méthode à tester
        Universite result = universiteService.retrieveUniversite(1);

        // Vérifier le résultat
        assertNotNull(result);
        assertEquals(1, result.getIdUniv());
        verify(universiteRepository, times(1)).findById(1);
    }

    @Test
    public void testUpdateUniversite() {
        // Créer une université
        Universite universite = new Universite(1, "Old Name");
        Universite updatedUniversite = new Universite(1, "Updated Name");

        // Simuler le comportement du repository
        when(universiteRepository.save(updatedUniversite)).thenReturn(updatedUniversite);

        // Appeler la méthode à tester
        Universite result = universiteService.updateUniversite(updatedUniversite);

        // Vérifier le résultat
        assertEquals("Updated Name", result.getNomUniv());
        verify(universiteRepository, times(1)).save(updatedUniversite);
    }

    @Test
    public void testDeleteUniversite() {
        // Créer une université
        Universite universite = new Universite(1, "Test University");

        // Simuler la méthode du repository
        when(universiteRepository.findById(1)).thenReturn(Optional.of(universite));

        // Appeler la méthode à tester
        universiteService.deleteUniversite(1);

        // Vérifier les interactions
        verify(universiteRepository, times(1)).delete(universite);
    }


}
