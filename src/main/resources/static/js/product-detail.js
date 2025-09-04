document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('addToCartForm');
    const buyBtn = document.getElementById('buyNowBtn');
    if (form) {
        form.addEventListener('submit', async (e) => {
            e.preventDefault();
            const res = await fetch(form.action, { method: 'POST', body: new FormData(form) });
            if (res.ok) {
                if (confirm('장바구니로 이동하시겠습니까?')) {
                    window.location.href = '/cart';
                } else {
                    alert('상품이 장바구니에 담겼습니다.');
                }
            }
        });
    }
    buyBtn?.addEventListener('click', () => {
        const qty = form.querySelector('input[name=quantity]').value;
        const pid = form.querySelector('input[name=productId]').value;
        window.location.href = `/checkout?productId=${pid}&quantity=${qty}`;
    });
});