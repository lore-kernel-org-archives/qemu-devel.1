Received: from eggs.gnu.org ([2001:4830:134:3::10]:55716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccCuL-0005Gh-35
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:14:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccCuK-0005OS-6m
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:14:45 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:37918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ccCuK-0005NT-0E
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:14:44 -0500
Received: by mail-wm0-x22b.google.com with SMTP id r141so51067606wmg.1
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 07:14:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486648058-520-1-git-send-email-clg@kaod.org>
References: <1486648058-520-1-git-send-email-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 15:14:22 +0000
Message-ID: <CAFEAcA_3WVww5Nnr7oBOAQtCFsZCUWNZQrEVivSJtay_Z9WkhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] aspeed: miscellaneous small fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 9 February 2017 at 13:47, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> Hello,
>
> Here is a short series fixing small issues in the SMC controller model
> of the Aspeed SoC.
>
> Thanks,
>
> C.
>
> C=C3=A9dric Le Goater (4):
>   aspeed: check for negative values returned by blk_getlength()
>   aspeed: remove useless comment on controller segment size
>   aspeed/smc: handle dummies only in fast read mode
>   aspeed/smc: use a modulo to check segment limits



Applied to target-arm.next, thanks.

-- PMM
