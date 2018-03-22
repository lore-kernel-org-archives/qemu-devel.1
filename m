Received: from eggs.gnu.org ([2001:4830:134:3::10]:55651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ez4rq-0003bM-8n
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ez4rp-0003nT-Fh
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:23:14 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:37821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ez4rp-0003mx-A1
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:23:13 -0400
Received: by mail-ot0-x243.google.com with SMTP id t2-v6so10524310otj.4
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 11:23:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180322181828.9061-1-jcmvbkbc@gmail.com>
References: <20180322181828.9061-1-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Mar 2018 18:22:52 +0000
Message-ID: <CAFEAcA8GfnraecML3Au=UMfC-d4ORqLihD-x4gooKsusXW-5ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] linux-user/xtensa: remove stray syscall.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22 March 2018 at 18:18, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  linux-user/xtensa/syscall.h | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  delete mode 100644 linux-user/xtensa/syscall.h
>
> diff --git a/linux-user/xtensa/syscall.h b/linux-user/xtensa/syscall.h
> deleted file mode 100644
> index e69de29bb2d1..000000000000

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
