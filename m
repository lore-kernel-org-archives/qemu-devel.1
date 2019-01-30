Received: from eggs.gnu.org ([209.51.188.92]:45847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gomW5-00072R-4h
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:50:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gomW1-0008MH-Nu
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:50:43 -0500
References: <20190130000653.16267-1-richardw.yang@linux.intel.com>
	<20190130000653.16267-2-richardw.yang@linux.intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <69177d59-02c9-c6cd-be5a-092bf2476af1@redhat.com>
Date: Wed, 30 Jan 2019 10:50:18 +0100
MIME-Version: 1.0
In-Reply-To: <20190130000653.16267-2-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/3] hw/i386/pc.c: remove unused
 function pc_acpi_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, philmd@redhat.com
Cc: imammedo@redhat.com, laurent@vivier.eu, mst@redhat.com

On 2019-01-30 01:06, Wei Yang wrote:
> Function pc_acpi_init() is not used anymore.
>=20
> Remove the definition and declaration.
>=20
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Reviewed-by: Philippe Mathieu-Daud=E8=8C=85 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=E8=8C=85 <philmd@redhat.com>

 Hi,

at least in my e-mail client here, it looks like Philippe's last name
got mojibaked here. It should be "Daud=C3=A9", not "Daud=E8=8C=85", as fa=
r as I know.
Same thing also happened in patch 2 and 3.

Apart from that:

Reviewed-by: Thomas Huth <thuth@redhat.com>
