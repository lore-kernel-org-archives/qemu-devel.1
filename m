Received: from eggs.gnu.org ([2001:4830:134:3::10]:33727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9pDF-0003Tt-T8
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 06:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9pDF-0007qL-6f
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 06:26:01 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g9pDE-0007pv-QG
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 06:26:01 -0400
Received: by mail-oi1-x242.google.com with SMTP id a203-v6so811840oib.0
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 03:26:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1539080467-2976-1-git-send-email-liq3ea@gmail.com>
References: <1539080467-2976-1-git-send-email-liq3ea@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Oct 2018 11:25:39 +0100
Message-ID: <CAFEAcA9HOhtPbAOrbvRQfrnfcq14WuW+a5w=EXG3+-9t6Wfx5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] memory.h: fix types in comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 9 October 2018 at 11:21, Li Qiang <liq3ea@gmail.com> wrote:
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  include/exec/memory.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks. Contents of patch
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

but the commit message should say "fix typos", not "fix types"
(a 'typo' is a typing mistake; a 'type' is something like "uint32_t".)


thanks
-- PMM
