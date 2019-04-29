Received: from eggs.gnu.org ([209.51.188.92]:35055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6cU-0001tN-Qd
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:47:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6cT-0004lW-Tg
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:46:58 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:33834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL6cT-0004l9-OL
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:46:57 -0400
Received: by mail-ot1-x335.google.com with SMTP id n15so2572383ota.1
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 06:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-8-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 14:46:45 +0100
Message-ID: <CAFEAcA-wkLSXbONYQy33Lq6Tg+2FB=QX-BatCyzQFs+CrK9bzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 07/36] cpu: Introduce env_archcpu
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

On Thu, 28 Mar 2019 at 23:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This will foo_env_get_cpu with a generic definition.

This sentence no verb.

> No changes to the target specific code so far.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
