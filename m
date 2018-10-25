Received: from eggs.gnu.org ([2001:4830:134:3::10]:39103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gFhIr-0001Np-BM
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 11:12:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gFhIq-0003Uf-NG
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 11:12:05 -0400
MIME-Version: 1.0
References: <1539261534-2795-1-git-send-email-liq3ea@gmail.com>
	<9d750f50-3692-8376-6b04-34b1c3991b15@vivier.eu>
In-Reply-To: <9d750f50-3692-8376-6b04-34b1c3991b15@vivier.eu>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 25 Oct 2018 23:11:24 +0800
Message-ID: <CAKXe6SKbUkfHtx8EFuq=8c97nxntOpO3WTESQr4X6ngciQ+9jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] piix: use TYPE_FOO
 constants than string constats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: laurent@vivier.eu
Cc: mst@redhat.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-trivial@nongnu.org, Qemu Developers <qemu-devel@nongnu.org>

Hello Laurent,
Thanks,

This patch has been in Michael's pull request.
Maybe you can drop it.

Thanks,
Li Qiang



Laurent Vivier <laurent@vivier.eu> =E4=BA=8E2018=E5=B9=B410=E6=9C=8825=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=889:52=E5=86=99=E9=81=93=EF=BC=9A

> On 11/10/2018 13:38, Li Qiang wrote:
> > Make them more QOMConventional.
> > Cc:qemu-trivial@nongnu.org
> >
> > Signed-off-by: Li Qiang <liq3ea@gmail.com>
> > ---
> >  hw/pci-host/piix.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
>
> Applied,
>
> Thanks,
> Laurent
>
