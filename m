Received: from eggs.gnu.org ([2001:4830:134:3::10]:40030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckpyF-0002h3-QN
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 05:34:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckpyF-0000U1-0f
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 05:34:27 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:38204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ckpyE-0000Tb-Qq
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 05:34:26 -0500
Received: by mail-wm0-x230.google.com with SMTP id t193so60406501wmt.1
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 02:34:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4bd61f7ecdba6f205e30f0b712c65036951f1375.1488665935.git.balaton@eik.bme.hu>
References: <cover.1488665935.git.balaton@eik.bme.hu>
	<4bd61f7ecdba6f205e30f0b712c65036951f1375.1488665935.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Mar 2017 10:34:05 +0000
Message-ID: <CAFEAcA_PY09pjLdQ4Kb2w-cywJUPRsLo5Wq9WPbVeR2-LHY+cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v4 06/13] sm501: Add emulation of chip
 connected via PCI
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

On 25 February 2017 at 18:31, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> Only the display controller part is created automatically on PCI
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
