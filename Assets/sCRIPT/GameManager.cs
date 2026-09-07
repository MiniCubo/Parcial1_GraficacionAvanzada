using UnityEngine;

public class GameManager : MonoBehaviour
{   
    private int esferas;
    public GameObject player;
    private GameObject[] listaEsferas;
    public Canvas canva; 

    void Start()
    {
        listaEsferas = GameObject.FindGameObjectsWithTag("esfera");
        esferas = listaEsferas.Length;
    }

    void Update()
    {
        
    }

    void ganar()
    {
        CharacterMovement characterController = player.GetComponent<CharacterMovement>();
        Cursor.visible = true;
        Cursor.lockState = CursorLockMode.None;
        
        if (characterController != null)
        {
            characterController.enabled = false;
        }

        if (canva != null)
        {
            canva.gameObject.SetActive(true);
        }
    }

    public void restarEsfera()
    {
        esferas--;
        if (esferas <= 0)
        {
            ganar();
        }
    }
}