Received: from eggs.gnu.org ([2001:4830:134:3::10]:55935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1coBzD-0007hA-LX
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 12:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1coBzA-0008NR-If
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 12:41:19 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:34197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1coBzA-0008NI-A5
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 12:41:16 -0400
Received: by mail-wr0-x22b.google.com with SMTP id l37so14902700wrc.1
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 09:41:15 -0700 (PDT)
References: <20170315142032.6788-1-shorne@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170315142032.6788-1-shorne@gmail.com>
Date: Wed, 15 Mar 2017 16:41:32 +0000
Message-ID: <87a88mpk5f.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] MAINTAINERS: Add myself as openrisc
 maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Stafford Horne <shorne@gmail.com> writes:

> Jia has claimed he is no longer able to maintain.  I have fixing bugs here
> and there and getting familiar with the code base. Orignal thread from Jia:
>
>  https://lists.librecores.org/pipermail/openrisc/2017-January/000321.html
>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
> Changes in v2
>  - fix typo Off/Odd
>
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4714df8..b359089 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -196,8 +196,8 @@ F: hw/nios2/
>  F: disas/nios2.c
>
>  OpenRISC
> -M: Jia Liu <proljc@gmail.com>
> -S: Maintained
> +M: Stafford Horne <shorne@gmail.com>
> +S: Odd Fixes
>  F: target/openrisc/
>  F: hw/openrisc/
>  F: tests/tcg/openrisc/


--
Alex Bennée
