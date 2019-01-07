Received: from eggs.gnu.org ([209.51.188.92]:33912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggVz6-0000qk-9K
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:34:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggVz5-0003M4-6w
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:34:32 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggVz4-0003L5-7i
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:34:30 -0500
Received: by mail-ot1-x341.google.com with SMTP id n8so464120otl.6
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 06:34:29 -0800 (PST)
MIME-Version: 1.0
References: <20181214052410.11863-1-richard.henderson@linaro.org>
	<20181214052410.11863-28-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-28-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jan 2019 14:34:17 +0000
Message-ID: <CAFEAcA9d9e6w3MEGN4OzOdx-wFZemqo4HoCu3Kd3Co=yYSWHQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 27/27] target/arm: Tidy TBI handling in
 gen_a64_set_pc
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
> We can perform this with fewer operations.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
