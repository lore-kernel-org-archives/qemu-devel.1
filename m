Received: from eggs.gnu.org ([2001:4830:134:3::10]:45745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDnd-0008JY-OM
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:29:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDnZ-00086K-Hq
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:29:45 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:34501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDnZ-00085v-B1
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:29:41 -0400
Received: by mail-wr1-x436.google.com with SMTP id l6-v6so41630016wrt.1
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:29:41 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-35-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <be064998-3e6b-138a-75ab-c48e0f026815@linaro.org>
Date: Sun, 21 Oct 2018 14:29:37 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-35-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 34/56] hppa: convert to
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 10/19/18 2:06 AM, Emilio G. Cota wrote:
> Cc: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/hppa/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
