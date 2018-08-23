Received: from eggs.gnu.org ([2001:4830:134:3::10]:48062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fss8W-0001fK-3M
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fss8V-0000vq-98
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:07:04 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:36229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fss8V-0000v9-3C
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:07:03 -0400
Received: by mail-oi0-x244.google.com with SMTP id r69-v6so9595978oie.3
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 09:07:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180809042206.15726-15-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
	<20180809042206.15726-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Aug 2018 17:06:42 +0100
Message-ID: <CAFEAcA8z+bhQ_J7yeLGPpMgOebvZC2OB80KubafApFFmfGF5Dg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 14/20] target/arm: Rewrite
 helper_sve_st[1234]*_r
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Desnogues <laurent.desnogues@gmail.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 9 August 2018 at 05:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
> This fixes the endianness problem for softmmu, and does
> move the main loop out of a macro and into an inlined function.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
