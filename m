Received: from eggs.gnu.org ([2001:4830:134:3::10]:36752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g9pPR-0005vy-M1
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 06:38:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g9pPP-0002DP-MV
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 06:38:37 -0400
MIME-Version: 1.0
References: <1539080467-2976-1-git-send-email-liq3ea@gmail.com>
	<CAFEAcA9HOhtPbAOrbvRQfrnfcq14WuW+a5w=EXG3+-9t6Wfx5Q@mail.gmail.com>
In-Reply-To: <CAFEAcA9HOhtPbAOrbvRQfrnfcq14WuW+a5w=EXG3+-9t6Wfx5Q@mail.gmail.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 9 Oct 2018 18:37:56 +0800
Message-ID: <CAKXe6SJGpJVeaqs5boqWZqtVjKornk6TEEWhUd7TFnnfb-eOSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] memory.h: fix types in comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, qemu-trivial@nongnu.org

Peter Maydell <peter.maydell@linaro.org> =E4=BA=8E2018=E5=B9=B410=E6=9C=889=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=886:26=E5=86=99=E9=81=93=EF=BC=
=9A

> On 9 October 2018 at 11:21, Li Qiang <liq3ea@gmail.com> wrote:
> > Signed-off-by: Li Qiang <liq3ea@gmail.com>
> > ---
> >  include/exec/memory.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> Thanks. Contents of patch
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> but the commit message should say "fix typos", not "fix types"
> (a 'typo' is a typing mistake; a 'type' is something like "uint32_t".)
>
>
Indeed, hope the maintainer can fix this typo when queuing this patch, :)

In additon, Cc: qemu-trivial@nongnu.org


>
> thanks
> -- PMM
>
