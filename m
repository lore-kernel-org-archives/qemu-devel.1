Received: from eggs.gnu.org ([2001:4830:134:3::10]:45975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDoV-0000cT-P7
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDoR-0008SG-Fk
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:30:39 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:32817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDoR-0008Rr-7G
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:30:35 -0400
Received: by mail-wr1-x42b.google.com with SMTP id u1-v6so6225669wrn.0
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:30:35 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-39-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9fd066cb-933f-30a0-f30d-e0a570695fd6@linaro.org>
Date: Sun, 21 Oct 2018 14:30:31 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-39-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 38/56] nios: convert to
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
Cc: Marek Vasut <marex@denx.de>, Paolo Bonzini <pbonzini@redhat.com>, Chris Wulff <crwulff@gmail.com>

On 10/19/18 2:06 AM, Emilio G. Cota wrote:
> Cc: Chris Wulff <crwulff@gmail.com>
> Cc: Marek Vasut <marex@denx.de>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/nios2/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
