Received: from eggs.gnu.org ([209.51.188.92]:54662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gqayu-0003MM-Ps
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:56:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gqayt-0002ke-Uh
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:56:00 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gqayt-0002jd-P0
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:55:59 -0500
Received: by mail-wm1-x343.google.com with SMTP id f188so12629293wmf.5
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 01:55:59 -0800 (PST)
References: <20190201173655.4567-1-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190201173655.4567-1-peter.maydell@linaro.org>
Date: Mon, 04 Feb 2019 09:55:57 +0000
Message-ID: <87y36vc1xu.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu-common.h: Update copyright string for
 2019
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org


Peter Maydell <peter.maydell@linaro.org> writes:

> Update the copyright string we use in version/help output,
> since we're well into the new year now.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> Better than last year, where we didn't get round to doing
> the year bump until September :-)
> ---
>  include/qemu-common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index ed60ba251d8..a1022455199 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -17,7 +17,7 @@
>  #define TFR(expr) do { if ((expr) !=3D -1) break; } while (errno =3D=3D =
EINTR)
>=20=20
>  /* Copyright string for -version arguments, About dialogs, etc */
> -#define QEMU_COPYRIGHT "Copyright (c) 2003-2018 " \
> +#define QEMU_COPYRIGHT "Copyright (c) 2003-2019 " \
>      "Fabrice Bellard and the QEMU Project developers"
>=20=20
>  /* Bug reporting information for --help arguments, About dialogs, etc */


--=20
Alex Benn=C3=A9e
