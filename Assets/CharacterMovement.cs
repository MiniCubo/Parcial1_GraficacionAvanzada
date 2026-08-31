using UnityEngine;
using UnityEngine.InputSystem;

[RequireComponent(typeof(Rigidbody))]
public class CharacterMovement : MonoBehaviour
{
    [Header("Movement Settings")]
    [SerializeField] private float walkSpeed = 50f;
    [SerializeField] private float jumpHeight = 5f;
    [SerializeField] private float maxSpeed = 100f;

    [Header("Look Settings")]
    [SerializeField] private float mouseSensitivity = 20f;
    [SerializeField] private float minPitch = -40f;
    [SerializeField] private float maxPitch = 60f;

    [Header("Ground Check")]
    [SerializeField] private float groundCheckDistance = 1.1f;

    private InputSystem_Actions action;
    private Rigidbody rb;

    private float currentPitch = 0f;
    private float currentYaw = 0f;
    private bool isGrounded = true;

    private Vector2 moveInput;
    private Vector2 lookInput;

    private void Awake()
    {
        rb = GetComponent<Rigidbody>();
        rb.interpolation = RigidbodyInterpolation.Interpolate;
        rb.maxLinearVelocity = maxSpeed;

        action = new InputSystem_Actions();
    }

    private void OnEnable()
    {
        action.Player.Enable();
        action.Player.Jump.started += Jump;
    }

    private void OnDisable()
    {
        action.Player.Jump.started -= Jump;
        action.Player.Disable();
    }

    private void Start()
    {
        Cursor.lockState = CursorLockMode.Locked;
        Cursor.visible = false;
    }

    private void Update()
    {
        moveInput = action.Player.Move.ReadValue<Vector2>();
        lookInput = action.Player.Look.ReadValue<Vector2>();

        Ray ray = new Ray(transform.position, Vector3.down);
        isGrounded = Physics.Raycast(ray, groundCheckDistance);
    }

    private void FixedUpdate()
    {
        MoveCharacter();
        RotateCharacter();
    }

    private void MoveCharacter()
    {
        Vector3 fwd = Vector3.ProjectOnPlane(transform.forward, Vector3.up).normalized;
        Vector3 right = Vector3.ProjectOnPlane(transform.right, Vector3.up).normalized;

        Vector3 dir = (fwd * moveInput.y + right * moveInput.x).normalized;

        rb.AddForce(dir * walkSpeed, ForceMode.Force);
    }

    private void RotateCharacter()
    {
        currentYaw += lookInput.x * mouseSensitivity * Time.fixedDeltaTime;
        currentPitch += lookInput.y * mouseSensitivity * Time.fixedDeltaTime;
        currentPitch = Mathf.Clamp(currentPitch, minPitch, maxPitch);

        Quaternion targetRotation = Quaternion.Euler(-currentPitch, currentYaw, 0f);
        rb.MoveRotation(targetRotation);
    }

    public void Jump(InputAction.CallbackContext context)
    {
        if (!isGrounded) return;

        rb.AddForce(Vector3.up * jumpHeight, ForceMode.Impulse);
    }
}