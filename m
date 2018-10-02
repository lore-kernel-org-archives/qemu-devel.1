Received: from eggs.gnu.org ([2001:4830:134:3::10]:34952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7Hnb-00076H-Jf
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7Hna-0006gh-WD
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:21:03 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7Hna-0006gJ-Qy
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:21:02 -0400
Received: by mail-oi1-x242.google.com with SMTP id e17-v6so1034419oig.12
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 03:21:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180926192323.12659-4-richard.henderson@linaro.org>
References: <20180926192323.12659-1-richard.henderson@linaro.org>
	<20180926192323.12659-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 11:20:41 +0100
Message-ID: <CAFEAcA9De6=fLft1VUD0GiNKDv1L0Vx0jKapOxY9cq09vubPgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 03/15] target/arm: Pass in current_el to
 fp and sve_exception_el
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

On 26 September 2018 at 20:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
> We are going to want to determine whether sve is enabled
> for EL other than current.
>
> Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
