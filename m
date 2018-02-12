Received: from eggs.gnu.org ([2001:4830:134:3::10]:50697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1elDRe-0006qx-3s
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1elDRZ-00082x-2v
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:42:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51416 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1elDRY-00082I-TM
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:42:48 -0500
Date: Mon, 12 Feb 2018 20:42:46 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180212124246.GA7910@lemon.usersys.redhat.com>
References: <20180209145430.26007-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180209145430.26007-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v12 00/30] SDHCI: clean v1/2 Specs,
 UHS-I cards tuning sequence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org

On Fri, 02/09 11:54, Philippe Mathieu-Daud=E9 wrote:
> This series is expected to be taken by Paolo.
>=20
> It includes the last versions of both series:
> - SDHCI: clean v1/v2 Specs (part 2)
> - SDHCI: add tuning sequence for UHS-I cards (part 3)
>=20
> Since v11:
> - rebased due to conflict (IMX_USDHC fd1e5c817964)
> - QSDHCI uses union (Paolo)
> - do not enable UNIMP logging when running qtests
>=20
> Since v10:
> - rebased
> - add Paolo's R-b in patch 2
> - rename patch 11 subject (Alistair)
> - add Alistair's R-b in "UHS-I cards tuning sequence" patches

Hi Phil,

About the patchew confusion: I'm not sure why patch 11 never hit the arch=
ive, so
it was not picked up by patchew as well:

https://lists.gnu.org/archive/html/qemu-devel/2018-02/threads.html

Fam
