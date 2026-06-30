#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

// ==========================================
// Vector3D (Implementação de Vetor 3D)
// ==========================================
typedef struct {
    float x;
    float y;
    float z;
} Vector3D;

Vector3D createVector3D(float x, float y, float z) {
    Vector3D v = {x, y, z};
    return v;
}

void vecAdd(Vector3D* v1, Vector3D v2) {
    v1->x += v2.x;
    v1->y += v2.y;
    v1->z += v2.z;
}

Vector3D vecSub(Vector3D v1, Vector3D v2) {
    Vector3D result = {v1.x - v2.x, v1.y - v2.y, v1.z - v2.z};
    return result;
}

void vecMult(Vector3D* v, float n) {
    v->x *= n;
    v->y *= n;
    v->z *= n;
}

float vecMagSq(Vector3D v) {
    return v.x * v.x + v.y * v.y + v.z * v.z;
}

float vecMag(Vector3D v) {
    return sqrtf(vecMagSq(v));
}

void vecSetMag(Vector3D* v, float len) {
    float m = vecMag(*v);
    if (m != 0) {
        v->x = (v->x / m) * len;
        v->y = (v->y / m) * len;
        v->z = (v->z / m) * len;
    }
}

void vecLimit(Vector3D* v, float max) {
    if (vecMagSq(*v) > max * max) {
        vecSetMag(v, max);
    }
}

void vecNormalize(Vector3D* v) {
    float m = vecMag(*v);
    if (m != 0) {
        v->x /= m;
        v->y /= m;
        v->z /= m;
    }
}

// Produto Vetorial (Cross Product) - Necessário para achar o eixo de rotação 3D
Vector3D vecCross(Vector3D v1, Vector3D v2) {
    Vector3D result;
    result.x = v1.y * v2.z - v1.z * v2.y;
    result.y = v1.z * v2.x - v1.x * v2.z;
    result.z = v1.x * v2.y - v1.y * v2.x;
    return result;
}

// ==========================================
// Vehicle (Classe 3D)
// ==========================================
typedef struct {
    Vector3D position;
    Vector3D velocity;
    Vector3D acceleration;
    float r;
    float maxspeed;
    float maxforce;
} Vehicle;

Vehicle* createVehicle(float x, float y, float z) {
    Vehicle* v = (Vehicle*)malloc(sizeof(Vehicle));
    v->position = createVector3D(x, y, z);
    v->velocity = createVector3D(0, 0, 0);
    v->acceleration = createVector3D(0, 0, 0);
    v->r = 10.0f;          // Um pouco maior para ficar visível em 3D
    v->maxspeed = 6.0f;   
    v->maxforce = 0.4f;   
    return v;
}

void vehicleUpdate(Vehicle* v) {
    vecAdd(&v->velocity, v->acceleration);
    vecLimit(&v->velocity, v->maxspeed);
    vecAdd(&v->position, v->velocity);
    vecMult(&v->acceleration, 0); 
}

void vehicleApplyForce(Vehicle* v, Vector3D force) {
    vecAdd(&v->acceleration, force);
}

void vehicleSeek(Vehicle* v, Vector3D target) {
    Vector3D desired = vecSub(target, v->position);
    vecSetMag(&desired, v->maxspeed);
    
    Vector3D steer = vecSub(desired, v->velocity);
    vecLimit(&steer, v->maxforce);
    
    vehicleApplyForce(v, steer);
}

void vehicleArrive(Vehicle* v, Vector3D target) {
    Vector3D desired = vecSub(target, v->position);
    float d = vecMag(desired);
    
    if (d > 0) {
        float speed = v->maxspeed;
        
        // Raio de freio em 3D (esfera de 100 unidades)
        if (d < 100.0f) {
            speed = v->maxspeed * (d / 100.0f);
        }
        
        vecSetMag(&desired, speed);
        
        Vector3D steer = vecSub(desired, v->velocity);
        vecLimit(&steer, v->maxforce);
        
        vehicleApplyForce(v, steer);
    }
}

void destroyVehicle(Vehicle* v) {
    if (v != NULL) {
        free(v);
    }
}
