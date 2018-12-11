Received: from eggs.gnu.org ([2001:4830:134:3::10]:34440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWlzb-0003CX-R5
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 12:38:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWlza-0001tM-Tk
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 12:38:47 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gWlza-0001sY-Eq
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 12:38:46 -0500
Received: by mail-ot1-x341.google.com with SMTP id w25so14797212otm.13
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 09:38:46 -0800 (PST)
MIME-Version: 1.0
References: <20181210150501.7990-1-richard.henderson@linaro.org>
In-Reply-To: <20181210150501.7990-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Dec 2018 17:38:33 +0000
Message-ID: <CAFEAcA-K+5cR_CA2si8hU3oU6WKdq2eF1x7DEWEVOvP4=x13NA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 0/3] target/arm: ARMv8.1-LOR
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

On Mon, 10 Dec 2018 at 15:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes since v3:
>   * Removed the extra VI/VF/VSE change.
>
> Changes since v2:
>   * Rebased on target-arm.next, which now includes 7 of the 10 patches.
>   * Fixes based on patch review.
>



Applied to target-arm.next, thanks.

-- PMM
