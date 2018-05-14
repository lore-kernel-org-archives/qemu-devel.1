Received: from eggs.gnu.org ([2001:4830:134:3::10]:34200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIFDr-0001mr-Qe
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIFDq-0005FW-T9
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:17:11 -0400
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:38128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIFDq-0005F3-OU
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:17:10 -0400
Received: by mail-oi0-x234.google.com with SMTP id k17-v6so11026374oih.5
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 08:17:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512003217.9105-1-richard.henderson@linaro.org>
References: <20180512003217.9105-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 16:16:49 +0100
Message-ID: <CAFEAcA8aXJsM6OnyJdNX5r73G4Ui9UN+8Nk9O2L-7pG3q_f_Og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 00/11] target/arm: Fixups for
 ARM_FEATURE_V8_FP16
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

On 12 May 2018 at 01:32, Richard Henderson <richard.henderson@linaro.org> wrote:
> Changes since v3:
>   * Fixup rebase vs target-arm.next.  One of the middle
>     patches had conflicts resolved incorrectly, so the
>     patch set was non-bisectable.
>
> Changes since v2:
>   * Rebased vs target-arm.next.
>   * Merged Peter's review.
>   * Split out return fix as a separate patch.
>
> Changes since v1:
>   * Rebased vs master instead of tgt-arm-sve-9.
>   * Alex did some additional digging through the ARM xhtml
>     and came up with some additional missing instructions.
>   * Everything cc'd to qemu-stable.
>
>
> r~
>

Applied all to target-arm.next, thanks.

-- PMM
