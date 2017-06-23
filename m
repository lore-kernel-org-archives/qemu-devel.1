Received: from eggs.gnu.org ([2001:4830:134:3::10]:33404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dOUta-0006Lp-MW
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 16:09:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dOUtX-0001Jf-HK
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 16:09:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dOUtX-0001Id-C2
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 16:09:31 -0400
References: <20170623164557.11636-1-f4bug@amsat.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <bd00ff8f-66cb-095e-4bed-0bec3e8a1dd6@redhat.com>
Date: Fri, 23 Jun 2017 22:09:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170623164557.11636-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>

On 06/23/17 18:45, Philippe Mathieu-Daud=C3=A9 wrote:
> Sorry to spam so many people, there is no entries in MAINTAINERS for
> hw/core/loader.c and hw/core/qdev.c, any volunters?
>=20
> Philippe Mathieu-Daud=C3=A9 (3):
>   elf-loader: warn about invalid endianess
>   hw/core: fix missing return value in load_image_targphys_as()
>   hw/core: report an error if invalid gpio is used
>=20
>  hw/core/loader.c | 5 ++++-
>  hw/core/qdev.c   | 6 +++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>=20

With the typo that Peter pointed out fixed:

series
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
