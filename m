Received: from eggs.gnu.org ([2001:4830:134:3::10]:45782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDnu-000058-1v
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:30:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDnp-0008C3-Q6
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:30:01 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDnp-0008Bu-Iy
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:29:57 -0400
Received: by mail-wm1-x342.google.com with SMTP id r63-v6so7665299wma.4
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:29:57 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-37-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <85cc349e-fd57-813a-9e0b-61d7e4759692@linaro.org>
Date: Sun, 21 Oct 2018 14:29:52 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-37-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 36/56] m68k: convert to
 cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>

On 10/19/18 2:06 AM, Emilio G. Cota wrote:
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/m68k/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
