Received: from eggs.gnu.org ([209.51.188.92]:39760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggTY8-00038W-5L
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:58:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggTY3-00074k-I8
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:58:28 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggTXz-00072V-7K
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:58:24 -0500
Received: by mail-oi1-x241.google.com with SMTP id j21so71143oii.8
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 03:58:20 -0800 (PST)
MIME-Version: 1.0
References: <20181214052410.11863-1-richard.henderson@linaro.org>
	<20181214052410.11863-22-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-22-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jan 2019 11:58:08 +0000
Message-ID: <CAFEAcA_hpK91g7B34YzQvAyXR-p4sT9p8OCLxah_59z9ed8yaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 21/27] target/arm: Implement pauth_auth
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

On Fri, 14 Dec 2018 at 05:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is not really functional yet, because the crypto is not yet
> implemented.  This, however follows the Auth pseudo function.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-a64.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
