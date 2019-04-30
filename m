Received: from eggs.gnu.org ([209.51.188.92]:56688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLROj-0002Kj-H3
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLRCS-0003Wk-1C
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:45:29 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLRCR-0003WA-Rq
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:45:27 -0400
Received: by mail-ot1-x344.google.com with SMTP id n15so5524225ota.1
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 04:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-9-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 12:45:16 +0100
Message-ID: <CAFEAcA8BFamgiFG6O28trRYMnDNU+bEEuF09rX0TJHdgTAHqHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 08/26] target/lm32: Convert to
 CPUClass::tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Walle <michael@walle.cc>

On Wed, 3 Apr 2019 at 04:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cc: Michael Walle <michael@walle.cc>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
