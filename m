Received: from eggs.gnu.org ([209.51.188.92]:38353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1v9u-0000oU-2q
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:42:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1v9t-0002oB-EU
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:42:10 -0500
Date: Thu, 7 Mar 2019 16:41:58 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190307154158.GI5786@linux.fritz.box>
References: <20190307145839.13128-1-philmd@redhat.com>
	<a7e51315-7b36-3bfd-9c78-296ba74614f7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <a7e51315-7b36-3bfd-9c78-296ba74614f7@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/4] tests: Allow use of Ports bash and
 GNU sed extensions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Kamil Rytarowski <n54@gmx.com>, Brad Smith <brad@comstyle.com>

Am 07.03.2019 um 16:27 hat Thomas Huth geschrieben:
> On 07/03/2019 15.58, Philippe Mathieu-Daud=E9 wrote:
> > Hi Thomas,
>=20
> ? -----^
>=20
> I could take the patch for tests/data/acpi/rebuild-expected-aml.sh
> through the qtests tree (if Michael or Igor don't want to take it), but
> the other patches are not related to qtests...

I can take them through my tree (two block patches, and multiboot is
effectively unmaintained and I've taken patches for it before). If you
post an Acked-by for the the ACPI one, I'll take the whole series (after
review, of course).

Kevin
