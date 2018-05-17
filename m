Received: from eggs.gnu.org ([2001:4830:134:3::10]:60080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJLVc-0008Om-Od
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJLVb-0008LC-SB
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:12:04 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:40250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJLVb-0008Kl-Nx
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:12:03 -0400
Received: by mail-oi0-x22f.google.com with SMTP id c203-v6so4482879oib.7
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 09:12:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180516223007.10256-8-richard.henderson@linaro.org>
References: <20180516223007.10256-1-richard.henderson@linaro.org>
	<20180516223007.10256-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 May 2018 17:11:42 +0100
Message-ID: <CAFEAcA9GVQxE97rzWDQn0V5yTTcGXdCej9zvxX_wMVOc8PBgCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3-a 07/27] target/arm: Implement SVE
 Predicate Misc Group
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

On 16 May 2018 at 23:29, Richard Henderson <richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h           |   4 +
>  target/arm/helper-sve.h    |   3 +
>  target/arm/sve_helper.c    |  84 +++++++++++++++
>  target/arm/translate-sve.c | 209 +++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  31 ++++++
>  5 files changed, 331 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
