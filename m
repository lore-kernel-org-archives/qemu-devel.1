Received: from eggs.gnu.org ([2001:4830:134:3::10]:58030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cdKIz-00008n-GV
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cdKIu-000567-F9
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:49 -0500
Received: from 11.mo4.mail-out.ovh.net ([46.105.34.195]:53965)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cdKIu-00055t-7B
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:44 -0500
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 952944A785
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 18:20:42 +0100 (CET)
References: <1486997062-23227-1-git-send-email-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <df53ac4c-81bd-c8be-5be8-478292c7c3f4@kaod.org>
Date: Mon, 13 Feb 2017 18:20:36 +0100
MIME-Version: 1.0
In-Reply-To: <1486997062-23227-1-git-send-email-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] aspeed/smc: add support for DMAs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 02/13/2017 03:44 PM, C=C3=A9dric Le Goater wrote:
> Hello,
>=20
> Here is a short series adding support for DMAs to the SMC controller
> of the Aspeed SoCs. It uses coroutines to spawn the DMA requests in
> bottom halves. This method is inspired from the block layer, the code
> looks nice but maybe, this is unnecessarily complex. Paolo, could you
> provide some feedback ?

I forgot the magic word here. Sorry about that. When ever you have some
time, please !

Thanks,

C.=20
