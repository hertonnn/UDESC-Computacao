#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

// ==========================================
// Vector2D (Implementação de Vetor)
// ==========================================
typedef struct {
    float x;
    float y;
} Vector2D;

Vector2D createVector(float x, float y) {
    Vector2D v = {x, y};
    return v;
}

void vecAdd(Vector2D* v1, Vector2D v2) {
    v1->x += v2.x;
    v1->y += v2.y;
}

Vector2D vecSub(Vector2D v1, Vector2D v2) {
    Vector2D result = {v1.x - v2.x, v1.y - v2.y};
    return result;
}

void vecMult(Vector2D* v, float n) {
    v->x *= n;
    v->y *= n;
}

float vecMagSq(Vector2D v) {
    return v.x * v.x + v.y * v.y;
}

float vecMag(Vector2D v) {
    return sqrtf(vecMagSq(v));
}

void vecSetMag(Vector2D* v, float len) {
    float m = vecMag(*v);
    if (m != 0) {
        v->x = (v->x / m) * len;
        v->y = (v->y / m) * len;
    }
}

void vecNormalize(Vector2D* v) {
    float m = vecMag(*v);
    if (m != 0) {
        v->x /= m;
        v->y /= m;
    }
}

void vecLimit(Vector2D* v, float max) {
    if (vecMagSq(*v) > max * max) {
        vecSetMag(v, max);
    }
}

float vecHeading(Vector2D v) {
    return atan2f(v.y, v.x);
}

// ==========================================
// Vehicle (Esqueleto da "Classe")
// ==========================================
typedef struct {
    Vector2D position;
    Vector2D velocity;
    Vector2D acceleration;
    float r;
    float maxspeed;
    float maxforce;
} Vehicle;

// "Construtor" da classe Vehicle
Vehicle* createVehicle(float x, float y) {
    Vehicle* v = (Vehicle*)malloc(sizeof(Vehicle));
    v->position = createVector(x, y);
    v->velocity = createVector(0, 0);
    v->acceleration = createVector(0, 0);
    v->r = 6.0f;          // Variável adicional para tamanho
    
    // Ajustes na física para o Arrive funcionar perfeitamente em 100 pixels:
    // Se a velocidade for muito alta e a força de freio (maxforce) for muito baixa,
    // ele não tem "freio" suficiente para parar dentro dos 100 pixels e acaba ultrapassando.
    v->maxspeed = 6.0f;   
    v->maxforce = 0.4f;   
    return v;
}

// Função de atualização padrão
void vehicleUpdate(Vehicle* v) {
    vecAdd(&v->velocity, v->acceleration);
    vecLimit(&v->velocity, v->maxspeed);
    vecAdd(&v->position, v->velocity);
    vecMult(&v->acceleration, 0); // Zera a aceleração
}

// Segunda lei de Newton (pulando a matemática)
void vehicleApplyForce(Vehicle* v, Vector2D force) {
    vecAdd(&v->acceleration, force);
}

// Retorna a força de Buscar (Seek) sem aplicá-la diretamente
Vector2D vehicleGetSeekForce(Vehicle* v, Vector2D target) {
    Vector2D desired = vecSub(target, v->position);
    vecSetMag(&desired, v->maxspeed);
    
    Vector2D steer = vecSub(desired, v->velocity);
    vecLimit(&steer, v->maxforce);
    return steer;
}

// O algoritmo de busca clássico (mantido para compatibilidade)
void vehicleSeek(Vehicle* v, Vector2D target) {
    vehicleApplyForce(v, vehicleGetSeekForce(v, target));
}

// Retorna a força de Chegar (Arrive) sem aplicá-la diretamente
Vector2D vehicleGetArriveForce(Vehicle* v, Vector2D target) {
    Vector2D desired = vecSub(target, v->position);
    float d = vecMag(desired);
    
    if (d > 0) {
        float speed = v->maxspeed;
        if (d < 100.0f) {
            speed = v->maxspeed * (d / 100.0f);
        }
        vecSetMag(&desired, speed);
        
        Vector2D steer = vecSub(desired, v->velocity);
        vecLimit(&steer, v->maxforce);
        return steer;
    }
    return createVector(0, 0);
}

