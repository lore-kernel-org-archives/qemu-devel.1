Received: from eggs.gnu.org ([208.118.235.92]:40934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfUfu-0000eo-76
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 13:58:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfUfs-0001Vg-9F
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 13:58:30 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gfUfr-0001Sa-2I
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 13:58:27 -0500
Received: by mail-ot1-x344.google.com with SMTP id k98so32924843otk.3
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 10:58:22 -0800 (PST)
MIME-Version: 1.0
References: <20181214052410.11863-1-richard.henderson@linaro.org>
	<20181214052410.11863-17-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-17-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jan 2019 18:58:10 +0000
Message-ID: <CAFEAcA_6k1NPPa3Y8W9TyWLBCjJj4wVjYYh2UjuMYHsf19koYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 16/27] target/arm: Introduce
 arm_stage1_mmu_idx
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
> While we could expose stage_1_mmu_idx, the combination is
> probably going to be more useful.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
