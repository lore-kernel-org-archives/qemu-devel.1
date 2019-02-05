Received: from eggs.gnu.org ([209.51.188.92]:40060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqwnL-0002nW-Op
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 04:13:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqwnL-0005Fe-6k
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 04:13:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gqwnL-0005FO-0M
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 04:13:31 -0500
Date: Tue, 5 Feb 2019 10:13:28 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190205091328.x6z7vnafj7o33qm2@sirius.home.kraxel.org>
References: <20190128102605.15994-1-lhrazky@redhat.com>
	<20190204100810.14800-1-lhrazky@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190204100810.14800-1-lhrazky@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] spice: set device address and device
 display ID in QXL interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?THVrw6HFoSBIcsOhemvDvQ==?= <lhrazky@redhat.com>
Cc: qemu-devel@nongnu.org, spice-devel@lists.freedesktop.org

On Mon, Feb 04, 2019 at 11:08:10AM +0100, Luk=C3=A1=C5=A1 Hr=C3=A1zk=C3=BD=
 wrote:
> Calls the new SPICE QXL interface function spice_qxl_set_device_info to
> set the hardware address of the graphics device represented by the QXL
> interface (e.g. a PCI path) and the device display IDs (the IDs of the
> device's monitors that belong to this QXL interface).
>=20
> Also stops using the deprecated spice_qxl_set_max_monitors, the new
> interface function replaces it.
>=20
> Signed-off-by: Luk=C3=A1=C5=A1 Hr=C3=A1zk=C3=BD <lhrazky@redhat.com>

Added to UI patch queue.

thanks,
  Gerd
