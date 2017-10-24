Received: from eggs.gnu.org ([2001:4830:134:3::10]:48971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e78VJ-00031z-Hg
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 19:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e78VG-0003g8-D5
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 19:21:01 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171024122045.30072-5-f4bug@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue,
	24 Oct 2017 09:20:45 -0300")
References: <20171024122045.30072-1-f4bug@amsat.org>
	<20171024122045.30072-5-f4bug@amsat.org>
Reply-To: quintela@redhat.com
Date: Wed, 25 Oct 2017 01:20:50 +0200
Message-ID: <871slsnne5.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/4] vl: remove unnecessary #ifdef
 CONFIG_TPM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, "Richard W . M . Jones" <rjones@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Amarnath Valluri <amarnath.valluri@intel.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, =?utf-8?Q?Marc-Andr?= =?utf-8?Q?=C3=A9?= Lureau <marcandre.lureau@gmail.com>, "Dr . David Alan
	Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
> a stub is now provided.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Tested-by: Richard W.M. Jones <rjones@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
