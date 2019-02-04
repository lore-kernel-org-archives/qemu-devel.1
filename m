Received: from eggs.gnu.org ([209.51.188.92]:39449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqfBN-0005Lr-LD
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:25:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqf1q-0002a3-Cb
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:15:23 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gqf1l-0002Rq-4x
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:15:14 -0500
Received: by mail-ot1-x341.google.com with SMTP id t5so13225otk.1
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 06:15:12 -0800 (PST)
MIME-Version: 1.0
References: <20190204132126.3255-1-richard.henderson@linaro.org>
In-Reply-To: <20190204132126.3255-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Feb 2019 14:14:58 +0000
Message-ID: <CAFEAcA_HG2St1mViKzvNRGFo37BO4gRRM2h7Sb7rE88e8k0xFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/4] target/arm: Implement TBI for
 user-only
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

On Mon, 4 Feb 2019 at 13:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Based-on: <20190204131228.25949-1-richard.henderson@linaro.org>
> aka v3 BTI.
>
> This is a prerequisite to implementing v8.5-MemTag.
>
>
> r~
>



Applied to target-arm.next, thanks.

-- PMM
