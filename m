Received: from eggs.gnu.org ([209.51.188.92]:59361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwlvA-0001wv-Jz
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 05:49:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwlv9-0002aL-Nc
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 05:49:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gwlv9-0002ZV-H5
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 05:49:39 -0500
Date: Thu, 21 Feb 2019 11:49:37 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190221104937.b53wgu3no3molnpk@sirius.home.kraxel.org>
References: <cover.1550698466.git.DirtY.iCE.hu@gmail.com>
	<d23b1c134a97f8be492348c8b4f87a76b717eeff.1550698466.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d23b1c134a97f8be492348c8b4f87a76b717eeff.1550698466.git.DirtY.iCE.hu@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 01/14] qapi: qapi for audio backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>

On Wed, Feb 20, 2019 at 10:37:30PM +0100, K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1=
n wrote:
> This patch adds structures into qapi to replace the existing
> configuration structures used by audio backends currently. This qapi
> will be the base of the -audiodev command line parameter (that replaces
> the old environment variables based config).

Markus?  Eric?  Can I get an ack for this patch?

Series looks good to me overall, testing looks good too, I'd like to
merge it together with some other pending audio bits soonish.

thanks,
  Gerd