// O algoritmo de chegar clássico (mantido para compatibilidade)
void vehicleArrive(Vehicle* v, Vector2D target) {
    vehicleApplyForce(v, vehicleGetArriveForce(v, target));
}

// NOVO: Algoritmo de Separação (Sistemas Complexos / Flocking)
// Calcula uma força de direção (steer) para se afastar dos vizinhos próximos
Vector2D vehicleGetSeparateForce(Vehicle* v, Vehicle** vehicles, int count) {
    float desiredSeparation = v->r * 4.0f; // Distância mínima que devem manter
    Vector2D steer = createVector(0, 0);
    int numClose = 0;
    
    for (int i = 0; i < count; i++) {
        Vehicle* other = vehicles[i];
        if (other == v) continue;
        
        Vector2D diff = vecSub(v->position, other->position);
        float d = vecMag(diff);
        
        if (d > 0 && d < desiredSeparation) {
            // Vetor apontando para longe do vizinho
            vecNormalize(&diff);
            // A força repulsiva é mais forte quanto mais perto estiverem
            vecMult(&diff, 1.0f / d);
            vecAdd(&steer, diff);
            numClose++;
        }
    }
    
    if (numClose > 0) {
        vecMult(&steer, 1.0f / (float)numClose); // Média
    }
    
    // Reynolds: Steering = Desired - Velocity
    if (vecMagSq(steer) > 0) {
        vecSetMag(&steer, v->maxspeed);
        steer = vecSub(steer, v->velocity);
        vecLimit(&steer, v->maxforce);
    }
    return steer;
}

// NOVO: Combinação de comportamentos! (Sistemas Complexos)
// Pondera a força de separar os agentes e a força de buscar um alvo
void vehicleApplyBehaviors(Vehicle* v, Vehicle** vehicles, int count, Vector2D target) {
    Vector2D separateForce = vehicleGetSeparateForce(v, vehicles, count);
    Vector2D seekForce = vehicleGetArriveForce(v, target); // Usando Arrive para parar no alvo
    
    // Pesos baseados no The Nature of Code (Daniel Shiffman)
    // Damos um peso um pouco maior para a separação para que não se amontoem
    vecMult(&separateForce, 1.5f); 
    vecMult(&seekForce, 1.0f);
    
    // Aplica ambas as forças
    vehicleApplyForce(v, separateForce);
    vehicleApplyForce(v, seekForce);
}

// Função de desenho (O veículo é um triângulo que aponta na direção da velocidade)
void vehicleShow(Vehicle* v) {
    float angle = vecHeading(v->velocity);
    
    // Como estamos em C, as funções de desenho como p5.js não são nativas.
    // Aqui você integraria com a biblioteca gráfica que estiver usando (ex: OpenGL/GLUT).
    // O código abaixo é um PSEUDOCÓDIGO representando a mesma lógica do JavaScript.
    
    /*
    // fill(127);
    // stroke(0);
    
    // Equivalente ao push() e matriz de transformação
    glPushMatrix(); 
    glTranslatef(v->position.x, v->position.y, 0.0f);
    glRotatef(angle * (180.0f / M_PI), 0.0f, 0.0f, 1.0f); // Convertendo radianos para graus
    
    // Equivalente ao beginShape() / vertex() / endShape(CLOSE)
    glBegin(GL_TRIANGLES);
    glVertex2f(v->r * 2, 0);
    glVertex2f(-v->r * 2, -v->r);
    glVertex2f(-v->r * 2, v->r);
    glEnd();
    
    glPopMatrix(); // Equivalente ao pop()
    */
}

// Função para liberar a memória alocada
void destroyVehicle(Vehicle* v) {
    if (v != NULL) {
        free(v);
    }
}
