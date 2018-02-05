Received: from eggs.gnu.org ([2001:4830:134:3::10]:44325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eiejU-0001Of-VQ
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 06:14:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eiejU-00053k-6v
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 06:14:44 -0500
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:39147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eiejU-00052Q-0L
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 06:14:44 -0500
Received: by mail-ot0-x229.google.com with SMTP id f18so2491766otf.6
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 03:14:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180126045742.5487-16-richard.henderson@linaro.org>
References: <20180126045742.5487-1-richard.henderson@linaro.org>
	<20180126045742.5487-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Feb 2018 11:14:22 +0000
Message-ID: <CAFEAcA8YMatK-qnikErk_PZaSwrhYdd_cXkM8yOgFQ-b32jOaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v11 15/20] target/arm: Use vector
 infrastructure for aa64 constant shifts
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

On 26 January 2018 at 04:57, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 423 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 350 insertions(+), 73 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
