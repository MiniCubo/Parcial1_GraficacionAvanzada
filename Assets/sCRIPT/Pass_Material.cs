using UnityEngine;
public class Pass_Material : MonoBehaviour
{
    private Renderer modelRenderer;
    public GameManager manager;

    void Start()
    {
        Transform modelTransform = transform.Find("Model");

        modelRenderer = modelTransform.GetComponent<Renderer>();

    }

    private void OnTriggerEnter(Collider other)
    {

        if (other is SphereCollider)
        {
            Renderer objectRenderer = other.GetComponent<Renderer>();

            if (objectRenderer != null && modelRenderer != null)
            {
                modelRenderer.material = objectRenderer.material;
                
            }

            Destroy(other.gameObject);
            manager.restarEsfera();
        }
        
    }
}