Received: from eggs.gnu.org ([2001:4830:134:3::10]:32821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjrpU-0008WV-5X
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:21:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjrpT-0002fl-72
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:21:24 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjrpS-0002fQ-Vy
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:21:23 -0500
Received: by mail-wm0-x232.google.com with SMTP id v186so21667694wmd.0
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 10:21:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0d2bc67f3e9bbed63e3074725bc5d234dc1d272f.1488504063.git.balaton@eik.bme.hu>
References: <cover.1488504063.git.balaton@eik.bme.hu>
	<0d2bc67f3e9bbed63e3074725bc5d234dc1d272f.1488504063.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 18:21:01 +0000
Message-ID: <CAFEAcA93+ZOSBwytLPtBgZ8DzPgwBrzpC0s1MZ0ff_KO+rb--A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 02/13] sm501: Use defined constants
 instead of literal values where available
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

On 3 March 2017 at 00:21, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>
> v3: Fix initial value of misc_control register as Peter Maydell suggested
>     Also use M_BYTE constant from cutils.h
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
