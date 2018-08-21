Received: from eggs.gnu.org ([2001:4830:134:3::10]:34243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1frv74-0001Ln-C1
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 21:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1frv1D-0001DQ-1B
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 20:59:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42750 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1frv1C-0001DC-TD
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 20:59:34 -0400
Date: Tue, 21 Aug 2018 08:59:32 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180821005931.GJ10682@lemon.usersys.redhat.com>
References: <20180818015344.797-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180818015344.797-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] docker: Sort packages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On Fri, 08/17 22:53, Philippe Mathieu-Daud=E9 wrote:
> Trivial cleanup patches.
>=20
> Per the Docker recommendation, "this helps to avoid duplication of
> packages and make the list much easier to update. This also makes PRs
> a lot easier to read and review."
>=20
> Regards,
>=20
> Phil.
>=20
> Philippe Mathieu-Daud=E9 (4):
>   docker: Sort Fedora packages
>   docker: Sort Fedora packages (i386-cross)
>   docker: Sort Ubuntu packages
>   docker: Sort CentOS packages
>=20
>  tests/docker/dockerfiles/centos7.docker       |   2 +-
>  .../dockerfiles/fedora-i386-cross.docker      |   9 +-
>  tests/docker/dockerfiles/fedora.docker        | 102 ++++++++++++++----
>  tests/docker/dockerfiles/ubuntu.docker        |  61 +++++++++--
>  4 files changed, 141 insertions(+), 33 deletions(-)
>=20
> --=20
> 2.18.0
>=20

Queued, thanks.

Fam
