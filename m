Received: from eggs.gnu.org ([209.51.188.92]:50852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1gyzUM-0004ye-Oj
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:43:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1gyzN9-0005rZ-KL
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:35:45 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17701
	helo=sender1.zoho.com.cn)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fam@euphon.net>) id 1gyzN7-0005oR-RO
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:35:43 -0500
Date: Wed, 27 Feb 2019 21:35:09 +0800
From: Fam Zheng <fam@euphon.net>
Message-ID: <20190227133509.sd7luqap3bv66lxf@deb>
References: <20181031025712.18602-1-famz@redhat.com>
	<4f6eb24d-fe13-cbf3-907e-6b3e566e33f4@comstyle.com>
	<20181114095807.GB22784@magic> <20190109135504.GA12179@redhat.com>
	<20190109135917.GP3998@redhat.com>
	<A3EA5405-A5EE-4E77-8C77-A67398756B96@euphon.net>
	<20190114101515.GA3686@redhat.com>
	<20190122161236.GZ13143@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190122161236.GZ13143@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] tests: vm: auto_install OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Brad Smith <brad@comstyle.com>

On Tue, 01/22 16:12, Daniel P. Berrang=E9 wrote:
> > can't you just refresh that pre-built image to have SDL 2, based on you=
r
> > auto-install patches, so we don't have to wait for that to merge.
>=20
> Please could we just get this pre-built img updated so that we are
> not blocked on the SDL 1 removal anymore.

Oops. I was seriously distracted from the external mail folders recently..
Updated the image, please test it.

Fam
