Received: from eggs.gnu.org ([2001:4830:134:3::10]:39409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3iv-0006xI-Gm
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3ij-0002o0-2c
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:08:24 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:36456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG3ig-0002X2-VW
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:08:15 -0400
Received: by mail-wr1-x430.google.com with SMTP id y16so1718447wrw.3
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 08:07:55 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-32-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3aef74d2-94a7-499c-37ef-a6823a2c4ac6@linaro.org>
Date: Fri, 26 Oct 2018 16:07:52 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-32-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 32/71] exec: use cpu_reset_interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 10/25/18 3:46 PM, Emilio G. Cota wrote:
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  exec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
