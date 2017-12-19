Received: from eggs.gnu.org ([2001:4830:134:3::10]:46929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael.weiser@gmx.de>) id 1eROMP-00026D-5V
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 15:19:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael.weiser@gmx.de>) id 1eROMO-0008Ot-F3
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 15:19:33 -0500
Received: from heinz.dinsnail.net
	([2a01:238:43b4:3200:9392:5dcc:2f0e:a960]:47078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael.weiser@gmx.de>)
	id 1eROMO-0008Jz-4i
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 15:19:32 -0500
Date: Tue, 19 Dec 2017 21:15:58 +0100
From: Michael Weiser <michael.weiser@gmx.de>
Message-ID: <20171219201558.GA10647@weiser.dinsnail.net>
References: <20171219151636.5162-1-michael.weiser@gmx.de>
	<f30766d6-d2ac-e28e-d410-d57932c3b01f@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f30766d6-d2ac-e28e-d410-d57932c3b01f@vivier.eu>
Subject: Re: [Qemu-devel] [PATCH 0/4] Add aarch64_be-linux-user target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

Hello Laurent,

On Tue, Dec 19, 2017 at 05:17:35PM +0100, Laurent Vivier wrote:

> > below patches add support for big-endian aarch64 to linux-user. Almost

> Could you also update scripts/qemu-binfmt-conf.sh for the aarch64_be magic?

Done. v2 forthcoming.
-- 
Bye,
Michael
