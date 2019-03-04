Received: from eggs.gnu.org ([209.51.188.92]:36767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0rdB-0006wv-JP
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:44:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0rdB-0005vW-0M
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:44:01 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h0rdA-0005uH-OF
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:44:00 -0500
Received: by mail-ot1-x344.google.com with SMTP id z19so4948964otm.2
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 09:43:59 -0800 (PST)
MIME-Version: 1.0
References: <20190301200501.16533-1-richard.henderson@linaro.org>
In-Reply-To: <20190301200501.16533-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2019 17:43:47 +0000
Message-ID: <CAFEAcA815pMquBBvqcBtWC7bkrSCukUYt8nP9ej_A9WEAAS0vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 00/10] target/arm: SB, PredInv, CondM,
 FRINT extensions
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

On Fri, 1 Mar 2019 at 20:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These 5 extensions are small, and all previous editions have
> minor patch conflicts with master.  Therefore, rebase them all
> together for simplicity.
>
>
> r~
>
>



Applied to target-arm.next, thanks.

-- PMM
