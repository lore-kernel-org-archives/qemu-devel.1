Received: from eggs.gnu.org ([2001:4830:134:3::10]:44284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIX6S-0008Ho-J7
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 06:55:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIX4g-0000bp-KT
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 06:53:11 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:42976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIX4e-0000aL-RR
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 06:53:09 -0400
Received: by mail-ot1-x32f.google.com with SMTP id j3so1293035otl.9
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 03:53:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181031165725.61938-1-dgilbert@redhat.com>
References: <20181031165725.61938-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Nov 2018 10:52:47 +0000
Message-ID: <CAFEAcA_s=793rBgJzM4n62aGvDfA3U7DJeKhcQF5vB2C=15uvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>

On 31 October 2018 at 16:57, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit a2e002ff7913ce93aa0f7dbedd2123dce5f1a9cd:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/qemu-trivial-for-3.1-pull-request' into staging (2018-10-30 15:49:55 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20181031a
>
> for you to fetch changes up to 3d63da16fbcd05405efd5946000cdb45474a9bad:
>
>   migration: avoid segmentfault when take a snapshot of a VM which being migrated (2018-10-31 09:38:59 +0000)
>
> ----------------------------------------------------------------
> Minor migration fixes 2018-10-31
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
