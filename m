Received: from eggs.gnu.org ([209.51.188.92]:35703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwkTO-0007oy-Iz
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:16:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwkTJ-0004Kn-Bv
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:16:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gwkTD-0004Fb-Gw
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:16:45 -0500
Date: Thu, 21 Feb 2019 10:16:39 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190221091639.r2ziqdfisjhogwxg@sirius.home.kraxel.org>
References: <20190215095745.13614-1-lhrazky@redhat.com>
	<20190215150919.8263-1-lhrazky@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190215150919.8263-1-lhrazky@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5] spice: set device address and device
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

On Fri, Feb 15, 2019 at 04:09:19PM +0100, Luk=C3=A1=C5=A1 Hr=C3=A1zk=C3=BD=
 wrote:
> Calls the new SPICE QXL interface function spice_qxl_set_device_info to
> set the hardware address of the graphics device represented by the QXL
> interface (e.g. a PCI path) and the device display IDs (the IDs of the
> device's monitors that belong to this QXL interface).
>=20
> Also stops using the deprecated spice_qxl_set_max_monitors, the new
> interface function replaces it.

Added to UI queue.

thanks,
  Gerd
