Received: from eggs.gnu.org ([2001:4830:134:3::10]:40981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dTSQz-0000gz-NZ
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:32:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dTSQy-0002OD-QV
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:32:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dTSQy-0002O5-Ja
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:32:32 -0400
Date: Fri, 7 Jul 2017 13:32:21 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170707123221.GB18375@stefanha-x1.localdomain>
References: <cover.1499381754.git.alistair.francis@xilinx.com>
	<0a1d5638543965d532284bdc6fce391cf9f509d0.1499381754.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline
In-Reply-To: <0a1d5638543965d532284bdc6fce391cf9f509d0.1499381754.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH v1 3/6] Convert error_report() to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, philippe@mathieu-daude.net, berrange@redhat.com, armbru@redhat.com, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, Josh Durgin <jdurgin@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, Rob Herring <robh@kernel.org>, Peter Maydell <peter.maydell@linaro.org>, Peter Chubb <peter.chubb@nicta.com.au>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

trace/control.c and blockdev.c:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZX39VAAoJEJykq7OBq3PIx3IIAI+5kYBn3UlwvrS6ffizqsYj
rmx4lCWcAg6igZAqykfXeBY5Uw9pckKAjDN90yOFND1bEBn1qp1z0Wqr1AUOCfSa
MmHluVAACOveqLyKQvLo3DBDTaYItdK7X1eej4S9Cb2ZmyMBBHI9fNt/lnoS2Tx4
HpEARqRHSLJZcrO3gBGXLk5QUlG6iJ0ngRN7iKgff+hJqCfUKzlxbE+q0C6fTLNG
vy0+crDt4uOV+lXfPtvDmalIseA16lxMGBy3VteGxoAFy2owRiRzrrDelhVzW8yQ
iDVVhLPYmw0jH/jt+1C7SGNeRa0vRhIF1inEXmnnnCnvpYgeIm9PnFMbvbNvqNA=
=7kKL
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
