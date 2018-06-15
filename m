Received: from eggs.gnu.org ([2001:4830:134:3::10]:39305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTtOI-0006PQ-B4
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 14:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTtOH-0000Ef-IW
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 14:24:06 -0400
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:45078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTtOH-0000EY-CZ
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 14:24:05 -0400
Received: by mail-oi0-x22e.google.com with SMTP id 188-v6so9574873oid.12
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 11:24:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180615151518.83637-1-dgilbert@redhat.com>
References: <20180615151518.83637-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 19:23:44 +0100
Message-ID: <CAFEAcA-EdDsdxMOGFeuMZ1httwJZ_Ot5jnp-QgndrfV=ticjMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/10] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Greg Kurz <groug@kaod.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, xiaoguangrong@tencent.com, bala24@linux.vnet.ibm.com

On 15 June 2018 at 16:15, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 2702c2d3eb74e3908c0c5dbf3a71c8987595a86e:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-updates-140618-1' into staging (2018-06-15 12:49:36 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20180615a
>
> for you to fetch changes up to 650af8907bd567db914b7ce3a7e9df4c323f4619:
>
>   migration: calculate expected_downtime with ram_bytes_remaining() (2018-06-15 14:40:56 +0100)
>
> ----------------------------------------------------------------
> Migration pull 2018-06-15
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
