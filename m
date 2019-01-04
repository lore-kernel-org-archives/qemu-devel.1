Received: from eggs.gnu.org ([208.118.235.92]:39072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfT1R-00021C-N5
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:12:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfT1R-0003GK-3R
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:12:37 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gfT1Q-0003G6-UQ
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:12:37 -0500
Received: by mail-ot1-x344.google.com with SMTP id f18so32610774otl.11
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 09:12:36 -0800 (PST)
MIME-Version: 1.0
References: <20181214052410.11863-1-richard.henderson@linaro.org>
	<20181214052410.11863-13-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jan 2019 17:12:24 +0000
Message-ID: <CAFEAcA8C9j+9_dHmJ3Zrg_EH-tU0tDv9JS8X0jQQ3uQn-6kZpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 12/27] target/arm: Decode PAuth within
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 82 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 81 insertions(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
