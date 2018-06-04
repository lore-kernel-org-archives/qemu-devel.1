Received: from eggs.gnu.org ([2001:4830:134:3::10]:51100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPtPT-00077n-RP
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 13:36:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPtPT-0007aq-1G
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 13:36:47 -0400
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:39598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fPtPS-0007aE-OB
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 13:36:46 -0400
Received: by mail-oi0-x22c.google.com with SMTP id t22-v6so25743975oih.6
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 10:36:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180530180120.13355-13-richard.henderson@linaro.org>
References: <20180530180120.13355-1-richard.henderson@linaro.org>
	<20180530180120.13355-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Jun 2018 18:36:25 +0100
Message-ID: <CAFEAcA-LSPY-_6SwH-Rx1tcK7DGE0PX0xVYVt_SwtChKuxTKLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3b 12/18] target/arm: Implement SVE
 Integer Compare - Immediate Group
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

On 30 May 2018 at 19:01, Richard Henderson <richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    | 44 +++++++++++++++++++
>  target/arm/sve_helper.c    | 88 ++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 66 ++++++++++++++++++++++++++++
>  target/arm/sve.decode      | 23 ++++++++++
>  4 files changed, 221 insertions(+)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
