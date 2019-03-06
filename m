Received: from eggs.gnu.org ([209.51.188.92]:37694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1ckl-00048V-N4
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 15:03:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1ckk-0001Hz-M6
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 15:02:59 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:33315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1ckk-0001HT-Dc
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 15:02:58 -0500
Received: by mail-oi1-x22a.google.com with SMTP id z14so10936330oid.0
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 12:02:58 -0800 (PST)
MIME-Version: 1.0
References: <20190306184101.9974-1-ehabkost@redhat.com>
In-Reply-To: <20190306184101.9974-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Mar 2019 20:02:45 +0000
Message-ID: <CAFEAcA-wBKkmqE_W65y32ekyjZjCtLDVE7gYskf3ORVFL=hUCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] Machine queue, 2019-03-06
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, 6 Mar 2019 at 18:41, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 9b748c5e061b1202fba59afd857e16a693743d90:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-request' into staging (2019-03-06 11:58:10 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to 14405c274e86e993e90198a49eecab3ca0ded8db:
>
>   qdev: Provide qdev_get_bus_hotplug_handler() (2019-03-06 11:51:08 -0300)
>
> ----------------------------------------------------------------
> Machine queue, 2019-03-06
>
> * qdev: Hotplug handler chaining (David Hildenbrand)
> * qdev: fix qbus_is_full() (Tony Krowiak)
> * hostmem: fix crash when querying empty host-nodes property via
>   QMP (Igor Mammedov)
>
Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
