Received: from eggs.gnu.org ([2001:4830:134:3::10]:40710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckq0w-0003wn-2c
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 05:37:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckq0v-0001GE-Ai
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 05:37:14 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:37075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ckq0v-0001Fu-5S
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 05:37:13 -0500
Received: by mail-wm0-x22f.google.com with SMTP id n11so60515368wma.0
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 02:37:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3dd4ea3f9f4575144e1ce48390b463a6744da9c1.1488665935.git.balaton@eik.bme.hu>
References: <cover.1488665935.git.balaton@eik.bme.hu>
	<3dd4ea3f9f4575144e1ce48390b463a6744da9c1.1488665935.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Mar 2017 10:36:51 +0000
Message-ID: <CAFEAcA8R=YwrTBcfK98Hzh==mYkCLvnkSYmj9xoNfTGqbReyRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v4 04/13] sm501: QOMify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>

On 3 December 2016 at 02:05, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> Adding vmstate saving is not in this patch because the state structure
> will be changed in further patches, then another patch will add
> vmstate descriptor after those changes.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
