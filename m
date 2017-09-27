Received: from eggs.gnu.org ([2001:4830:134:3::10]:41841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dxEa0-0002JM-Ir
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 11:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dxEZz-00010d-Oo
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 11:48:56 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:49189)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dxEZz-0000zd-HT
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 11:48:55 -0400
Received: by mail-wm0-x230.google.com with SMTP id r74so19926642wme.4
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 08:48:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170927093700.6058-1-cohuck@redhat.com>
References: <20170927093700.6058-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 27 Sep 2017 08:48:32 -0700
Message-ID: <CAFEAcA8ynyfCwxefYKTKgVF11Zx43_Cs4mYGVqF823=J=HBtPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL URGENT 0/1] another s390x compat fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, zyimin@linux.vnet.ibm.com, Halil Pasic <pasic@linux.vnet.ibm.com>

On 27 September 2017 at 02:36, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit 31bc1d8481af414cfa2857f905e40f7d8e6d5b2e:
>
>   Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetch' into staging (2017-09-26 19:49:08 +0100)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20170927
>
> for you to fetch changes up to 9dacc908462693719d84ec594e839434959cf6f1:
>
>   s390x/cpumodel: remove ais from z14 default model-> also for 2.10.1 (2017-09-27 11:13:32 +0200)
>
> ----------------------------------------------------------------
> Another s390x compat fix that should make it into 2.10.1.
>
> ----------------------------------------------------------------
>
> Christian Borntraeger (1):
>   s390x/cpumodel: remove ais from z14 default model-> also for 2.10.1
>
>  target/s390x/gen-features.c | 1 -
>  1 file changed, 1 deletion(-)
>

Applied, thanks.

-- PMM
