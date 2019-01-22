Received: from eggs.gnu.org ([209.51.188.92]:60823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm2Pg-0000z9-PM
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:12:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm2Pf-0008D4-QC
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:12:48 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gm2Pf-00085u-Ez
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:12:47 -0500
Received: by mail-oi1-x243.google.com with SMTP id c206so18573737oib.0
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 12:12:37 -0800 (PST)
MIME-Version: 1.0
References: <20190110121736.23448-1-richard.henderson@linaro.org>
	<20190110121736.23448-4-richard.henderson@linaro.org>
In-Reply-To: <20190110121736.23448-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 12:57:23 +0000
Message-ID: <CAFEAcA8bR9=CM1zPwe9LLZ0BQf-TokChM8_xb3NXgOGFhagLaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 03/11] target/arm: Add BT and BTYPE to
 tb->flags
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

On Thu, 10 Jan 2019 at 12:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h           |  2 ++
>  target/arm/translate.h     |  4 ++++
>  target/arm/helper.c        | 22 +++++++++++++++-------
>  target/arm/translate-a64.c |  2 ++
>  4 files changed, 23 insertions(+), 7 deletions(-


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
