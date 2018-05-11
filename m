Received: from eggs.gnu.org ([2001:4830:134:3::10]:59016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fGzwZ-0001vf-PA
	for qemu-devel@nongnu.org; Fri, 11 May 2018 00:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fGzwZ-0007Hq-5z
	for qemu-devel@nongnu.org; Fri, 11 May 2018 00:46:11 -0400
Received: from mail-yb0-x232.google.com ([2607:f8b0:4002:c09::232]:42075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fGzwZ-0007Hc-1D
	for qemu-devel@nongnu.org; Fri, 11 May 2018 00:46:11 -0400
Received: by mail-yb0-x232.google.com with SMTP id 140-v6so1431961ybc.9
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 21:46:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180511035240.4016-10-richard.henderson@linaro.org>
References: <20180511035240.4016-1-richard.henderson@linaro.org>
	<20180511035240.4016-10-richard.henderson@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 10 May 2018 21:46:09 -0700
Message-ID: <CAMo8Bf+DrwUza6Y=gOmMiR1kaYKgXp9ObYzacN+PiOGFJR0_dg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 9/9] target/xtensa: Honor CPU_DUMP_FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Thu, May 10, 2018 at 8:52 PM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/xtensa/translate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
