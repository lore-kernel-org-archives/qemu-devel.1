Received: from eggs.gnu.org ([2001:4830:134:3::10]:39572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dg4q9-0000o4-CE
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dg4q8-0000M0-K5
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:58:41 -0400
Date: Fri, 11 Aug 2017 15:58:32 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170811075832.GD27391@lemon.lan>
References: <20170810080108.31047-1-famz@redhat.com>
	<0892fdd2-4a24-8e8c-a283-3f22ad39b411@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0892fdd2-4a24-8e8c-a283-3f22ad39b411@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] file-posix: Clear out first sector in
 hdev_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xie Changlong <xiechanglong.d@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Fri, 08/11 15:44, Xie Changlong wrote:
> =E5=9C=A8 8/10/2017 4:01 PM, Fam Zheng =E5=86=99=E9=81=93:
> > People get surprised when, after "qemu-imc create -f raw /dev/sdX", t=
hey
>=20
> s/qemu-imc/qemu-img/

Thanks, will fix in v2.

Fam
