Received: from eggs.gnu.org ([209.51.188.92]:55974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1GC-0005th-O5
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:58:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1GA-0003YV-KN
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:58:55 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gm1G8-0003Vo-OC
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:58:52 -0500
Received: by mail-ot1-x343.google.com with SMTP id 81so24684542otj.2
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 10:58:49 -0800 (PST)
MIME-Version: 1.0
References: <20190110124951.15473-1-richard.henderson@linaro.org>
	<20190110124951.15473-3-richard.henderson@linaro.org>
In-Reply-To: <20190110124951.15473-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 15:56:16 +0000
Message-ID: <CAFEAcA-17KYXgoxpyJhm+=tUQ+D=praxhMa=JVw-txfk4-nFGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/4] target/arm: Clean TBI for data
 operations in the translator
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

On Thu, 10 Jan 2019 at 12:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This will allow TBI to be used in user-only mode, as well as
> avoid ping-ponging the softmmu TLB when TBI is in use.  It
> will also enable other armv8 extensions.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
