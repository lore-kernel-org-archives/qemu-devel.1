Received: from eggs.gnu.org ([2001:4830:134:3::10]:48809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cwR8U-0000qY-Vn
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 06:28:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cwR8Q-00022e-Vt
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 06:28:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cwR8Q-00022P-Pv
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 06:28:54 -0400
Message-ID: <1491560929.26308.41.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 07 Apr 2017 12:28:49 +0200
In-Reply-To: <1491381329-3995-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1491381329-3995-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 00/14] TCX/CG3 adapter cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org

On Mi, 2017-04-05 at 09:35 +0100, Mark Cave-Ayland wrote:
> This started as part of the work on Gerd's thread-safe display patches
> but ended up turning into something a lot more comprehensive. It contains
> lots of cleanupm and fixes for display invalidation (particularly on 24-b=
it
> TCX) exposed by testing the thread-safe patchset.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Looks all fine to me.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

You'll merge them through the sparc queue I guess?

cheers,
  Gerd
