Received: from eggs.gnu.org ([209.51.188.92]:39628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1glX1U-00076x-7e
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:41:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1glWv2-0006Np-NG
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:35:05 -0500
Date: Mon, 21 Jan 2019 10:35:01 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190121103501.GD30536@stefanha-x1.localdomain>
References: <20190115111007.27159-1-stefanha@redhat.com>
	<154803546492.5550.12597499001850601331@2d3111e9616b>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Content-Disposition: inline
In-Reply-To: <154803546492.5550.12597499001850601331@2d3111e9616b>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/2] qcow2: include LUKS
 payload overhead in qemu-img measure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 20, 2019 at 05:51:06PM -0800, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190115111007.27159-1-stefanha@redhat.com/
...
> /tmp/qemu-test/src/block/sheepdog.c: In function 'find_vdi_name':
> /tmp/qemu-test/src/block/sheepdog.c:1239:5: error: 'strncpy' specified bound 256 equals destination size [-Werror=stringop-truncation]
>      strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors

Wasn't me, I swear!

Stefan

--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcRaBVAAoJEJykq7OBq3PInrQIAKiABMaFNJdNk6gBwkcles6X
9NYb6N8AF8ZL5ghxLzvG1evMvYYpi3q1uhYJzxXKO1XsHzEnWE6uZ/qGG/UQWvMa
8e0OScHK8dpqsaHpzBA2hE5sKrvNywIsnykjNMVz1LtvrZfCL7Mhjd85z6lv/vhR
NtPS9mVoXQ8bEZPTYmMmdKIarQE8F4NcnQVxdtaGythlSXwJQdamWZn3Mz/Gwwi7
/C2LdL05ZHlKJEJzTjanZ07qpElkUmHYKqHG6fGAFGgBGaEVY60MADt1CrN6opP/
B9tyeW76YBRhZ36Ts9xQ/3FD69FpUvMXtxsbe2fTVS4J1UWURVOeFATtbXVKBg8=
=g3yF
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--
