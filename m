Received: from eggs.gnu.org ([209.51.188.92]:54114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grngk-0002GB-0S
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:42:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grngi-0003Pw-8V
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:42:12 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1grngi-0003Pe-2a
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:42:12 -0500
Received: by mail-ot1-x341.google.com with SMTP id t5so1274730otk.1
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20190114011122.5995-1-richard.henderson@linaro.org>
	<20190114011122.5995-12-richard.henderson@linaro.org>
In-Reply-To: <20190114011122.5995-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Feb 2019 17:41:59 +0000
Message-ID: <CAFEAcA-YLZc1yqwucsyiPgz_qXLxaLB3pJUG7Jbdwp+fX03POA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 11/17] target/arm: Implement the STGP
 instruction
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

On Mon, 14 Jan 2019 at 01:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

Same remark as for patch 10.

thanks
-- PMM
