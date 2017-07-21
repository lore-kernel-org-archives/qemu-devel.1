Received: from eggs.gnu.org ([2001:4830:134:3::10]:55940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dYUnM-0000dG-LO
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dYUnJ-0005R6-El
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:04:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dYUnJ-0005Qm-8k
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:04:25 -0400
Message-ID: <1500631461.12926.5.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 21 Jul 2017 12:04:21 +0200
In-Reply-To: <3e0f92ea-58ce-abfb-1aed-4d56c1fa68b2@redhat.com>
References: <1500470414-7911-1-git-send-email-zuban32s@gmail.com>
	<1500533554.6553.1.camel@redhat.com>
	<3e0f92ea-58ce-abfb-1aed-4d56c1fa68b2@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [SeaBIOS] [RFC PATCH 0/2] Allow RedHat PCI bridges
 reserve more buses than necessary during init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, Aleksandr Bezzubikov <zuban32s@gmail.com>, seabios@seabios.org
Cc: qemu-devel@nongnu.org

  Hi,

> > What about window sizes?=C2=A0=C2=A0IIRC there was a plan to provide
> > allocation
> > hints for them too ...
>=20
> Yes, is in my TODO list, however not as part of Aleksandr's series
> which aims to provide PCIe-PCI bridge hotplug support.

I'd prefer to have a single vendor capability for all resource
allocation hints provided by qemu.

cheers,
  Gerd
