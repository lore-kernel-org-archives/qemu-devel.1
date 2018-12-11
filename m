Received: from eggs.gnu.org ([2001:4830:134:3::10]:33530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWk2I-00070X-Rs
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:33:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWk2H-0005VV-W2
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:33:26 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gWk2H-0005L8-MW
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:33:25 -0500
Received: by mail-oi1-x241.google.com with SMTP id m6so12283100oig.11
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 07:33:22 -0800 (PST)
MIME-Version: 1.0
References: <20181207103631.28193-1-richard.henderson@linaro.org>
	<20181207103631.28193-10-richard.henderson@linaro.org>
In-Reply-To: <20181207103631.28193-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Dec 2018 15:33:10 +0000
Message-ID: <CAFEAcA9bD+fDvvsG--L4hck+XT_-01mBNVu7kD53fM5_ww04tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 09/26] target/arm: Move
 helper_exception_return to helper-a64.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>

On Fri, 7 Dec 2018 at 10:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This function is only used by AArch64.  Code movement only.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
