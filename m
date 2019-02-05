Received: from eggs.gnu.org ([209.51.188.92]:54711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr65Q-0003ux-4K
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:08:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr65M-0007o8-VF
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:08:46 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr65I-0007mf-Ce
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:08:40 -0500
Received: by mail-ot1-x342.google.com with SMTP id k98so7681381otk.3
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 11:08:37 -0800 (PST)
MIME-Version: 1.0
References: <20190114011122.5995-1-richard.henderson@linaro.org>
	<20190114011122.5995-3-richard.henderson@linaro.org>
In-Reply-To: <20190114011122.5995-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Feb 2019 19:08:23 +0000
Message-ID: <CAFEAcA-yNdB_f4p33tyyC3b4kSpFhqegqu4d+7RGCKdNbSt_og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 02/17] target/arm: Extract TCMA with
 ARMVAParameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Mon, 14 Jan 2019 at 01:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/internals.h | 1 +
>  target/arm/helper.c    | 8 ++++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
