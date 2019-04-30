Received: from eggs.gnu.org ([209.51.188.92]:35716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLRnG-0006S9-DL
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLRnF-0004iC-9e
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:23:30 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLRnE-0004hG-Vi
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:23:29 -0400
Received: by mail-ot1-x342.google.com with SMTP id r20so10548714otg.4
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 05:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190223023957.18865-1-richard.henderson@linaro.org>
	<20190223023957.18865-3-richard.henderson@linaro.org>
In-Reply-To: <20190223023957.18865-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 13:23:16 +0100
Message-ID: <CAFEAcA9C6OU9vE1ST=v7X1u_JvXgX0iBADbqv_Jchj2=xrAnCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/6] target/arm: Define cortex-a73
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Sat, 23 Feb 2019 at 02:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> There are new field definitions, CSV2 and CSV3, that do not yet
> appear in the main ARM ARM.  Define the ID_AA64PF0 versions,

"ID_AA64PFR0"

> since we already define the rest of those bits.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> --

otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
