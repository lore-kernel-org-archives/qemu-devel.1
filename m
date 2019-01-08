Received: from eggs.gnu.org ([209.51.188.92]:43385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggvuo-0002th-Hi
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 13:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggvum-0008IU-Au
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 13:15:50 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggvuk-0007rY-K3
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 13:15:48 -0500
Received: by mail-oi1-x244.google.com with SMTP id c206so4135588oib.0
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 10:15:38 -0800 (PST)
MIME-Version: 1.0
References: <20190106225035.5671-1-richard.henderson@linaro.org>
	<20190106225035.5671-3-richard.henderson@linaro.org>
In-Reply-To: <20190106225035.5671-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Jan 2019 18:15:25 +0000
Message-ID: <CAFEAcA-E1xW7BnD-zA2XAJ2N4925aOsmBjxf0pEmaWeRizadTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/3] target/arm: Use vector minmax
 expanders for aarch64
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

On Sun, 6 Jan 2019 at 22:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 35 ++++++++++++++---------------------
>  1 file changed, 14 insertions(+), 21 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
