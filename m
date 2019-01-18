Received: from eggs.gnu.org ([209.51.188.92]:49400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkUMI-0006sk-HA
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:38:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkUMH-00038e-VW
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:38:54 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39947)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkUMH-00036T-P8
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:38:53 -0500
Received: by mail-ot1-x342.google.com with SMTP id s5so14371054oth.7
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 05:38:52 -0800 (PST)
MIME-Version: 1.0
References: <20190108223129.5570-1-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 13:38:39 +0000
Message-ID: <CAFEAcA9mYjdsTGLJ87Z95zyi9R07S_z4=2X24yKyWEiPeswx9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 00/31] target/arm: Implement
 ARMv8.3-PAuth
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

On Tue, 8 Jan 2019 at 22:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Lots more little changes since v2, mostly from Peter's review.
> Some changes to ARMVAParameters and TBI incorporated from other
> patch sets that I've been working on.
>
> Not included are patches for linux-user to match the user-level
> code that has gone into kernel mainline.  But this patch set is
> big enough already...
>
>



Applied to target-arm.next (with one or two minor tweaks
for checkpatch nits), thanks.

-- PMM
