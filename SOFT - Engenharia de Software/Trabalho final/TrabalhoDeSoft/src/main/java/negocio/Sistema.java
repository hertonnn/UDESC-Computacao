/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package negocio;
import dados.*;
import java.util.ArrayList;

/**
 *
 * @author Mariana dos Santos
 */
public class Sistema {
    private ArrayList<Animal> animaisCadastrados;
    private ArrayList<ONG> ongsCadastradas;
    private ArrayList<Usuario> usuariosCadastrados;

    public Sistema() {
        this.animaisCadastrados = new ArrayList<>();
        this.ongsCadastradas = new ArrayList<>();
        this.usuariosCadastrados = new ArrayList<>();
    }

    public ArrayList<Animal> busca(Filtro filtro, String valor){
        ArrayList<Animal> resultados = new ArrayList<>();
        
        switch(filtro){
            case RACA:
                for(Animal animal: animaisCadastrados){
                    if(animal.getRaca().equalsIgnoreCase(valor)){
                        resultados.add(animal);
                    }
                }
                break;
            case PORTE:
                for(Animal animal: animaisCadastrados){
                    if(animal.getPorte().equalsIgnoreCase(valor)){
                        resultados.add(animal);
                    }
                }
                break;
            case SEXO:
                for(Animal animal: animaisCadastrados){
                    if(animal.getSexo().equalsIgnoreCase(valor)){
                        resultados.add(animal);
                    }
                }
                break;
            case IDADE:
                int idade = Integer.parseInt(valor);
                for(Animal animal: animaisCadastrados){
                    if(animal.getIdade() == idade){
                        resultados.add(animal);
                    }
                }
                break;
            case CIDADE:
                for(Animal animal: animaisCadastrados){
                    if(animal.buscaCidade().equalsIgnoreCase(valor)){
                        resultados.add(animal);
                    }
                }
                break;
            case ESTADO:
                for(Animal animal: animaisCadastrados){
                    if(animal.buscaEstado().equalsIgnoreCase(valor)){
                        resultados.add(animal);
                    }
                }
                break;
            case BAIRRO:
                for(Animal animal: animaisCadastrados){
                    if(animal.buscaBairro().equalsIgnoreCase(valor)){
                        resultados.add(animal);
                    }
                }
                break;
            case NECESSIDADESESPECIAIS:
                for (Animal animal : animaisCadastrados) {
                    if (animal.getNecessidadesEspeciais().equalsIgnoreCase(valor)) {
                        resultados.add(animal);
                    }
                }
                break;
            case ONG:
                for (Animal animal : animaisCadastrados) {
                    if (animal.buscaNomeONG().equalsIgnoreCase(valor)) {
                        resultados.add(animal);
                    }
                }
                break;
            case COMPORTAMENTO:
                for (Animal animal : animaisCadastrados) {
                    if (animal.getPersonalide().equalsIgnoreCase(valor)) {
                        resultados.add(animal);
                    }
                }
                break;
            case ESPECIE:
                for (Animal animal : animaisCadastrados) {
                    if (animal.getEspecie().equalsIgnoreCase(valor)) {
                        resultados.add(animal);
                    }
                }
                break;
            default:
                break;
        }
        return resultados;
    }

    public ArrayList<Animal> getAnimaisCadastrados() {
        return animaisCadastrados;
    }

    public void setAnimaisCadastrados(ArrayList<Animal> animaisCadastrados) {
        this.animaisCadastrados = animaisCadastrados;
    }

    public ArrayList<ONG> getOngsCadastradas() {
        return ongsCadastradas;
    }

    public void setOngsCadastradas(ArrayList<ONG> ongsCadastradas) {
        this.ongsCadastradas = ongsCadastradas;
    }

    public ArrayList<Usuario> getUsuariosCadastrados() {
        return usuariosCadastrados;
    }

    public void setUsuariosCadastrados(ArrayList<Usuario> usuariosCadastrados) {
        this.usuariosCadastrados = usuariosCadastrados;
    }
}
