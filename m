Received: from eggs.gnu.org ([2001:4830:134:3::10]:46129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDp4-0000zr-5d
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDoz-0000As-UL
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:31:14 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:41372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDoz-0000AZ-GX
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:31:09 -0400
Received: by mail-wr1-x436.google.com with SMTP id q7-v6so14177947wrr.8
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:31:09 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-41-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dcfd7bbe-02fd-1de3-a80b-615b4bb3dff0@linaro.org>
Date: Sun, 21 Oct 2018 14:31:05 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-41-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 40/56] alpha: convert to
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
>  target/alpha/cpu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
