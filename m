Received: from eggs.gnu.org ([2001:4830:134:3::10]:52268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cdtrF-0003D6-8i
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 02:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cdtrB-0004S2-90
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 02:18:33 -0500
Received: from 1.mo178.mail-out.ovh.net ([178.33.251.53]:51622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cdtrB-0004RP-2C
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 02:18:29 -0500
Received: from player793.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 8B45F16591
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 08:18:26 +0100 (CET)
References: <1486994957-20400-1-git-send-email-clg@kaod.org>
	<1486994957-20400-2-git-send-email-clg@kaod.org>
	<20170214050219.GH2169@umbus.fritz.box>
	<32f762b6-0fc0-fd1f-d0f1-6265436c8274@kaod.org>
	<7cde2ccc-95cb-5ace-e50c-91095cc2c6b8@kaod.org>
	<20170215015957.GD12369@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6d5a6d3a-3cba-7238-8529-b1c88d5294e1@kaod.org>
Date: Wed, 15 Feb 2017 08:18:22 +0100
MIME-Version: 1.0
In-Reply-To: <20170215015957.GD12369@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] ppc/xics: remove set_nr_irqs() handler
 from XICSStateClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 02/15/2017 02:59 AM, David Gibson wrote:
> I don't think I'll want to merge until the full picture is addressed.
> However, I'm fine with posting incomplete versions for earlier review
> - just label them RFC and note in the 0/N comment that there's more
> work to be done to complete the picture.

OK. This is a good way to discuss. I will do my best.

Thanks,

C.
