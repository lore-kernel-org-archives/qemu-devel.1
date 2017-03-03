Received: from eggs.gnu.org ([2001:4830:134:3::10]:37182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjs2A-0007VH-3z
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:34:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjs29-0007oy-B2
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:34:30 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:35035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjs29-0007oG-4i
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:34:29 -0500
Received: by mail-wr0-x22a.google.com with SMTP id g10so79297569wrg.2
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 10:34:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b819972a1e18972a95894c8ce91036200792062c.1488504063.git.balaton@eik.bme.hu>
References: <cover.1488504063.git.balaton@eik.bme.hu>
	<b819972a1e18972a95894c8ce91036200792062c.1488504063.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 18:34:07 +0000
Message-ID: <CAFEAcA-H8idiLw55T7g9buZEF8bqKb67Y2kcZ7t6i5vnKDMAuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 12/13] sm501: Add vmstate descriptor
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

On 25 February 2017 at 23:53, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>
> v3: Added local_mem_size_index to vmstate, add vmstate for sysbus version too
>
>  hw/display/sm501.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 99 insertions(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
