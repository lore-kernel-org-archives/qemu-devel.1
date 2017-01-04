Received: from eggs.gnu.org ([2001:4830:134:3::10]:56478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOhvz-0000hi-Cv
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 04:32:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOhvv-0001aQ-JB
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 04:32:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cOhvv-0001Zs-DW
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 04:32:35 -0500
Message-ID: <1483520102.5670.46.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 04 Jan 2017 09:55:02 +0100
In-Reply-To: <20161221003806.22412-1-samuel.thibault@ens-lyon.org>
References: <20161221003806.22412-1-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCHv4 0/3] Move getting XWindow ID from baum
 driver to graphical backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org

On Mi, 2016-12-21 at 01:38 +0100, Samuel Thibault wrote:
> Hello,
>=20
> This is a respin of moving getting XWindow ID from baum to actual
> graphical backends.  This only contains the new API, the move
> of existing code to the new API, and the addition of support for
> SDL2. Gtk will need more discussion and work.
>=20
> Compared to v3, this makes the API use a QemuConsole* parameter instead o=
f an
> integer index,

Added to ui queue.

thanks,
  Gerd
