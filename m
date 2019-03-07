Received: from eggs.gnu.org ([209.51.188.92]:50281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1voz-0001Js-7y
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:24:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1voy-0003BF-Lf
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:24:37 -0500
Date: Thu, 7 Mar 2019 17:24:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190307162425.GK5786@linux.fritz.box>
References: <20190307145839.13128-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190307145839.13128-1-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/4] tests: Allow use of Ports bash and
 GNU sed extensions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kamil Rytarowski <n54@gmx.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Brad Smith <brad@comstyle.com>

Am 07.03.2019 um 15:58 hat Philippe Mathieu-Daud=E9 geschrieben:
> This series contains few script cleanups which help to
> run tests on OpenBSD.
> Note, this is a split of the previous series, here restricted
> to tests/.

Thanks, applied to the block branch.

Kevin
