Received: from eggs.gnu.org ([2001:4830:134:3::10]:60769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1cwFLx-00085h-Hi
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 17:54:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1cwFLs-0004MR-NV
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 17:54:05 -0400
Message-ID: <1491515614.4166.126.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 07 Apr 2017 07:53:34 +1000
In-Reply-To: <78f1dc04-9c48-1870-9fdc-ff872fecd0de@kaod.org>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-5-git-send-email-clg@kaod.org>
	<20170406042318.GA12179@umbus>
	<6e24736f-5a64-ea4a-f9bb-6ebed5acca4a@kaod.org>
	<1491470207.4166.107.camel@kernel.crashing.org>
	<9a5826c0-5940-f668-fbef-f90f277408e0@kaod.org>
	<1491480116.4166.108.camel@kernel.crashing.org>
	<78f1dc04-9c48-1870-9fdc-ff872fecd0de@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/21] ppc/pnv: enable only one LPC bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Thu, 2017-04-06 at 14:35 +0200, C=C3=A9dric Le Goater wrote:
> but real HW (2 sockets OpenPOWER systems, garrison and firestone)
> does=C2=A0
> not expose the LPC bus on the second chip, should we do so in qemu ?

It's not so much HW as it it HostBoot. Not a huge deal.

Cheers,
Ben.
