Received: from eggs.gnu.org ([2001:4830:134:3::10]:48144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1exCbe-0007YY-0S
	for qemu-devel@nongnu.org; Sat, 17 Mar 2018 10:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1exCbd-0002hn-4D
	for qemu-devel@nongnu.org; Sat, 17 Mar 2018 10:14:45 -0400
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:43464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1exCbc-0002gn-Un
	for qemu-devel@nongnu.org; Sat, 17 Mar 2018 10:14:45 -0400
Received: by mail-oi0-x22d.google.com with SMTP id y27so6724798oix.10
	for <qemu-devel@nongnu.org>; Sat, 17 Mar 2018 07:14:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180316193315.6956-1-ehabkost@redhat.com>
References: <20180316193315.6956-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Mar 2018 14:14:23 +0000
Message-ID: <CAFEAcA8siA8xjvRVVcqYO=EENeRze31Qa6r1gehtoBvMeHPAHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] PC compat bug fix for v2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 16 March 2018 at 19:33, Eduardo Habkost <ehabkost@redhat.com> wrote:
> Dropped all the other commits from machine-next and kept only the
> bug fix below.
>
> The following changes since commit 2bb39a657abeac3f33ab3298177fb27c35f5b50a:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180316' into staging (2018-03-16 17:25:33 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to 0ab126f165b04cce4a6e641d6bfce2ffd8a7cf62:
>
>   pc: correct misspelled CPU model-id for pc 2.2 (2018-03-16 16:29:07 -0300)
>
> ----------------------------------------------------------------
> PC compat bug fix for 2.12
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
