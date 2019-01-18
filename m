Received: from eggs.gnu.org ([209.51.188.92]:50021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkT04-0006Zd-1z
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:11:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkT02-0006Eg-B5
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:11:51 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkT02-0005l4-4e
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:11:50 -0500
Received: by mail-oi1-x243.google.com with SMTP id x23so8804067oix.3
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 04:11:34 -0800 (PST)
MIME-Version: 1.0
References: <20190108223129.5570-1-richard.henderson@linaro.org>
	<20190108223129.5570-31-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-31-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 12:11:22 +0000
Message-ID: <CAFEAcA-Lx2VYeP5JL9xhh0Ld1aDGX_ZNe_JcwojLXM+NgexOww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 30/31] target/arm: Enable PAuth for
 user-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, 8 Jan 2019 at 22:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Add 4 attributes that controls the EL1 enable bits, as we may not
> always want to turn on pointer authentication with -cpu max.
> However, by default they are enabled.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
