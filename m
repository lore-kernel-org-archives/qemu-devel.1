Received: from eggs.gnu.org ([2001:4830:134:3::10]:45903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYWSi-0005C5-74
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYWSe-0005i2-66
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:55:48 -0400
Received: from mail-ot0-x22e.google.com ([2607:f8b0:4003:c0f::22e]:38455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYWSd-0005h0-Vb
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:55:44 -0400
Received: by mail-ot0-x22e.google.com with SMTP id w22-v6so6008507otk.5
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 05:55:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180627043328.11531-24-richard.henderson@linaro.org>
References: <20180627043328.11531-1-richard.henderson@linaro.org>
	<20180627043328.11531-24-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Jun 2018 13:55:22 +0100
Message-ID: <CAFEAcA8wC2UCu=iwDrBwb5kkjKcrgD0KP=rzYiyK1hqFmfgP-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 23/35] target/arm: Implement SVE
 floating-point convert precision
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 27 June 2018 at 05:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> ---
> v6: Squish fz16 a-la vfp_fcvt_f16_to_f32
> ---

I hadn't actually reviewed the v5 patch, but I have now :-)

thanks
-- PMM
