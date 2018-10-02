Received: from eggs.gnu.org ([2001:4830:134:3::10]:35526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7Hp7-0000Pp-42
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7Hp5-0000nf-EO
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:22:37 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7Hp5-0000j0-9G
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:22:35 -0400
Received: by mail-oi1-x244.google.com with SMTP id e17-v6so1037278oig.12
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 03:22:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180926192323.12659-6-richard.henderson@linaro.org>
References: <20180926192323.12659-1-richard.henderson@linaro.org>
	<20180926192323.12659-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 11:22:14 +0100
Message-ID: <CAFEAcA-v7=dmKdUmW48tM7zpZmUOv+Ygymr8NjQpbsGsD53r2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 05/15] target/arm: Adjust
 aarch64_cpu_dump_state for system mode SVE
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

On 26 September 2018 at 20:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Use the existing helpers to determine if (1) the fpu is enabled,
> (2) sve state is enabled, and (3) the current sve vector length.
>
> Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
