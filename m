Received: from eggs.gnu.org ([209.51.188.92]:37861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=005e97291=Peter.Chubb@data61.csiro.au>)
	id 1hHKph-0001Pb-Jn
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 00:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=005e97291=Peter.Chubb@data61.csiro.au>)
	id 1hHKfb-0000h0-48
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 23:58:36 -0400
From: "Chubb, Peter (Data61, Kensington NSW)" <Peter.Chubb@data61.csiro.au>
Date: Fri, 19 Apr 2019 03:58:17 +0000
Message-ID: <8436melk89.wl-Peter.Chubb@data61.csiro.au>
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-8-thuth@redhat.com>
In-Reply-To: <20190418180057.3593-8-thuth@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D4F06FF565C66F488BAC81E136EC975E@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 07/29] hw/arm: Express
 dependencies of the fsl-imx31 machine with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "yang.zhong@intel.com" <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, Antony Pavlov <antonynpavlov@gmail.com>, Peter Chubb <peter.chubb@nicta.com.au>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Cedric Le Goater <clg@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Rob Herring <robh@kernel.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Andrzej Zaborowski <balrogg@gmail.com>, John Snow <jsnow@redhat.com>, Joel Stanley <joel@jms.id.au>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe Mathieu-Daude <f4bug@amsat.org>, Alistair Francis <alistair@alistair23.me>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

>>>>> "Thomas" =3D=3D Thomas Huth <thuth@redhat.com> writes:

Thomas> Add Kconfig dependencies for the fsl-imx31 / kzm machine.
Thomas> This patch is slightly based on earlier work by =C1kos Kov=E1cs
Thomas> (i.e.  his "hw/arm/Kconfig: Add ARM Kconfig" patch).

Thomas> Signed-off-by: Thomas Huth <thuth@redhat.com>=20
Reviewed-by: Peter Chubb <peter.chubb@data61.csiro.au>
--
Dr Peter Chubb         Tel: +61 2 9490 5852      http://ts.data61.csiro.au/
Trustworthy Systems Group                     Data61, CSIRO (formerly NICTA=
)=
