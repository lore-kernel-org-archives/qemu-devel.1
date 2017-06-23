Received: from eggs.gnu.org ([2001:4830:134:3::10]:49928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dPdzK-00014P-II
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 20:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dPdzH-0008Hu-F1
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 20:04:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dPdzH-0008HR-8p
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 20:04:11 -0400
From: "Eduardo Habkost" <ehabkost@redhat.com>
Date: Fri, 23 Jun 2017 16:45:57 -0300
Message-ID: <20170623194557.GD3038@localhost.localdomain>
References: <20170623164557.11636-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170623164557.11636-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] hw/core: minor fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Alistair Francis <alistair.francis@xilinx.com>

On Fri, Jun 23, 2017 at 01:45:54PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Sorry to spam so many people, there is no entries in MAINTAINERS for
> hw/core/loader.c and hw/core/qdev.c, any volunters?

I can apply them through my machine tree, if nobody else volunteers.

Do you have a simple way to trigger the error paths addressed by patches =
1/3
and 2/3?

--=20
Eduardo
