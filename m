Received: from eggs.gnu.org ([209.51.188.92]:50337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtxqQ-0001oM-Nt
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtxqP-0001kl-J8
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:57:10 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gtxqP-0001jR-CC
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:57:09 -0500
Received: by mail-wr1-x442.google.com with SMTP id c8so3343370wrs.4
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 08:57:09 -0800 (PST)
References: <1550001205-7883-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1550001205-7883-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1550001205-7883-2-git-send-email-aleksandar.markovic@rt-rk.com>
Date: Wed, 13 Feb 2019 16:57:06 +0000
Message-ID: <87ef8biq3h.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/5] tests/tcg: target/mips: Remove an
 unnecessary file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: qemu-devel@nongnu.org, aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com


Aleksandar Markovic <aleksandar.markovic@rt-rk.com> writes:

> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Remove a file that was added long time ago by mistake.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/tcg/mips/mips64-dspr2/.directory | 2 --
>  1 file changed, 2 deletions(-)
>  delete mode 100644 tests/tcg/mips/mips64-dspr2/.directory
>
> diff --git a/tests/tcg/mips/mips64-dspr2/.directory b/tests/tcg/mips/mips=
64-dspr2/.directory
> deleted file mode 100644
> index c75a914..0000000
> --- a/tests/tcg/mips/mips64-dspr2/.directory
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -[Dolphin]
> -Timestamp=3D2012,8,3,16,41,52


--
Alex Benn=C3=A9e
