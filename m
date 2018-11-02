Received: from eggs.gnu.org ([2001:4830:134:3::10]:50179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIaX9-0006uH-Ag
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 10:34:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIaX8-0000ui-Af
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 10:34:46 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIaX8-0000qx-05
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 10:34:46 -0400
Received: by mail-oi1-x243.google.com with SMTP id r127-v6so1752891oie.3
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 07:34:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181024113709.16599-6-richard.henderson@linaro.org>
References: <20181024113709.16599-1-richard.henderson@linaro.org>
	<20181024113709.16599-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Nov 2018 14:34:18 +0000
Message-ID: <CAFEAcA8ZVAhW8VBcLMVmREemoyPrmzT3AsiZH5iJLONWKexZCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 5/5] target/arm: Convert t32ee from feature
 bit to isar3 test
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

On 24 October 2018 at 12:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h     | 6 +++++-
>  linux-user/elfload.c | 2 +-
>  target/arm/cpu.c     | 4 ----
>  target/arm/helper.c  | 2 +-
>  target/arm/kvm32.c   | 3 ---
>  target/arm/machine.c | 3 +--
>  6 files changed, 8 insertions(+), 12 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
