Received: from eggs.gnu.org ([2001:4830:134:3::10]:44137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cQunC-0006hK-Fm
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 06:40:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cQun8-00026J-AV
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 06:40:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cQun8-00025Z-00
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 06:40:38 -0500
Message-ID: <1484048435.19018.84.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 10 Jan 2017 12:40:35 +0100
In-Reply-To: <5aa28297d665cee24ddab26bbf4633e4252f97b6.1483978442.git.ossman@cendio.se>
References: <5aa28297d665cee24ddab26bbf4633e4252f97b6.1483978442.git.ossman@cendio.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] vnc: track LED state separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Ossman <ossman@cendio.se>
Cc: qemu-devel@nongnu.org

On Mo, 2017-01-09 at 17:14 +0100, Pierre Ossman wrote:
> Piggy-backing on the modifier state array made it difficult to send
> out updates at the proper times.
>=20
> Signed-off-by: Pierre Ossman <ossman@cendio.se>

Added to ui queue.

thanks,
  Gerd
