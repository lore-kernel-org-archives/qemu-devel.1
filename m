Received: from eggs.gnu.org ([2001:4830:134:3::10]:48577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF5SS-00088d-Vg
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF5SP-0004oh-3m
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:47:28 -0400
Received: from [185.30.24.106] (port=22032
	helo=hotspot.internet-for-guests.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF5SH-0004Eh-Uv
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:47:21 -0400
Date: Tue, 23 Oct 2018 18:47:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181023184621-mutt-send-email-mst@kernel.org>
References: <20181011161820.38794-1-liq3ea@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181011161820.38794-1-liq3ea@163.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] piix_pci: change the i440fx data sheet
 link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>
Cc: marcel.apfelbaum@gmail.com, philmd@redhat.com, qemu-devel@nongnu.org

On Thu, Oct 11, 2018 at 09:18:20AM -0700, Li Qiang wrote:
> Seems the intel link is unavailable, change it to qemu site.
>=20
> Signed-off-by: Li Qiang <liq3ea@163.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

BTW you need to fix up your setup: patches you sent confuse git
am and other tools. Somethig to do with encoding.

> ---
>  hw/pci-host/piix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> index 0e608347c1..56a42055f1 100644
> --- a/hw/pci-host/piix.c
> +++ b/hw/pci-host/piix.c
> @@ -40,7 +40,7 @@
> =20
>  /*
>   * I440FX chipset data sheet.
> - * http://download.intel.com/design/chipsets/datashts/29054901.pdf
> + * https://wiki.qemu.org/File:29054901.pdf
>   */
> =20
>  #define I440FX_PCI_HOST_BRIDGE(obj) \
> --=20
> 2.17.1
>=20
>=20
