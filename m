Received: from eggs.gnu.org ([209.51.188.92]:50343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1gjq1h-0005Ns-Jz
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:34:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1gjq1g-0001jg-Vn
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:34:57 -0500
Received: from mail-it1-f177.google.com ([209.85.166.177]:40386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carpeddiem@gmail.com>)
	id 1gjq1g-0001iJ-QX
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:34:56 -0500
Received: by mail-it1-f177.google.com with SMTP id h193so4089279ita.5
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 10:34:55 -0800 (PST)
MIME-Version: 1.0
References: <20190115184229.73688-1-emaste@freefall.freebsd.org>
	<87bm4gzmwq.fsf@linaro.org>
In-Reply-To: <87bm4gzmwq.fsf@linaro.org>
From: Ed Maste <emaste@freebsd.org>
Date: Wed, 16 Jan 2019 13:34:42 -0500
Message-ID: <CAPyFy2BS3vY6_g8dL3TTNwxUPy7tPwZBrebyyJ2Cm6BaAi-4BQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] .cirrus.yml: basic compile and test for
 FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Wed, 16 Jan 2019 at 09:40, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> While debugging I ended up adding V=3D1 to the two gmake invocations
> because it wasn't quite clear why it had failed last time. With that:
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Does this patch come with an offer to be maintainer for FreeBSD/Cirrus
> CI stuff? In which case it will need a new entry in MAINTAINERS.

OK - I'll send a v2 with V=3D1 added and adding myself (and another
FreeBSD developer who's been adding FreeBSD Cirrus-CI support to a few
projects) to MAINTAINERS.
