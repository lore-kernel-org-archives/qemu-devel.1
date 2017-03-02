Received: from eggs.gnu.org ([2001:4830:134:3::10]:55546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjWWO-0002Mf-RO
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:36:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjWWN-0003Hu-PX
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:36:16 -0500
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:34996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjWWN-0003HT-Jd
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:36:15 -0500
Received: by mail-wr0-x22e.google.com with SMTP id g10so59906069wrg.2
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 11:36:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <69479ddca0f5d2c68bb5d3d050134aa725e74254.1488068248.git.balaton@eik.bme.hu>
References: <cover.1488068248.git.balaton@eik.bme.hu>
	<69479ddca0f5d2c68bb5d3d050134aa725e74254.1488068248.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 19:35:53 +0000
Message-ID: <CAFEAcA9yy6CJWrYNu+ipJ=Wd3fRt-ra343cWGy4Vu1Yfe2hMgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 09/14] sm501: Misc clean ups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 25 February 2017 at 19:19, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> - Rename a variable
> - Move variable declarations out of loop to the beginning in draw_hwc_line
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/sm501.c          | 10 +++++-----
>  hw/display/sm501_template.h | 10 ++++------
>  2 files changed, 9 insertions(+), 11 deletions(-

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
