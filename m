Received: from eggs.gnu.org ([2001:4830:134:3::10]:36156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1e6teh-0003E1-1b
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 03:29:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1e6ted-00044h-UL
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 03:29:43 -0400
Date: Tue, 24 Oct 2017 08:29:33 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20171024072856.GY18285@redhat.com>
References: <20171023213359.23025-1-f4bug@amsat.org>
	<20171023213359.23025-4-f4bug@amsat.org>
	<20171023213732.GX18285@redhat.com>
	<4a8ab2c3-0576-9c8e-d6c7-8353337fdbe1@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <4a8ab2c3-0576-9c8e-d6c7-8353337fdbe1@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] vl: remove unnecessary #ifdef
 CONFIG_TPM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>

On Mon, Oct 23, 2017 at 11:33:31PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi Richard,
>=20
> On 10/23/2017 06:37 PM, Richard W.M. Jones wrote:
> > The series fixes the build for me, thanks :-)
>=20
> Good, does this mean I can add your Tested-by: tag?

Sure,

Tested-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
