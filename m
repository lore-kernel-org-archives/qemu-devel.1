Received: from eggs.gnu.org ([208.118.235.92]:37239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfSuU-0005dT-5p
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:05:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfSuT-0001Vf-9T
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:05:26 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gfSuT-0001To-1M
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:05:25 -0500
Received: by mail-ot1-x343.google.com with SMTP id t5so32689656otk.1
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 09:05:24 -0800 (PST)
MIME-Version: 1.0
References: <20181214052410.11863-1-richard.henderson@linaro.org>
	<20181214052410.11863-12-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jan 2019 17:05:13 +0000
Message-ID: <CAFEAcA-R4P8G0u2KodDyLP5naib7+nnzmmxnUCZB5OYg_WtJSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 11/27] target/arm: Rearrange decode in
 disas_uncond_b_reg
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

On Fri, 14 Dec 2018 at 05:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This will enable PAuth decode in a subsequent patch.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 47 +++++++++++++++++++++++++++++---------
>  1 file changed, 36 insertions(+), 11 deletions(-)




Applied to target-arm.next, thanks.

-- PMM
