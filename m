Received: from eggs.gnu.org ([2001:4830:134:3::10]:32979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjrpv-0000NG-N1
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:21:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjrpv-0002ny-2B
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:21:51 -0500
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:35060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjrpu-0002np-Ry
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:21:50 -0500
Received: by mail-wr0-x22b.google.com with SMTP id g10so79096795wrg.2
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 10:21:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b71d924c9affac516da84f9eff5668e3a65f1c3c.1488504063.git.balaton@eik.bme.hu>
References: <cover.1488504063.git.balaton@eik.bme.hu>
	<b71d924c9affac516da84f9eff5668e3a65f1c3c.1488504063.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 18:21:29 +0000
Message-ID: <CAFEAcA_s5dM9fdVw_LwCXQmLYgX44su1gi5idyOuVVzUOhVnnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 03/13] sm501: Add missing arbitration
 control register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

On 3 December 2016 at 15:32, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/sm501.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
