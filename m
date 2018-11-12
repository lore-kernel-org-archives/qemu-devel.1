Received: from eggs.gnu.org ([2001:4830:134:3::10]:44827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMAYy-0008TV-AS
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:39:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMAYx-0006RN-Fz
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:39:28 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gMAYx-0006Os-7g
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:39:27 -0500
Received: by mail-ot1-x344.google.com with SMTP id 40so7670326oth.4
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 03:39:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181108175246.13416-5-richard.henderson@linaro.org>
References: <20181108175246.13416-1-richard.henderson@linaro.org>
	<20181108175246.13416-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Nov 2018 11:39:06 +0000
Message-ID: <CAFEAcA9LFEkE7YQ9q0DJrWii25VhuL6hodyG+gxYWQRVU-hDhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 4/5] target/arm: Fill in ARMISARegisters
 for kvm32
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

On 8 November 2018 at 17:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/kvm32.c | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
