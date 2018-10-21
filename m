Received: from eggs.gnu.org ([2001:4830:134:3::10]:39698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDQi-00057Q-5S
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDGN-0002nI-GD
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 08:55:27 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:42570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDGL-0002me-HI
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 08:55:23 -0400
Received: by mail-wr1-x436.google.com with SMTP id f8-v6so2467386wro.9
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 05:55:20 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-10-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ca710406-24de-df61-5cf3-72ade8d436ef@linaro.org>
Date: Sun, 21 Oct 2018 13:55:17 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-10-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 09/56] arm: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On 10/19/18 2:05 AM, Emilio G. Cota wrote:
> Cc: Andrzej Zaborowski <balrogg@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  hw/arm/omap1.c            | 4 ++--
>  hw/arm/pxa2xx_gpio.c      | 2 +-
>  hw/arm/pxa2xx_pic.c       | 2 +-
>  target/arm/arm-powerctl.c | 4 ++--
>  target/arm/cpu.c          | 2 +-
>  target/arm/op_helper.c    | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
