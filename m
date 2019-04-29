Received: from eggs.gnu.org ([209.51.188.92]:56220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7xJ-0000uN-IX
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7xI-0002ha-J6
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:12:33 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL7xI-0002cF-E4
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:12:32 -0400
Received: by mail-ot1-x342.google.com with SMTP id f23so8895982otl.9
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<155381739615.24.12240723664123883584@76452e4e88f2>
In-Reply-To: <155381739615.24.12240723664123883584@76452e4e88f2>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 16:12:20 +0100
Message-ID: <CAFEAcA9cyZAHj9DRgq6dXsFXGNLKcEOXCndLYTpf9b+EGHnr0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 00/36] tcg: Move the softmmu tlb
 to CPUNegativeOffsetState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Fam Zheng <fam@euphon.net>

On Fri, 29 Mar 2019 at 00:44, <no-reply@patchew.org> wrote:
>
> Patchew URL: https://patchew.org/QEMU/20190328230404.12909-1-richard.henderson@linaro.org/
>
>
>
> Hi,
>
> This series seems to have some coding style problems. See output below for
> more information:

Richard -- at least some of these checkpatch nits look like
they're real rather than false positives: could you have a look
through them and fold in fixes where appropriate?

thanks
-- PMM
