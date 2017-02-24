Received: from eggs.gnu.org ([2001:4830:134:3::10]:43349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chGsz-00061f-OM
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:30:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chGsz-0005dF-2D
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:30:17 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:35669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chGsy-0005cW-TM
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:30:17 -0500
Received: by mail-wm0-x235.google.com with SMTP id v186so15917424wmd.0
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 06:30:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5b3304341ddd333f929a6587e019c21a16a08c8e.1487522123.git.balaton@eik.bme.hu>
References: <cover.1487522123.git.balaton@eik.bme.hu>
	<5b3304341ddd333f929a6587e019c21a16a08c8e.1487522123.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 14:29:55 +0000
Message-ID: <CAFEAcA_SOSFTzGSXEnuqbS8A=9U=id6kY0x6CqNaaYGgA2KL1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 01/10] sm501: Fixed code style and a few
 typos in comments
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

On 19 February 2017 at 16:35, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/sm501.c          | 1132 ++++++++++++++++++++++---------------------
>  hw/display/sm501_template.h |   52 +-
>  2 files changed, 594 insertions(+), 590 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(checked the ignore-whitespace-only diff.)

thanks
-- PMM
