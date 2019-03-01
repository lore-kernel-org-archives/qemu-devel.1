Received: from eggs.gnu.org ([209.51.188.92]:40535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzlRB-0007Vs-Fw
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:55:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzlRA-0004IO-Jx
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:55:05 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gzlRA-0004Hm-BX
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:55:04 -0500
Received: by mail-wr1-x444.google.com with SMTP id d17so26563024wre.10
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 08:55:04 -0800 (PST)
References: <20190301163518.20702-1-stefanha@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190301163518.20702-1-stefanha@redhat.com>
Date: Fri, 01 Mar 2019 16:55:02 +0000
Message-ID: <87r2bqk00p.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: add missing support status
 fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, thuth@redhat.com


Stefan Hajnoczi <stefanha@redhat.com> writes:

> This patch adds the "S:" line for areas of the codebase that currently
> lack a support status field.
>
> Note that there are a few more areas that are more abstract and do not
> correspond to a specific set of files.  They have not been modified.
>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d941cb3862..2464f51879 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -338,6 +338,7 @@ F: include/hw/tricore/
>
>  Multiarch Linux User Tests
>  M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> +S: Maintained
>  F: tests/tcg/multiarch/
>
>  Guest CPU Cores (KVM):
> @@ -2094,6 +2095,7 @@ F: qemu.sasl
>  Coroutines
>  M: Stefan Hajnoczi <stefanha@redhat.com>
>  M: Kevin Wolf <kwolf@redhat.com>
> +S: Maintained
>  F: util/*coroutine*
>  F: include/qemu/coroutine*
>  F: tests/test-coroutine.c
> @@ -2528,6 +2530,7 @@ F: .gitlab-ci.yml
>  Guest Test Compilation Support
>  M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>  R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> +S: Maintained
>  F: tests/tcg/Makefile
>  F: tests/tcg/Makefile.include
>  L: qemu-devel@nongnu.org


--
Alex Benn=C3=A9e
