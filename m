Received: from eggs.gnu.org ([209.51.188.92]:52855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gqXT6-0003Xk-Ly
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 01:10:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gqXT6-0007ON-0W
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 01:10:56 -0500
Date: Mon, 4 Feb 2019 11:40:46 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20190204010904.GD2593@umbus.fritz.box>
Message-ID: <nycvar.YSQ.7.76.1902041138010.9424@xnncv>
References: <20190201185358.6972-1-ppandit@redhat.com>
	<20190204010904.GD2593@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] ppc: add host-serial and host-model
 machine attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Qemu Developers <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>

+-- On Mon, 4 Feb 2019, David Gibson wrote --+
| I'm wondering if we can just ditch them entirely, or at least make
| them default to not present without regard to machine version.

Ie. make the default behaviour host-serial/host-model=NULL/none, instead of 
'passthrough' now?

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
